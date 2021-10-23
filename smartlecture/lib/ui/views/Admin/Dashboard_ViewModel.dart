import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/admin_model/Contribute.dart';
import 'package:smartlecture/models/admin_model/MyFiles.dart';
import 'package:smartlecture/models/admin_model/SizeData.dart';
import 'package:smartlecture/models/lecture_model/Lecture.dart';
import 'package:smartlecture/models/user_model/UserLectures.dart';
import 'package:smartlecture/services/authenticate.dart';

var _db = FireStoreUtils.firestore;

class MenuViewModel extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    if (!_scaffoldKey.currentState.isDrawerOpen) {
      _scaffoldKey.currentState.openDrawer();
    }
  }
}

class AdminViewModel extends ChangeNotifier {
  SizeData _size;
  get sizeData => _size;
  Stream _streamQuery;
  Stream _streamQueryImage;
  get streamData => _streamQuery;
  get streamDataImage => _streamQueryImage;
  String _collection;
  get collection => _collection;
  List<CloudStorageInfo> datas = demoMyFiles;
  get cloudStorageInfo => datas;
  Future<Stream<QuerySnapshot<Object>>> provideActivityStream() async {
    return FirebaseFirestore.instance.collection(_collection).snapshots();
  } //this should work

  setCurrentCollection(String collection) {
    _streamQuery =
        FirebaseFirestore.instance.collection(_collection).snapshots();
    _collection = collection;
    notifyListeners();
  }

  setFilterCollection(String collection) {
    _streamQuery =
        FirebaseFirestore.instance.collection(_collection).snapshots();
    _collection = collection;
    notifyListeners();
  }

  setFilterImage(String path) {
    _streamQuery = FirebaseFirestore.instance
        .collection(IMAGES)
        .where('path', isEqualTo: path)
        .snapshots();
    _collection = collection;
    notifyListeners();
  }

  AdminViewModel() {
    _collection = USERS;
  }
  updateMyLectures({String userID, String ltID, bool isDelete}) async {
    UserLecture myLectures = UserLecture();
    DocumentSnapshot doc =
        await _db.collection(USER_LECTUTES).doc(userID).get();
    if (doc != null && doc.exists) {
      myLectures = UserLecture.fromMap(doc.data());
      if (isDelete) {
        myLectures.lectures.remove(ltID);
      }
      _db
          .collection(USER_LECTUTES)
          .doc(userID)
          .set(myLectures.toMap())
          .catchError((error) =>
              print("-----------------updateMyLectures error: " + error));
    }
  }

  Future<void> deleteItem(String jobId) {
    notifyListeners();
    return _db
        .collection(_collection)
        .doc(jobId)
        .delete()
        .catchError((error) => print('Delete failed: $error'));
  }

  Future<Lecture> getLectureFromId(String id) async {
    DocumentSnapshot documentSnapshot =
        await FireStoreUtils.firestore.collection(LECTUTES).doc(id).get();
    if (documentSnapshot != null && documentSnapshot.exists) {
      return Lecture.fromJson(documentSnapshot.data());
    }
    return null;
  }

  Future<void> approveContribute(String id, Contribute data) {
    notifyListeners();
    data.status = true;
    return _db
        .collection(CONTRIBUTE)
        .doc(id)
        .set(data.toJson())
        .catchError((error) => print('approveContribute failed: $error'));
  }

  Future<void> rejecteContribute(String id) {
    notifyListeners();
    return _db
        .collection(CONTRIBUTE)
        .doc(id)
        .delete()
        .catchError((error) => print('Delete failed: $error'));
  }

  Future<void> updateItem(String uid, Map<String, dynamic> data) {
    return _db
        .collection(_collection)
        .doc(uid)
        .set(data)
        .catchError((error) => print('Update failed: $error'));
  }

  Future loadSize() async {
    await _db.collection(SIZE_DATA).doc(SIZE_DATA_ID).get().then((doc) {
      if (doc != null && doc.exists) {
        _size = SizeData.fromMap(doc.data());
      } else {
        _size = new SizeData();
      }
    }).catchError((error) => print('-------------------loadSize: $error'));
  }

  setDataLength(int length) async {
    if (_collection == USERS) {
      _size.usersSize = length;
    } else if (_collection == LECTUTES) {
      _size.lectureSize = length;
    } else if (_collection == VIDEOS) {
      _size.videosSize = length;
    } else if (_collection == AUDIOS) {
      _size.audiosSize = length;
    }
    if (_collection == IMAGES) {
      _size.imagesSize = length;
    }
    _db
        .collection(SIZE_DATA)
        .doc(SIZE_DATA_ID)
        .set(_size.toMap())
        .catchError((error) => print('-------------------add false: $error'));
    notifyListeners();
  }

  Future<List<CloudStorageInfo>> getDataLength() async {
    await loadSize().then((value) {
      datas[0].numOfFiles = _size.videosSize ?? 0;
      datas[1].numOfFiles = _size.audiosSize ?? 0;
      datas[2].numOfFiles = _size.lectureSize ?? 0;
      datas[3].numOfFiles = _size.usersSize ?? 0;
    });
    return datas;
  }
}
