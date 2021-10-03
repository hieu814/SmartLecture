import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartlecture/models/user_model/user.dart';
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
      print("user curebt: " + user.toString());
      return user != null;
    } catch (e) {
      return false;
    }
  }

  logout() async {
    // _user.active = false;
    // user.lastOnlineTimestamp = Timestamp.now();
    //FireStoreUtils.updateCurrentUser(_user);
    await auth.FirebaseAuth.instance.signOut();
    _currentUser = User();
  }

  Future<bool> validatePasswordService(String oldPw, String newPw) async {
    try {
      var firebaseUser = auth.FirebaseAuth.instance.currentUser;
      var credential = auth.EmailAuthProvider.credential(
          email: _currentUser.email, password: oldPw);
      var authResult =
          await firebaseUser.reauthenticateWithCredential(credential);
      print(authResult.user.email);
      if (authResult.user != null) {
        await firebaseUser.updatePassword(newPw).then((_) {
          print("Successfully changed password");
          return true;
        }).catchError((error) {
          print("Password can't be changed" + error.toString());
          return false;
          //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
        });
      } else {
        print("Current password wrong");
        return false;
      }
      return authResult.user != null;
    } catch (e) {
      print('validatePasswordService $e');
      return false;
    }
  }

  Future<bool> updateUser(User user) async {
    try {
      user.userID = _currentUser.userID;
      await FireStoreUtils.firestore
          .collection(USERS)
          .doc(user.userID)
          .set(user.toJson());
      return true;
    } on auth.FirebaseAuthException catch (error) {
      String message = 'Couldn\'t sign up';
      switch (error.code) {
        case 'email-already-in-use':
          message = 'Email đã được sử dụng';
          break;
        case 'invalid-email':
          message = 'Email không đúng';
          break;
        case 'operation-not-allowed':
          message = 'Email/password accounts are not enabled';
          break;
        case 'weak-password':
          message = 'password quá yếu.';
          break;
        case 'too-many-requests':
          message = 'Too many requests, '
              'Please try again later.';
          break;
      }
      print(error.toString());
      return false;
    } catch (e) {
      print('_SignUpState._sendToServer $e');
      return false;
    }
  }

  Future<User> getUser() async {
    try {
      final uid = auth.FirebaseAuth.instance.currentUser.uid ?? "";
      if (uid == null) return null;
      DocumentSnapshot documentSnapshot =
          await FireStoreUtils.firestore.collection(USERS).doc(uid).get();
      User user;
      if (documentSnapshot != null && documentSnapshot.exists) {
        user = User.fromJson(documentSnapshot.data());
        _currentUser = user;
        return _currentUser;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
