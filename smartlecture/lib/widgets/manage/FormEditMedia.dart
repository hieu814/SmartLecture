import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/admin_model/ImageStore.dart';
import 'package:smartlecture/models/user_model/user.dart';
import 'package:smartlecture/responsive.dart';
import 'package:smartlecture/services/authenticate.dart';
import 'package:smartlecture/services/helper.dart';
import 'package:smartlecture/ui/modules/UserService.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/ui/views/Admin/components/Filter.dart';
import 'package:smartlecture/widgets/manage/EditMedia.dart';
import 'package:smartlecture/widgets/popup/popup.dart';

File _image;
bool isAllowSave = false;
bool isenabletext = true;

class FormEditMedia extends StatefulWidget {
  final String url;
  final bool isVideo;
  final Function(String) returnData;
  const FormEditMedia({Key key, this.url, this.returnData, this.isVideo})
      : super(key: key);

  @override
  _FormEditMediaState createState() => _FormEditMediaState();
}

class _FormEditMediaState extends State<FormEditMedia> {
  final ImagePicker _imagePicker = ImagePicker();
  UserService _userService;
  String profilePictureURL;

  TextEditingController textController = new TextEditingController();
  String temp;
  String path = "";
  @override
  void initState() {
    super.initState();
    temp = widget.url ?? "";
    textController.text = temp;
  }

  @override
  void dispose() {
    isAllowSave = false;
    isenabletext = true;
    _image = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                if (isAllowSave) {
                  await _save().whenComplete(() {
                    // Navigator.pop(context, temp);
                    print("-----------------------------");
                    //hideProgress();
                  });
                } else
                  Navigator.pop(context, temp);
              },
              child: Text('Lưu'),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Card(
                    child: Container(
                      width: width,
                      height: width * 6 / 8,
                      child: _image != null
                          ? Image.file(
                              _image,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: temp,
                              placeholder: (context, url) => _getPlaceholder(),
                              errorWidget: (context, url, error) =>
                                  _getPlaceholder(),
                              fit: BoxFit.fill,
                            ),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                "Mục",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: FilterWidget(
                      width: double.infinity,
                      height: 50,
                      returnData: (a) {
                        print("path: $a");
                        path = a;
                      },
                    ),
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
              SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Đường dẫn",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          controller: textController,
                          enabled: isenabletext,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (s) {
                            temp = s;
                            print("---------- change: $temp");
                            widget.returnData(temp);
                          },
                        ),
                      ],
                    ),
                    ElevatedButton(
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
                      child: Text("Chọn Từ máy"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> _save() async {
    // popupYesNo(context).then((value) async {
    //   if (value) {
    //     //showProgress(context, 'Đang Lưu...', true);
    //     _uploadImage().then((_) async {});
    //   }
    // });
    _uploadImage().then((_) async {});
    //hideProgress();
  }

  Future<void> _uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_image);
    uploadTask.whenComplete(() async {
      profilePictureURL = await ref.getDownloadURL();
      textController.text = profilePictureURL;
      temp = profilePictureURL;
      var db = FireStoreUtils.firestore;
      ImageStore data = ImageStore();
      var currentUser = await locator<UserService>().getUser();
      data.userID = currentUser.userID;
      data.url = profilePictureURL;
      data.createDate =
          DateFormat('hh:mm:ss MM-dd-yyyy').format(DateTime.now());
      await db.collection(IMAGES).add(data.toMap()).whenComplete(() {
        widget.returnData(profilePictureURL);
        Navigator.pop(context, profilePictureURL);
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  _onCameraClick() {
    final action = CupertinoActionSheet(
      message: Text(
        "Add picture",
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
                isAllowSave = true;
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
                isAllowSave = true;
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

  Widget _getPlaceholder() => Image.asset(
        'assets/images/no_image.png',
        fit: BoxFit.fill,
      );
}
