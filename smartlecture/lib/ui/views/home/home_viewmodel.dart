import 'dart:convert';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
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
  MyLectures _myLectures;
  List<LectuteData> _listMylecture = <LectuteData>[];
  User _user;
  User get user => _user;
  MyLectures get mylectutes => _myLectures;
  List<LectuteData> get items => _listMylecture;
  HomeViewModel() {
    _user = new User();
  }

  logout() async {
    // _user.active = false;
    // user.lastOnlineTimestamp = Timestamp.now();
    //FireStoreUtils.updateCurrentUser(_user);
    //await auth.FirebaseAuth.instance.signOut();
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

  Future<Lecture> addNewLecture() async {
    UserService _userService = locator<UserService>();
    _user = await _userService.getUser();
    return getJson("lecture").then((value) {
      Lecture example = Lecture.fromJson(json.decode(value)["LECTURE"]);
      example.authorId = _user.userID;
      var curentTime = DateTime.now();
      example.createdDate =
          DateFormat('hh:mm:ss MM-dd-yyyy').format(curentTime);
      print("addNewLecture current time: ${example.createdDate}");
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

  Future feleteFileLecture(String path) async {
    File _file = File(path);
    if (await _file.exists()) _file.delete();
    load();
    notifyListeners();
  }

  Future<List<String>> loadAllLecture() async {
    final dir = await getApplicationDocumentsDirectory();
    final imagesDirectory = Directory(dir.path + "/lectures/");

    print("loadAllLecture " + imagesDirectory.toString());
    print("");
    final _lecturesFile =
        imagesDirectory.listSync(followLinks: false, recursive: true);
    print("loadAllLecture imagesDirectory");
    _lecturesFile.forEach((entity) async {
      if (entity is File) {
        File _file = (entity as File);
        String data = _file.readAsStringSync();
        var pdfText = await json.decode(json.encode(data));
        try {
          var lectueId = _file.path.split("/").last.split("_").first;
          //print("loadAllLecture file name: $ss");
          Lecture a = Lecture.fromJson(json.decode(pdfText)["LECTURE"]);
          _listMylecture.add(LectuteData(
              id: lectueId ?? "",
              path: _file.path,
              lecture: Lecture.fromJson(json.decode(pdfText)["LECTURE"])));
          notifyListeners();
        } catch (e) {
          _file.delete();
          print("fromjson err: " + e.toString());
        }
      }
      // print("dir: " + p.toString());
      // final file = File(p.toString());
      // String data = await file.readAsString();
      //print("da);
    });

    print("");
  }

  Future load() async {
    //setBusy(true);
    UserService _userService = locator<UserService>();
    _user = await _userService.getUser();
    DocumentSnapshot doc =
        await db.collection(USER_LECTUTES).doc(_user.userID).get();
    if (doc != null && doc.exists) {
      _myLectures = MyLectures.fromMap(doc.data());
    } else {}
    _listMylecture.clear();
    await loadAllLecture();
    notifyListeners();
  }
}
