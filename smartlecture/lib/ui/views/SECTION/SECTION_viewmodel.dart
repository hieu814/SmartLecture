import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/Item.dart';
import 'package:smartlecture/models/Lecture.dart';
import 'package:smartlecture/models/Section.dart';
import 'package:smartlecture/models/UserLectures.dart';
import 'package:smartlecture/models/common/SectionIndex..dart';
import 'package:smartlecture/models/user.dart';
import 'package:smartlecture/services/authenticate.dart';
import 'package:smartlecture/ui/modules/UserService.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:stacked/stacked.dart';
import 'package:smartlecture/models/Page.dart' as p;

var db = FireStoreUtils.firestore;

class SectionViewModel extends BaseViewModel {
  Lecture _lecture;
  Lecture example;
  SectionIndex _currentIndex;
  bool _loading;
  User currentUser;
  String uid;
  UserLecture myLectures;
  get loadData => _loading;
  get currentIndex => _currentIndex;
  get lecture => _lecture;
  SectionViewModel({this.uid}) {
    _loading = false;
    _lecture = new Lecture();
    myLectures = new UserLecture(lectures: []);
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
  }

  void setPage(p.Page t) {
    _lecture.section[_currentIndex.currentSectionIndex]
        .page[_currentIndex.currentPageIndex] = t;
  }

  void setModelBusy() {
    setBusy(false);
  }

  Future<String> getJson(String name) async {
    //String path = 'assets\\lectures\\data_sample\\$name.json';
    return rootBundle.loadString('assets/lectures/data_sample/$name.json');
  }

  void addComponent(Type type) async {
    String data = await getJson(typeName.reverse[type]);
    Item t = Item.fromJson(json.decode(data)["ITEM"]);
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

  addPage() async {
    await getJson("lecture").then((value) {
      Lecture example = Lecture.fromJson(json.decode(value)["LECTURE"]);
      p.Page t = example.section.first.page.first;
      t.id =
          _lecture.section[_currentIndex.currentSectionIndex].page.length ?? 0;
      _lecture.section[_currentIndex.currentSectionIndex].page.add(t);
    });

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
    DocumentSnapshot doc =
        await db.collection(USER_LECTUTES).doc(currentUser.userID).get();
    if (doc != null && doc.exists) {
      myLectures = UserLecture.fromMap(doc.data());
      myLectures.lectures.add(ltID);
    } else {
      myLectures.lectures.add(ltID);
    }
    db
        .collection(USER_LECTUTES)
        .doc(currentUser.userID)
        .set(myLectures.toMap());
  }

  addLectures() async {
    try {
      DocumentReference docRef =
          await db.collection(LECTUTES).add(_lecture.toJson());
      if (docRef != null) {
        updateMyLectures(docRef.id);
      }
    } catch (ex) {
      print("exception");
      print(ex.toString());
    }
  }

  void deleteSection() async {
    if (_lecture.section.length > 1) {
      _lecture.section.removeAt(_currentIndex.currentSectionIndex);
    } else {
      await addSection("Trang mới")
          .then((value) => {_lecture.section.removeAt(0)});
    }
    setCurrenindex(SectionIndex(
        currentPageIndex: 0,
        currentSectionIndex: _currentIndex.currentSectionIndex > 0
            ? _currentIndex.currentSectionIndex--
            : 0));

    notifyListeners();
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
        currentPageIndex: _currentIndex.currentPageIndex--,
        currentSectionIndex: _currentIndex.currentSectionIndex));
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
    UserService _userService = locator<UserService>();
    currentUser = await _userService.getUser();
    await getJson("lecture").then((value) {
      example = Lecture.fromJson(json.decode(value)["LECTURE"]);
    });
    setBusy(true);

    //notifyListeners();
  }

  void dispose() {
    print("dispose SectionViewModel");
    super.dispose();
  }
}
