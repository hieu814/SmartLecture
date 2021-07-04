import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/admin_model/MyFiles.dart';
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
  Stream _streamQuery;
  get streamData => _streamQuery;
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

  AdminViewModel() {
    _collection = USERS;
  }
  Future<void> deleteItem(String jobId) {
    return _db
        .collection(_collection)
        .doc(jobId)
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

  Future<void> getDataLength() async {
    _db
        .collection(USERS)
        .get()
        .then((value) => datas[3].numOfFiles = value.docs.length ?? 0);
    _db
        .collection(LECTUTES)
        .get()
        .then((value) => datas[2].numOfFiles = value.docs.length ?? 0);
    _db
        .collection(VIDEOS)
        .get()
        .then((value) => datas[0].numOfFiles = value.docs.length ?? 0);
    _db
        .collection(AUDIOS)
        .get()
        .then((value) => datas[1].numOfFiles = value.docs.length ?? 0);
  }

  notifyListeners();
}
