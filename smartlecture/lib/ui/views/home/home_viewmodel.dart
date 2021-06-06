import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/Lecture.dart';
import 'package:smartlecture/models/LectuteData.dart';
import 'package:smartlecture/models/UserLectures.dart';
import 'package:smartlecture/models/user.dart';
import 'package:smartlecture/services/authenticate.dart';
import 'package:smartlecture/ui/modules/UserService.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:stacked/stacked.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

var db = FireStoreUtils.firestore;

class HomeViewModel extends BaseViewModel {
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

  Future<void> fetchAndSetWorkouts() async {
    notifyListeners();
  }

  Future<void> loadAll() async {
    _myLectures.lectures.forEach((element) async {
      Lecture a;
      a = await loadLecture(element);
      if (a != null) {
        _listMylecture.add(LectuteData(id: element, lecture: a));
        notifyListeners();
      }
    });
    notifyListeners();
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
    setBusy(true);
    UserService _userService = locator<UserService>();
    _user = await _userService.getUser();
    DocumentSnapshot doc =
        await db.collection(USER_LECTUTES).doc(_user.userID).get();
    if (doc != null && doc.exists) {
      _myLectures = UserLecture.fromMap(doc.data());
    } else {}
    await loadAll();
    //_listMylecture.add("");
    notifyListeners();
    await fetchAndSetWorkouts();
  }
}
