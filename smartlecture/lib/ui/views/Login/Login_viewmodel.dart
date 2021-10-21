import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/user_model/user.dart';
import 'package:smartlecture/services/authenticate.dart';
import 'package:smartlecture/services/helper.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Home/Home_view.dart';
import 'package:stacked/stacked.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class LoginViewModel extends ChangeNotifier {
  User _user;
  User get currentUser => _user;
  Future<void> loginWithUserNameAndPassword(
      context, String email, String pass) async {
    print("taikhoan: email" + email + "  pass:  " + pass);
    try {
      auth.UserCredential result = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.trim(), password: pass.trim());
      DocumentSnapshot documentSnapshot = await FireStoreUtils.firestore
          .collection(USERS)
          .doc(result.user.uid)
          .get();
      User user;
      if (documentSnapshot != null && documentSnapshot.exists) {
        user = User.fromJson(documentSnapshot.data());
        user.active = true;
        await FireStoreUtils.updateCurrentUser(user);
        hideProgress();
        _user = user;
      }
      Navigator.pushNamedAndRemoveUntil(
          context,
          _user.role == USER_ROLE_ADMIN
              ? RouteName.adminPage
              : RouteName.homePage,
          ModalRoute.withName('/'));
    } on auth.FirebaseAuthException catch (exception) {
      hideProgress();
      switch ((exception).code) {
        case "invalid-email":
          showAlertDialog(context, 'Không thể đăng nhập', 'Email không đúng');
          break;
        case "wrong-password":
          showAlertDialog(context, 'Không thể đăng nhập', 'Sai mật khẩu');
          break;
        case "user-not-found":
          showAlertDialog(
              context, 'Không thể đăng nhập', 'Tài khoản không tồn tại');
          break;
        case "user-disabled":
          showAlertDialog(context, 'Không thể đăng nhập', 'Tài khoản bị khóa');
          break;
        case 'too-many-requests':
          showAlertDialog(context, 'Không thể đăng nhập',
              'Quá nhiều yêu cầu, Xin hãy thẻ lại sau.');
          break;
      }
      print(exception.toString());
      return false;
    } catch (e) {
      hideProgress();
      showAlertDialog(context, 'Không thể đăng nhập', 'Xin hãy thẻ lại sau');
      print(e.toString());
      return false;
    }
  }

  logout() async {
    // _user.active = false;
    // user.lastOnlineTimestamp = Timestamp.now();
    //FireStoreUtils.updateCurrentUser(_user);
    await auth.FirebaseAuth.instance.signOut();
    _user = User();
  }

  Future<void> signUp(context, User user, String password, File image) async {
    try {
      var profilePicUrl = '';

      auth.UserCredential result = await auth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email.trim(), password: password.trim());
      if (image != null) {
        updateProgress('Đang upload hình ảnh...');
        profilePicUrl = await FireStoreUtils()
            .uploadUserImageToFireStorage(image, result.user.uid);
      }
      user.profilePictureURL = profilePicUrl;
      print(user.toString());
      await FireStoreUtils.firestore
          .collection(USERS)
          .doc(result.user.uid)
          .set(user.toJson());
      pushAndRemoveUntil(context, HomeView(), false);
    } on auth.FirebaseAuthException catch (error) {
      String message = 'Couldn\'t sign up';
      switch (error.code) {
        case 'email-already-in-use':
          message = 'Email đã tồn tại';
          break;
        case 'invalid-email':
          message = 'validEmail';
          break;
        case 'operation-not-allowed':
          message = 'Tài khoản bị khóa';
          break;
        case 'weak-password':
          message = 'Mật khẩu yếu.';
          break;
        case 'too-many-requests':
          message = 'Có quá nhiều yêu cầu, '
              'Xin hãy thử lại sau.';
          break;
      }
      showAlertDialog(context, 'Failed', message);
      print(error.toString());
    } catch (e) {
      print('_SignUpState._sendToServer $e');
      showAlertDialog(context, 'Lỗi', 'Không thể đăng kí');
    }
  }
}
