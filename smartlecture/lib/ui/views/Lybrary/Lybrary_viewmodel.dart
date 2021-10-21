import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/admin_model/Contribute.dart';
import 'package:smartlecture/models/admin_model/Lybrary.dart';
import 'package:smartlecture/models/lecture_model/Lecture.dart';
import 'package:smartlecture/models/lecture_model/LectuteData.dart';
import 'package:smartlecture/models/lecture_model/Section.dart';
import 'package:smartlecture/models/user_model/UserLectures.dart';
import 'package:smartlecture/models/user_model/user.dart';
import 'package:smartlecture/services/authenticate.dart';
import 'package:smartlecture/services/helper.dart';
import 'package:smartlecture/ui/modules/UserService.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:smartlecture/widgets/popup/popup.dart';

var db = FireStoreUtils.firestore;

class LibraryViewModel extends ChangeNotifier {
  UserLecture _myLectures;
  List<LectuteData> _listMylecture = <LectuteData>[];
  List<Contribute> _listLybrary = <Contribute>[];
  User _user;
  User get user => _user;
  UserLecture get mylectutes => _myLectures;
  List<LectuteData> get items => _listMylecture;
  List<Contribute> get itemsLybrary => _listLybrary;
  LibraryViewModel() {
    _user = new User();
  }
  Future<void> getdataLybrary(String path) async {
    print("getdataLybrary path $path");
    List<LectureDataStore> list = [];
    QuerySnapshot querySnapshot =
        await db.collection(FOLDER).doc(path).collection(CONTRIBUTE).get();
    if (true) {
      list = querySnapshot.docs.map((DocumentSnapshot doc) {
        LectureDataStore data = LectureDataStore.fromMap(doc.data());
        return LectureDataStore.fromMap(doc.data());
      }).toList();
      _listLybrary.clear();

      list.forEach((element) async {
        Contribute a;
        a = await loadLibraryData(element.contributeId);
        if (a != null) {
          _listLybrary.add(a);
          notifyListeners();
        }
      });
    }
  }

  Future<Contribute> loadLibraryData(String id) async {
    print("   loadLibraryData id $id");
    Contribute a;
    DocumentSnapshot documentSnapshot =
        await FireStoreUtils.firestore.collection(CONTRIBUTE).doc(id).get();
    if (documentSnapshot != null && documentSnapshot.exists) {
      print("   loadLibraryData --- " + documentSnapshot.data().toString());
      a = Contribute.fromJson(documentSnapshot.data());
      return a;
    }
    return null;
  }

  Future<void> loadAll() async {
    _listMylecture.clear();
    _myLectures.lectures.forEach((element) async {
      Lecture a;
      a = await loadLecture(element);
      if (a != null) {
        _listMylecture.add(LectuteData(id: element, lecture: a));
        notifyListeners();
      }
    });
  }

  Future<Lecture> loadLecture(String id) async {
    Lecture a;
    DocumentSnapshot documentSnapshot =
        await FireStoreUtils.firestore.collection(LECTUTES).doc(id).get();
    if (documentSnapshot != null && documentSnapshot.exists) {
      try {
        a = Lecture.fromJson(documentSnapshot.data());
      } catch (e) {
        print("loadLecture err: " + e.toString());
        return null;
      }

      return a;
    }
    return null;
  }

  Future<void> download(BuildContext context, int index) async {
    print("download");
    String dir = await createFolderInAppDocDir("lectures");
    String path = dir + _listMylecture[index].lecture.title + ".json";
    File _file = File(path);
    if (await _file.exists()) {
      popupYesNo(context, title: "File đã tồn tại \nGhi đè?").then((value) {
        if (value) {
          _file.writeAsString(
              json.encode(toJson(_listMylecture[index].lecture)));
        }
      });
    } else {
      _file.writeAsString(json.encode(toJson(_listMylecture[index].lecture)));
    }
  }

  Map<String, dynamic> toJson(Lecture _lecture) => {
        "LECTURE": _lecture.toJson(),
      };
  Future load() async {
    //setBusy(true);
    print("---load");
    try {
      UserService _userService = locator<UserService>();
      _user = await _userService.getUser();
      DocumentSnapshot doc =
          await db.collection(USER_LECTUTES).doc(_user.userID).get();
      if (doc != null && doc.exists) {
        _myLectures = UserLecture.fromMap(doc.data());
      } else {}
      _listMylecture.clear();
      await loadAll();
    } catch (e) {
      print("load err: " + e.toString());
    }
    print("");
    print("---load end");
    notifyListeners();
  }
}
