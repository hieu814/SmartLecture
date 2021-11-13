import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/admin_model/ImageStore.dart';
import 'package:smartlecture/models/lecture_model/Item.dart';
import 'package:smartlecture/models/lecture_model/Lecture.dart';
import 'package:smartlecture/models/lecture_model/LectuteData.dart';
import 'package:smartlecture/models/lecture_model/Section.dart';
import 'package:smartlecture/models/user_model/UserLectures.dart';
import 'package:smartlecture/models/common/SectionIndex..dart';
import 'package:smartlecture/models/user_model/user.dart';
import 'package:smartlecture/services/authenticate.dart';
import 'package:smartlecture/services/helper.dart';
import 'package:smartlecture/ui/modules/Setting.dart';

import 'package:smartlecture/ui/modules/UserService.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/models/lecture_model/Page.dart' as p;

var db = FireStoreUtils.firestore;

class SectionViewModel with ChangeNotifier {
  Lecture _lecture;
  Lecture example;
  SectionIndex _currentIndex;
  bool _loading;
  User currentUser;
  String uid = "";
  bool _isBusy;
  MyLectures myLectures;
  bool _isSaveToserver = false;
  get loadData => _loading;
  get currentIndex => _currentIndex;
  get lecture => _lecture;
  get isBusy => _isBusy;
  get currentSection => _currentIndex.currentSectionIndex;
  get currentPage => _currentIndex.currentPageIndex;
  get currentItem => _currentIndex.currentItemIndex;
  SectionViewModel({LectuteData data}) {
    _isBusy = false;
    _loading = false;
    _lecture = data.lecture;
    _isSaveToserver = data.isSaveToServer;
    uid = data.id;
    myLectures = new MyLectures(lectures: []);
    load();
    _currentIndex = new SectionIndex(
        currentPageIndex: 0, currentSectionIndex: 0, currentItemIndex: 0);
  }
  void setCurrenindex(SectionIndex index) {
    if (index.currentPageIndex >= 0) {
      if (_currentIndex.currentPageIndex <
          _lecture.section[_currentIndex.currentSectionIndex].page.length) {
        _currentIndex.currentPageIndex = index.currentPageIndex;
      } else {
        _currentIndex.currentPageIndex =
            _lecture.section[_currentIndex.currentSectionIndex].page.length - 1;
      }
    }
    if (index.currentSectionIndex >= 0) {
      if (_currentIndex.currentSectionIndex < _lecture.section.length) {
        _currentIndex.currentSectionIndex = index.currentSectionIndex;
      } else {
        _currentIndex.currentSectionIndex = _lecture.section.length - 1;
      }
    }
    if (index.currentItemIndex >= 0) {
      if (_currentIndex.currentItemIndex <
          _lecture.section[_currentIndex.currentSectionIndex]
              .page[_currentIndex.currentPageIndex].items.item.length) {
        _currentIndex.currentItemIndex = index.currentItemIndex;
      } else {
        _currentIndex.currentItemIndex = _lecture
                .section[_currentIndex.currentSectionIndex]
                .page[_currentIndex.currentPageIndex]
                .items
                .item
                .length -
            1;
      }
    }
    notifyListeners();
  }

  void setPage(p.Page t) {
    _lecture.section[_currentIndex.currentSectionIndex]
        .page[_currentIndex.currentPageIndex] = t;
  }

  void setModelBusy() {
    //setBusy(false);
  }
  setLecture(LectuteData data) {
    _lecture = data.lecture;
    uid = data.id ?? "";
  }

  Future<String> getJson(String name) async {
    //String path = 'assets\\lectures\\data_sample\\$name.json';
    return rootBundle.loadString('assets/lectures/data_sample/$name.json');
  }

  Future<void> addComponent(Type type) async {
    final name = typeName.reverse[type];
    Item t = Item();
    print("addComponent: name : $name");

    await getJson(name).then((value) {
      t = Item.fromJson(json.decode(value)["ITEM"]);
    });

    String data = await getJson(typeName.reverse[type]);
    //Item t = Item.fromJson(json.decode(data)["ITEM"]);
    _lecture.section[_currentIndex.currentSectionIndex]
        .page[_currentIndex.currentPageIndex].items.item
        .add(t);
    notifyListeners();
  }

  Future<void> addSection(String title) async {
    await getJson("lecture").then((value) {
      Lecture example = Lecture.fromJson(json.decode(value)["LECTURE"]);
      Section t = example.section.first;
      t.id = _lecture.section.length ?? 0;
      t.title = title;
      _lecture.section.add(t);
    });
    notifyListeners();
  }

  Future<void> addPage() async {
    setBusy(true);
    await getJson("lecture").then((value) {
      Lecture example = Lecture.fromJson(json.decode(value)["LECTURE"]);
      p.Page t = example.section.first.page.first;
      t.id =
          _lecture.section[_currentIndex.currentSectionIndex].page.length ?? 0;
      _lecture.section[_currentIndex.currentSectionIndex].page.add(t);
    });
    notifyListeners();
  }

  void changeBackgroundImage(String url, int type) {
    if (url == "") return;
    if (type == 0) {
      _lecture.section[_currentIndex.currentSectionIndex]
          .page[_currentIndex.currentPageIndex].backgroundImage = url;
    }
  }

  setlecture(Lecture a) {
    _lecture = a ?? example;
  }

  setBusy(bool t) {
    _isBusy = t;
    notifyListeners();
  }

  modifyTitle(String title, int id) {
    if (id == 0) {
      _lecture.title = title;
    } else if (id == 1) {
      _lecture.section[_currentIndex.currentSectionIndex].title = title;
    } else {
      _lecture.section[_currentIndex.currentSectionIndex]
          .page[_currentIndex.currentPageIndex].title = title;
    }
    notifyListeners();
  }

//---------------- firebase
  updateMyLectures(String ltID) async {
    currentUser = await locator<UserService>().getUser();
    DocumentSnapshot doc =
        await db.collection(USER_LECTUTES).doc(currentUser.userID).get();
    if (doc != null && doc.exists) {
      myLectures = MyLectures.fromMap(doc.data());
      if (!myLectures.lectures.contains(uid)) myLectures.lectures.add(ltID);
    } else {
      if (!myLectures.lectures.contains(uid)) myLectures.lectures.add(ltID);
    }
    db
        .collection(USER_LECTUTES)
        .doc(currentUser.userID)
        .set(myLectures.toMap())
        .catchError((error) =>
            print("-----------------updateMyLectures error: " + error));
  }

  Future saveData() async {
    try {
      String dir = await createFolderInAppDocDir("lectures");
      String path = dir + _lecture.title + ".json";

      await locator<MySetting>().load();
      bool isNull = uid == null || uid == "";
      print("update data to server is null $isNull");
      if (locator<MySetting>().isSync) {
        if (isNull) {
          String idlt = await addLectures();
          uid = idlt;

          path = dir + idlt + "_" + _lecture.title + ".json";
          print("update data to server  new path " + path);
        } else {
          print("save data id: $uid");
          await db.collection(LECTUTES).doc(uid).set(_lecture.toJson());
          updateMyLectures(uid);
        }
      }
      path = dir + uid + "_" + _lecture.title + ".json";
      File _file = File(path);
      _file.writeAsString(json.encode(toJson()));
    } catch (ex) {
      print("-----------------saveData exception");
      print(ex.toString());
    }
  }

  uploadImage(String path, String url) async {
    try {
      ImageStore data = ImageStore();
      currentUser = await locator<UserService>().getUser();
      data.userID = currentUser.userID;
      data.createDate =
          DateFormat('hh:mm:ss MM-dd-yyyy').format(DateTime.now());
      db.collection(FOLDER).doc(path).collection(IMAGES).add(data.toMap());
    } catch (e) {}
  }

  Map<String, dynamic> toJson() => {
        "LECTURE": _lecture.toJson(),
      };

  Future<String> addLectures() async {
    try {
      print("-----------------addLectures");
      DocumentReference docRef =
          await db.collection(LECTUTES).add(_lecture.toJson());
      if (docRef != null) {
        uid = docRef.id;
        _lecture.id = uid;
        updateMyLectures(docRef.id);
        return uid;
      }
    } catch (ex) {
      print(ex.toString());
    }
  }

  Future deleteSection() async {
    setCurrenindex(SectionIndex(
        currentPageIndex: 0,
        currentSectionIndex: _currentIndex.currentSectionIndex - 1));
    if (_lecture.section.length > 1) {
      _lecture.section.removeAt(_currentIndex.currentSectionIndex + 1);
    } else {
      await addSection("Trang mới")
          .then((value) => {_lecture.section.removeAt(0)});
    }

    //notifyListeners();
  }

  void deletePage() async {
    if (_lecture.section[_currentIndex.currentSectionIndex].page.length > 1) {
      _lecture.section[_currentIndex.currentSectionIndex].page
          .removeAt(_currentIndex.currentPageIndex);
    } else {
      await addPage().then((value) => {
            _lecture.section[_currentIndex.currentSectionIndex].page.removeAt(0)
          });
    }
    setCurrenindex(SectionIndex(
        currentPageIndex: _currentIndex.currentPageIndex - 1,
        currentSectionIndex: _currentIndex.currentSectionIndex));
    notifyListeners();
  }

  void deleteItem() async {
    if (_lecture.section[_currentIndex.currentSectionIndex].page.length > 1) {
      _lecture.section[_currentIndex.currentSectionIndex]
          .page[_currentIndex.currentPageIndex].items.item
          .removeAt(_currentIndex.currentItemIndex);
    }
    setCurrenindex(SectionIndex(
        currentPageIndex: _currentIndex.currentPageIndex,
        currentSectionIndex: _currentIndex.currentSectionIndex,
        currentItemIndex: 0));
    notifyListeners();
  }

  void updateAudio(String url) async {
    if (_lecture.section[_currentIndex.currentSectionIndex].page.length > 1) {
      Item a = _lecture
          .section[_currentIndex.currentSectionIndex]
          .page[_currentIndex.currentPageIndex]
          .items
          .item[_currentIndex.currentItemIndex];
      a.audio.url = url;
      _lecture
          .section[_currentIndex.currentSectionIndex]
          .page[_currentIndex.currentPageIndex]
          .items
          .item[_currentIndex.currentItemIndex] = a;
    }
    // setCurrenindex(SectionIndex(
    //     currentPageIndex: _currentIndex.currentPageIndex,
    //     currentSectionIndex: _currentIndex.currentSectionIndex,
    //     currentItemIndex: 0));
    notifyListeners();
  }

  Future getLecture(String id) async {
    Lecture a;
    DocumentSnapshot documentSnapshot =
        await FireStoreUtils.firestore.collection(LECTUTES).doc(uid).get();
    if (documentSnapshot != null && documentSnapshot.exists) {
      a = Lecture.fromJson(documentSnapshot.data());
    }
    setlecture(a);
  }

  Future load() async {
    currentUser = await locator<UserService>().getUser();
    DocumentSnapshot doc =
        await db.collection(USER_LECTUTES).doc(currentUser.userID).get();
    if (doc != null && doc.exists) {
      myLectures = MyLectures.fromMap(doc.data());
    } else {
      myLectures = new MyLectures(lectures: []);
    }
    if (myLectures.lectures == null) myLectures.lectures = [];
  }

  void dispose() {
    print("dispose SectionViewModel");
    super.dispose();
  }
}
