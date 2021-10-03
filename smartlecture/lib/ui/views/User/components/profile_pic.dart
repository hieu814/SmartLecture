import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartlecture/models/user_model/user.dart';
import 'package:smartlecture/services/authenticate.dart';
import 'package:smartlecture/services/helper.dart';
import 'package:smartlecture/ui/modules/UserService.dart';
import 'package:smartlecture/ui/modules/function.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:smartlecture/widgets/popup/popup.dart';

File _image;

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  final ImagePicker _imagePicker = ImagePicker();
  UserService _userService;
  String profilePictureURL;
  @override
  Widget build(BuildContext context) {
    _userService = locator<UserService>();
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.grey.shade400,
            child: ClipOval(
              child: SizedBox(
                width: 115,
                height: 115,
                child: _image == null
                    ? displayCircleImage(
                        _userService.currentUser.profilePictureURL, 125, false)
                    : Image.file(
                        _image,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () {
                  _onCameraClick();
                },
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }

  _onCameraClick() {
    final action = CupertinoActionSheet(
      message: Text(
        "Add profile picture",
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Choose from gallery"),
          isDefaultAction: false,
          onPressed: () async {
            Navigator.pop(context);
            PickedFile image =
                await _imagePicker.getImage(source: ImageSource.gallery);
            if (image != null)
              setState(() {
                _image = File(image.path);
                _save();
              });
          },
        ),
        CupertinoActionSheetAction(
          child: Text("Take a picture"),
          isDestructiveAction: false,
          onPressed: () async {
            Navigator.pop(context);
            PickedFile image =
                await _imagePicker.getImage(source: ImageSource.camera);

            if (image != null) {
              setState(() {
                _image = File(image.path);
                _save();
              });
            }
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  _save() {
    popupYesNo(context).then((value) {
      if (value) {
        showProgress(context, 'Đang Lưu...', false);
        _uploadImage().then((value) {
          User user = _userService.currentUser;
          user.profilePictureURL = profilePictureURL;
          _userService.updateUser(user).then((value) {
            showInSnackBar(context, "đã lưu");
            hideProgress();
          });
        });
      }
    });
  }

  Future<void> _uploadImage() async {
    return FireStoreUtils()
        .uploadUserImageToFireStorage(_image, _userService.currentUser.userID)
        .then((value) {
      profilePictureURL = value;
    });
  }
}
