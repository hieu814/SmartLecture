import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smartlecture/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartlecture/models/admin_model/Contribute.dart';
import 'package:smartlecture/models/lecture_model/Lecture.dart';
import 'package:smartlecture/models/lecture_model/LectuteData.dart';
import 'package:smartlecture/models/user_model/user.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Admin/Dashboard_ViewModel.dart';
import 'package:smartlecture/ui/views/Lybrary/Lybrary_viewmodel.dart';
import 'package:smartlecture/ui/views/contribute/Contribute_view.dart';
import 'package:smartlecture/widgets/components/Page.dart';
import 'package:smartlecture/widgets/popup/popup.dart';

class ContributeDetail extends StatefulWidget {
  final String folderId;
  final String id;
  final Contribute contibute;
  final User user;
  const ContributeDetail(
      {Key key, this.id, this.contibute, this.user, this.folderId})
      : super(key: key);
  @override
  State createState() => _ContributeDetailState();
}

String path = "";

class _ContributeDetailState extends State<ContributeDetail> {
  GlobalKey<FormState> _key = new GlobalKey();
  String message = "-";
  Contribute temp;
  int index = 0;
  @override
  void initState() {
    temp = widget.contibute;
    path = widget.contibute.path;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {}
    context.read<ContributeViewModel>().load();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: new Container(
          margin: new EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
          child: new Form(
            key: _key,
            child: formUI(),
          ),
        ),
      ),
    );
  }

  Widget formUI() {
    return SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          new Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Chi tiết',
                style: TextStyle(
                    color: Color(COLOR_PRIMARY),
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0),
              )),
          SizedBox(
            height: 30,
          ),
          new Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Text(
                      temp.lectureName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  Expanded(
                      child: IconButton(
                          onPressed: () async {
                            Lecture a = await context
                                .read<AdminViewModel>()
                                .getLectureFromId(temp.lectureId);
                            Navigator.pushNamed(context, RouteName.presentation,
                                arguments: a);
                          },
                          icon: Icon(
                            Icons.play_arrow,
                            color: Colors.green,
                            size: 50,
                          )))
                ],
              )),
          SizedBox(
            height: 30,
          ),
          new Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Chi tiết tác giả',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              )),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text("Tác giả:   ",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
              Text(widget.user.fullName(), style: TextStyle(fontSize: 15.0)),
            ],
          ),
          Row(
            children: [
              Text("Email:      ",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
              Text(widget.user.email, style: TextStyle(fontSize: 15.0)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          new Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Chọn Mục',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              )),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Text(
                  'Mục: $path',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
              Expanded(
                flex: 3,
                child: RaisedButton(
                  color: Color(COLOR_PRIMARY),
                  child: Text(
                    'Sửa',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  textColor: Colors.white,
                  splashColor: Color(COLOR_PRIMARY),
                  onPressed: () async {
                    final value = await Navigator.pushNamed(
                        context, RouteName.libraryTree,
                        arguments: TypeFolder.FOLDER_NULL);
                    print("------------------path : $value");
                    if (value != null) path = value;
                    temp.path = path;
                    setState(() {});
                  },
                  //padding: EdgeInsets.only(top: 12, bottom: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Color(COLOR_PRIMARY))),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          new Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Lời nhắn:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              )),
          SizedBox(
            height: 10,
          ),
          new Align(
              alignment: Alignment.topLeft,
              child: Text(
                temp.message,
                style: TextStyle(fontSize: 20.0),
              )),
          if (temp.status == false)
            Padding(
              padding:
                  const EdgeInsets.only(right: 40.0, left: 40.0, top: 40.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: RaisedButton(
                  color: Color(COLOR_PRIMARY),
                  child: Text(
                    'Duyệt',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  textColor: Colors.white,
                  splashColor: Color(COLOR_PRIMARY),
                  onPressed: () async {
                    await context
                        .read<AdminViewModel>()
                        .approveContribute(widget.id, temp)
                        .then((_) async {
                      await popupOK(context, "Đã duyệt")
                          .then((value) => Navigator.pop(context));
                    });
                  },
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Color(COLOR_PRIMARY))),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 40.0, left: 40.0, top: 40.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity),
              child: RaisedButton(
                color: Colors.red,
                child: Text(
                  'Xóa',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                textColor: Colors.white,
                splashColor: Color(COLOR_PRIMARY),
                onPressed: () async {
                  await context
                      .read<LibraryViewModel>()
                      .deleteFoderLectureDataStore(widget.folderId)
                      .then((_) async {
                    await context
                        .read<AdminViewModel>()
                        .rejecteContribute(widget.id);
                    await popupOK(context, "Đã xóa")
                        .then((value) => Navigator.pop(context));
                  });
                },
                padding: EdgeInsets.only(top: 12, bottom: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Color(COLOR_PRIMARY))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
