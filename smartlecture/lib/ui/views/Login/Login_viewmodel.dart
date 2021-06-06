import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/user.dart';
import 'package:smartlecture/services/authenticate.dart';
import 'package:smartlecture/services/helper.dart';
import 'package:smartlecture/ui/modules/UserService.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/ui/views/Home/Home_view.dart';
import 'package:stacked/stacked.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class LoginViewModel extends BaseViewModel {
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
        //MyApp.currentUser = user;
      }
      pushAndRemoveUntil(context, HomeView(), false);
    } on auth.FirebaseAuthException catch (exception) {
      hideProgress();
      switch ((exception).code) {
        case "invalid-email":
          showAlertDialog(context, 'Couldn\'t Authenticate', 'malformedEmail');
          break;
        case "wrong-password":
          showAlertDialog(context, 'Couldn\'t Authenticate', 'Wrong password');
          break;
        case "user-not-found":
          showAlertDialog(context, 'Couldn\'t Authenticate',
              'No user corresponds to this email');
          break;
        case "user-disabled":
          showAlertDialog(
              context, 'Couldn\'t Authenticate', 'This user is disabled');
          break;
        case 'too-many-requests':
          showAlertDialog(context, 'Couldn\'t Authenticate',
              'Too many requests, Please try again later.');
          break;
      }
      print(exception.toString());
      return false;
    } catch (e) {
      hideProgress();
      showAlertDialog(
          context, 'Couldn\'t Authenticate', 'Login failed. Please try again.');
      print(e.toString());
      return false;
    }
  }

  Future<void> signUp(context, User user, String password, File image) async {
    try {
      var profilePicUrl = '';

      auth.UserCredential result = await auth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email.trim(), password: password.trim());
      if (image != null) {
        updateProgress('Uploading image, Please wait...');
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
          message = 'Email address already in use';
          break;
        case 'invalid-email':
          message = 'validEmail';
          break;
        case 'operation-not-allowed':
          message = 'Email/password accounts are not enabled';
          break;
        case 'weak-password':
          message = 'password is too weak.';
          break;
        case 'too-many-requests':
          message = 'Too many requests, '
              'Please try again later.';
          break;
      }
      showAlertDialog(context, 'Failed', message);
      print(error.toString());
    } catch (e) {
      print('_SignUpState._sendToServer $e');
      showAlertDialog(context, 'Failed', 'Couldn\'t sign up');
    }
  }
}
