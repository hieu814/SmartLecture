import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartlecture/models/user.dart';
import 'package:smartlecture/services/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../constants.dart';

class UserService {
  User _currentUser;
  User get currentUser => _currentUser; //<----- Cached Here
  UserService();

  Future<bool> isLogged() async {
    try {
      var user = auth.FirebaseAuth.instance.currentUser;
      return user != null;
    } catch (e) {
      return false;
    }
  }

  Future<User> getUser() async {
    String uid = auth.FirebaseAuth.instance.currentUser.uid;
    DocumentSnapshot documentSnapshot =
        await FireStoreUtils.firestore.collection(USERS).doc(uid).get();
    User user;
    if (documentSnapshot != null && documentSnapshot.exists) {
      user = User.fromJson(documentSnapshot.data());
      _currentUser = user;
      return _currentUser;
    }
    return null;
  }
}
