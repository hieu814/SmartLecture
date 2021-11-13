import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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

var db = FireStoreUtils.firestore;

class ContributeViewModel extends ChangeNotifier {
  List<String> _listNameMyLecture = [];
  List<Lecture> _listdata = [];
  get myLecture => _listNameMyLecture;
  loadAllLecture() async {
    final dir = await getApplicationDocumentsDirectory();
    final imagesDirectory = Directory(dir.path + "/lectures/");
    List<String> images = [];
    _listNameMyLecture.clear();
    _listdata.clear();
    final _lecturesFile =
        imagesDirectory.listSync(followLinks: false, recursive: true);
    _lecturesFile.forEach((entity) async {
      if (entity is File) {
        File _file = (entity as File);
        String data = _file.readAsStringSync();
        var pdfText = await json.decode(json.encode(data));
        try {
          Lecture a = Lecture.fromJson(json.decode(pdfText)["LECTURE"]);
          _listdata.add(a);
          _listNameMyLecture.add(a.title);
          notifyListeners();
        } catch (e) {
          _file.delete();
          print("fromjson err: " + e.toString());
        }
      }
      print(_listNameMyLecture.toString());
    });
    print("");
  }

  Future<void> contribute(int inx, String message, String path) async {
    Contribute contribute = Contribute();
    try {
      print("-----------------addLectures");
      await db
          .collection(LECTUTES)
          .add(_listdata[inx].toJson())
          .then((docRef) async {
        if (docRef != null) {
          print("docc: $docRef");
          var currentUser = await locator<UserService>().getUser();
          contribute.lectureId = docRef.id.toString();
          contribute.contributorId = currentUser.userID;
          contribute.message = message;
          contribute.path = path;
          contribute.date =
              DateFormat('hh:mm:ss MM-dd-yyyy').format(DateTime.now());
          contribute.lectureName = _listdata[inx].title;
          DocumentReference document = await db
              .collection(CONTRIBUTE)
              .add(contribute.toJson())
              .catchError((error) {
            print('Update failed: $error');
          });
          print("          contribute " + document.id);
          await saveToServer(path, document.id);
        }
      });
    } catch (ex) {
      print("contibute " + ex.toString());
    }
  }

  Future<String> contributeSendGamil(int inx, String message, String path) {
    return contributeEmail(_listdata[inx], message);
  }

  saveToServer(String path, String idContribue) async {
    print("checkAndOpenFolder id: $path");
    var pos = path.split('/').toList();
    print("------------- result " + pos.toString());
    LectureDataStore data = LectureDataStore(contributeId: idContribue);
    db.collection(FOLDER).doc(path).collection(CONTRIBUTE).add(data.toMap());
    //db.collection(FOLDER).doc(paths).collection(collec).add(a.toMap());
    // FireStoreUtils.firestore.collection(FOLDER).doc(path).get().then((doc) {

    //   if (doc == null || !doc.exists) {
    //     //.add(a.toMap());
    //   }
    // });
    //Navigator.pop(context, "$path");
  }

  Future<String> contributeEmail(Lecture _lecture, String message) async {
    try {
      String dir = await createFolderInAppDocDir2("temp");
      String path = dir + _lecture.title + ".xml";
      File _file = File(path);
      _file.writeAsString(toXML(_lecture));
      print("-----------------saveData path: ${_file.absolute.path}");
      // await sendEmailContribute(_file.absolute.path, message);
      return _file.absolute.path;
    } catch (ex) {
      print("-----------------saveData exception");
      print(ex.toString());
      return "";
    }
  }

  updateMyLectures(String ltID) async {
    var currentUser = await locator<UserService>().getUser();
    MyLectures myLectures;
    DocumentSnapshot doc =
        await db.collection(USER_LECTUTES).doc(currentUser.userID).get();
    if (doc != null && doc.exists) {
      myLectures = MyLectures.fromMap(doc.data());
      myLectures.lectures.add(ltID);
    } else {
      myLectures.lectures.add(ltID);
    }
    db
        .collection(USER_LECTUTES)
        .doc(currentUser.userID)
        .set(myLectures.toMap())
        .catchError((error) =>
            print("-----------------updateMyLectures error: " + error));
  }

  Future load() async {
    loadAllLecture();
    notifyListeners();
  }
}
