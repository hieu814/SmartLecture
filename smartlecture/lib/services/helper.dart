import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:smartlecture/services/authenticate.dart';
import 'package:smartlecture/ui/modules/UserService.dart';
import 'package:smartlecture/ui/modules/injection.dart';

import '../constants.dart';

String validateName(String value) {
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Hãy nhập tên";
  } else if (!regExp.hasMatch(value)) {
    return "Tên không đúng";
  }
  return null;
}

String validateMobile(String value) {
  String pattern = r'(^[0-9]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Hãy nhập số diện thoại";
  } else if (!regExp.hasMatch(value)) {
    return "Số điện thoại không đúng";
  }
  return null;
}

String validatePassword(String value) {
  if (value.length < 6)
    return 'Mật khẩu phải lớn hơn 5 kí tự';
  else
    return null;
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Hãy nhập đúng Email';
  else
    return null;
}

Future<bool> changePassword(String oldPw, String newPw) async {
  UserService _userService = locator<UserService>();

  return await _userService.validatePasswordService(oldPw, newPw);
}

String validateConfirmPassword(String password, String confirmPassword) {
  print("$password $confirmPassword");
  if (password != confirmPassword) {
    return 'Mật khẩu không trùng khớp';
  } else if (confirmPassword.length == 0) {
    return 'Hãy nhập mật khẩu';
  } else {
    return null;
  }
}

Future<String> readLecture() async {
  try {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xml', 'json'],
    );

    if (result != null) {
      File file = File(result.files.single.path);
      print("readLecture " + result.files.single.path);
      String data = await file.readAsString();
      //print("------ data: " + data);
      return data;
    }
    return "";
  } catch (e) {
    print('loi doc file $e');
    return "";
  }
}

//helper method to show progress
ProgressDialog progressDialog;

showProgress(BuildContext context, String message, bool isDismissible) async {
  progressDialog = new ProgressDialog(context,
      type: ProgressDialogType.Normal, isDismissible: isDismissible);
  progressDialog.style(
      message: message,
      borderRadius: 10.0,
      backgroundColor: Color(COLOR_PRIMARY),
      progressWidget: Container(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          )),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: TextStyle(
          color: Colors.white, fontSize: 19.0, fontWeight: FontWeight.w600));
  await progressDialog.show().then((value) {
    Future.delayed(const Duration(milliseconds: 6000), () {
      hideProgress();
    });
  });
}

updateProgress(String message) {
  progressDialog.update(message: message);
}

Future<void> hideProgress() async {
  await progressDialog.hide();
}

//helper method to show alert dialog
showAlertDialog(BuildContext context, String title, String content) {
  print("show dialog: " + title + "-" + content);
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

pushReplacement(BuildContext context, Widget destination) {
  Navigator.of(context).pushReplacement(
      new MaterialPageRoute(builder: (context) => destination));
}

push(BuildContext context, Widget destination) {
  Navigator.of(context)
      .push(new MaterialPageRoute(builder: (context) => destination));
}

pushAndRemoveUntil(BuildContext context, Widget destination, bool predict) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => destination),
      (Route<dynamic> route) => predict);
}

Widget displayCircleImage(String picUrl, double size, hasBorder) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: const Color(0xff7c94b6),
      borderRadius: new BorderRadius.all(new Radius.circular(size / 2)),
      border: new Border.all(
        color: Colors.white,
        width: hasBorder ? 2.0 : 0.0,
      ),
    ),
    child: ClipOval(
        child: picUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: picUrl,
                fit: BoxFit.cover,
                height: size,
                width: size,
                placeholder: (context, url) =>
                    _getPlaceholderOrErrorImage(size, hasBorder),
              )
            : Image.asset(
                'assets/images/placeholder.jpg',
                fit: BoxFit.cover,
                height: size,
                width: size,
              )),
  );
}

Widget _getPlaceholderOrErrorImage(double size, hasBorder) => Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xff7c94b6),
        borderRadius: new BorderRadius.all(new Radius.circular(size / 2)),
        border: new Border.all(
          color: Colors.white,
          width: hasBorder ? 2.0 : 0.0,
        ),
      ),
      child: ClipOval(
          child: Image.asset(
        'assets/images/placeholder.jpg',
        fit: BoxFit.cover,
        height: size,
        width: size,
      )),
    );
Future<String> createFolderInAppDocDir(String folderName) async {
  //Get this App Document Directory
  final Directory _appDocDir = await getApplicationDocumentsDirectory();
  //App Document Directory + folder name
  final Directory _appDocDirFolder =
      Directory('${_appDocDir.path}/$folderName/');

  if (await _appDocDirFolder.exists()) {
    //if folder already exists return path
    return _appDocDirFolder.path;
  } else {
    //if folder not exists create folder and then return its path
    final Directory _appDocDirNewFolder =
        await _appDocDirFolder.create(recursive: true);
    return _appDocDirNewFolder.path;
  }
}
