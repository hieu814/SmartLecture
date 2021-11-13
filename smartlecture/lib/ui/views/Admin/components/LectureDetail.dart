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
import 'package:smartlecture/responsive.dart';
import 'package:smartlecture/services/helper.dart';
import 'package:smartlecture/ui/modules/function.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Admin/Dashboard_ViewModel.dart';
import 'package:smartlecture/ui/views/Lybrary/Lybrary_viewmodel.dart';
import 'package:smartlecture/ui/views/contribute/Contribute_view.dart';
import 'package:smartlecture/widgets/components/Page.dart';
import 'package:smartlecture/widgets/popup/popup.dart';

class LectureDetail extends StatefulWidget {
  final Lecture lecture;
  final String id;
  const LectureDetail({Key key, this.id, this.lecture}) : super(key: key);
  @override
  State createState() => _LectureDetailState();
}

String path = "";

class _LectureDetailState extends State<LectureDetail> {
  GlobalKey<FormState> _key = new GlobalKey();
  String message = "-";
  //Contribute temp;
  int index = 0;
  @override
  void initState() {
    // temp = widget.lecture;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {}
    context.read<ContributeViewModel>().load();
    return Scaffold(
      appBar: AppBar(
          //iconTheme: IconThemeData(color: Colors.black),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.delete_forever),
              color: Colors.red,
              onPressed: () async {
                popupYesNo(context).then((value) {
                  if (value) {
                    showProgress(context, 'Đang xóa...', true);
                    Future.delayed(const Duration(milliseconds: 300), () async {
                      context
                          .read<AdminViewModel>()
                          .deleteItem(widget.id)
                          .then((value) {
                        hideProgress();
                        showInSnackBar(context, "đã xóa");
                        Navigator.pop(context);
                      });
                    });
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                Navigator.pushNamed(context, RouteName.sectionPage,
                    arguments:
                        LectuteData(id: widget.id, lecture: widget.lecture));
              },
            ),
          ]),
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
                      widget.lecture.title ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  Expanded(
                      child: IconButton(
                          onPressed: () async {
                            Navigator.pushNamed(context, RouteName.presentation,
                                arguments: widget.lecture);
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Text(
                          'Chi tiết tác giả',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: RaisedButton(
                          color: Color(COLOR_PRIMARY),
                          child: Text(
                            'Chi tiết',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          textColor: Colors.white,
                          splashColor: Color(COLOR_PRIMARY),
                          onPressed: () async {},
                          //padding: EdgeInsets.only(top: 12, bottom: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(color: Color(COLOR_PRIMARY))),
                        ),
                      )
                    ],
                  ),
                ],
              )),
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
              initialData: User(),
              future: context
                  .read<LibraryViewModel>()
                  .getAuthor(widget.lecture.authorId),
              builder: (BuildContext context, AsyncSnapshot<User> users) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Text("Tác giả:   ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15.0)),
                        Text(
                            users.data.firstName == ""
                                ? "Không rõ"
                                : users.data.fullName(),
                            style: TextStyle(fontSize: 15.0)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("Email:      ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15.0)),
                        Text(
                            users.data.email == ""
                                ? "Không rõ"
                                : users.data.email,
                            style: TextStyle(fontSize: 15.0)),
                      ],
                    ),
                  ],
                );
              }),
          SizedBox(
            height: 10,
          ),
          new Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Chi tiết bài giảng',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              )),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Row(
                children: [
                  Text("Ngày tạo:   ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0)),
                  Text(widget.lecture.createdDate,
                      style: TextStyle(fontSize: 15.0)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Ngày sửa:      ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0)),
                  Text(widget.lecture.editedDate,
                      style: TextStyle(fontSize: 15.0)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
