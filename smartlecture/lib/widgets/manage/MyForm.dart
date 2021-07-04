import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartlecture/models/user_model/user.dart';
import 'package:smartlecture/services/authenticate.dart';
import 'package:smartlecture/services/helper.dart';
import 'package:smartlecture/ui/modules/function.dart';
import 'package:smartlecture/ui/views/Admin/Dashboard_ViewModel.dart';
import 'package:smartlecture/widgets/layout/header.dart';
import 'package:smartlecture/widgets/layout/side_menu.dart';
import 'package:smartlecture/widgets/popup/popup.dart';
import '../../../../responsive.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

File _image;

class MyForm extends StatefulWidget {
  final DocumentSnapshot doc;
  final String type;
  const MyForm({Key key, this.doc, this.type}) : super(key: key);

  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  User _user;
  String profilePicUrl;
  ImagePicker _imagePicker = ImagePicker();
  bool _newImage = false;
  @override
  void initState() {
    _user = User.fromJson(widget.doc.data());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type ?? ""),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sửa " + widget.type ?? "",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  ElevatedButton.icon(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1.5,
                        vertical: defaultPadding /
                            (Responsive.isMobile(context) ? 2 : 1),
                      ),
                    ),
                    onPressed: () async {
                      popupYesNo(context).then((value) {
                        if (value) {
                          showProgress(context, 'Đang Lưu...', false);
                          _uploadImage().then((value) {
                            context
                                .read<AdminViewModel>()
                                .updateItem(widget.doc.id, _user.toJson())
                                .then((value) {
                              showInSnackBar(context, "đã lưu");
                              hideProgress();
                              Navigator.pop(context);
                            });
                          });
                        }
                      });
                    },
                    icon: Icon(Icons.add),
                    label: Text("Lưu"),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: _createForm(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _createForm() {
    if (widget.type == USERS) {
      return Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Last Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                initialValue: _user.lastName ?? "",
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _user.lastName = value,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "First Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                initialValue: _user.firstName ?? "",
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _user.firstName = value,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                initialValue: _user.email ?? "",
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _user.email = value,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Phone Number",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                initialValue: _user.phoneNumber ?? "",
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _user.phoneNumber = value,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Role",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          _user.role == "admin" ? Colors.red : Colors.grey,
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1.5,
                        vertical: defaultPadding /
                            (Responsive.isMobile(context) ? 2 : 1),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _user.role = "admin";
                      });
                    },
                    child: Text("Admin"),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          _user.role == "admin" ? Colors.grey : Colors.blue,
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1.5,
                        vertical: defaultPadding /
                            (Responsive.isMobile(context) ? 2 : 1),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _user.role = "user";
                      });
                    },
                    child: Text("User"),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Url Image",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.grey.shade400,
                    child: ClipOval(
                      child: SizedBox(
                        width: 70,
                        height: 70,
                        child: _image == null
                            ? Image.asset(
                                'assets/images/placeholder.jpg',
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                _image,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: TextFormField(
                        initialValue: _user.profilePictureURL ?? "",
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => _user.profilePictureURL = value,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding * 1.5,
                          vertical: defaultPadding /
                              (Responsive.isMobile(context) ? 2 : 1),
                        ),
                      ),
                      onPressed: () async {
                        _onCameraClick();
                      },
                      child: Text("Chọn Ảnh"),
                    ),
                  ),
                ],
              ),
              Visibility(
                  visible: _newImage,
                  child: Card(
                    child: new CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.grey.shade400,
                      child: ClipOval(
                        child: SizedBox(
                          width: 170,
                          height: 170,
                          child: _image == null
                              ? Image.asset(
                                  'assets/images/placeholder.jpg',
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  _image,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                  replacement: Container()),
            ],
          ),
        ],
      );
    }
  }

  Future<void> _uploadImage() async {
    return FireStoreUtils()
        .uploadUserImageToFireStorage(_image, widget.doc.id)
        .then((value) {
      _user.profilePictureURL = value;
    });
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
            if (image != null)
              setState(() {
                _image = File(image.path);
              });
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
}
