import 'dart:async';
import 'dart:convert';

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
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:smartlecture/ui/modules/UserService.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/models/Page.dart' as p;

var db = FireStoreUtils.firestore;

class SectionViewModel extends BaseViewModel {
  Lecture _lecture;
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
    _currentIndex =
        new SectionIndex(currentPageIndex: 0, currentSectionIndex: 0);
  }
  void setCurrenindex(SectionIndex a) {
    _currentIndex = a;
  }

  void setModelBusy() {
    setBusy(false);
  }

  Future<String> getJson() async {
    return rootBundle.loadString('assets/lectures/example2.json');
  }

  void addComponent(String type) {
    Item t;
    if (type == Type.ITEXTBLOCK) {
      // t=new Item()
      _lecture.section[_currentIndex.currentSectionIndex]
          .page[_currentIndex.currentPageIndex].items.item
          .add(t);
    } else if (type == Type.IMAGE) {}
    notifyListeners();
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

  setlecture(Lecture a) {
    _lecture = a;
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
    print("current user: " + currentUser.toJson().toString());
    setBusy(true);

    //notifyListeners();
  }

  void dispose() {
    print("dispose SectionViewModel");
    super.dispose();
  }
}
