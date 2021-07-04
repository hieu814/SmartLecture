import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/lecture_model/Lecture.dart';
import 'package:smartlecture/models/lecture_model/LectuteData.dart';
import 'package:smartlecture/models/lecture_model/Section.dart';
import 'package:smartlecture/models/user_model/UserLectures.dart';
import 'package:smartlecture/models/user_model/user.dart';
import 'package:smartlecture/services/authenticate.dart';
import 'package:smartlecture/ui/modules/UserService.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

var db = FireStoreUtils.firestore;

class HomeViewModel extends ChangeNotifier {
  UserLecture _myLectures;
  List<LectuteData> _listMylecture = <LectuteData>[];
  User _user;
  User get user => _user;
  UserLecture get mylectutes => _myLectures;
  List<LectuteData> get items => _listMylecture;
  HomeViewModel() {
    _user = new User();
  }
  Future<void> more() async {
    String js = '["asd","asdasd","asdads"]';

    List<String> a = ["asd", "asdasd", "asdads"];
    String jsonUser = jsonEncode(a);
    print(jsonUser.toString());
  }

  logout() async {
    // _user.active = false;
    // user.lastOnlineTimestamp = Timestamp.now();
    //FireStoreUtils.updateCurrentUser(_user);
    await auth.FirebaseAuth.instance.signOut();
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

  Future<String> getJson(String name) async {
    return rootBundle.loadString('assets/lectures/data_sample/$name.json');
  }

  Future<Lecture> addNewLecture() {
    return getJson("lecture").then((value) {
      Lecture example = Lecture.fromJson(json.decode(value)["LECTURE"]);
      return example;
    });
  }

  Future<Lecture> loadLecture(String id) async {
    Lecture a;
    DocumentSnapshot documentSnapshot =
        await FireStoreUtils.firestore.collection(LECTUTES).doc(id).get();
    if (documentSnapshot != null && documentSnapshot.exists) {
      a = Lecture.fromJson(documentSnapshot.data());
      return a;
    }
    return null;
  }

  Future load() async {
    //setBusy(true);
    UserService _userService = locator<UserService>();
    _user = await _userService.getUser();
    DocumentSnapshot doc =
        await db.collection(USER_LECTUTES).doc(_user.userID).get();
    if (doc != null && doc.exists) {
      _myLectures = UserLecture.fromMap(doc.data());
    } else {}
    await loadAll();
    notifyListeners();
  }
}
