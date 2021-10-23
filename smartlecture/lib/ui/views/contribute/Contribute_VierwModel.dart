import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smartlecture/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartlecture/models/lecture_model/LectuteData.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/contribute/Contribute_view.dart';
import 'package:smartlecture/widgets/components/Page.dart';
import 'package:smartlecture/widgets/popup/popup.dart';

File _image;

class ContributeScreen extends StatefulWidget {
  @override
  State createState() => _ContributeState();
}

ImagePicker sl;
String path = "";

class _ContributeState extends State<ContributeScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  TextEditingController _passwordController = new TextEditingController();
  GlobalKey<FormState> _key = new GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;
  String message = "-";

  int index = 0;
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      retrieveLostData();
    }
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
            autovalidateMode: _validate,
            child: formUI(),
          ),
        ),
      ),
    );
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _imagePicker.getLostData();
    if (response == null) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image = File(response.file.path);
      });
    }
  }

  Widget formUI() {
    return SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          new Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Đóng góp bài giảng',
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
              child: Text(
                'Chọn bài giảng',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              )),
          SizedBox(
            height: 10,
          ),
          Consumer<ContributeViewModel>(builder: (context, model, child) {
            return Container(
              height: 50,
              width: double.infinity,
              child: DropdownButton<dynamic>(
                  iconSize: 30,
                  isExpanded: true,
                  value: index,
                  onChanged: (val) {
                    setState(() {
                      index = val;
                    });
                  },
                  items: etDropDownMenuItems()),
            );
          }),
          new Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Chọn Mục',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              )),
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
                    'Chọn',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  textColor: Colors.white,
                  splashColor: Color(COLOR_PRIMARY),
                  onPressed: () async {
                    final value = await Navigator.pushNamed(
                        context, RouteName.libraryTree,
                        arguments: TypeFolder.FOLDER_NULL);
                    print("------------------path : $value");
                    path = value;
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
          ConstrainedBox(
              constraints: BoxConstraints(minWidth: double.infinity),
              child: Container(
                height: 300,
                child: Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
                    child: TextFormField(
                        maxLines: null,
                        onChanged: (String val) {
                          message = val;
                        },
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                        decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            fillColor: Colors.white,
                            labelText: 'Lời nhắn',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                    color: Color(COLOR_PRIMARY), width: 2.0)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )))),
              )),
          Padding(
            padding: const EdgeInsets.only(right: 40.0, left: 40.0, top: 40.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity),
              child: RaisedButton(
                color: Color(COLOR_PRIMARY),
                child: Text(
                  'Đóng góp',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                textColor: Colors.white,
                splashColor: Color(COLOR_PRIMARY),
                onPressed: () async {
                  if (context.read<ContributeViewModel>().myLecture.length <
                      1) {
                    popupOK(context, "Vui lòng chọn một bài giảng");
                    return;
                  }
                  if (path == "") {
                    popupOK(context, "Vui lòng chọn một mục");
                    return;
                  }
                  await context
                      .read<ContributeViewModel>()
                      .contribute(index, message, path)
                      .then((_) async {
                    await popupOK(context, "Cảm ơn bạn đã đóng góp")
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

  @override
  void dispose() {
    _passwordController.dispose();
    _image = null;
    super.dispose();
  }

  etDropDownMenuItems() {
    print("get lecture ");

    List<DropdownMenuItem> _items = [];
    List<String> list = context.read<ContributeViewModel>().myLecture;
    list.asMap().forEach((index, item) {
      print(item);
      _items.add(
        DropdownMenuItem<int>(
          value: index,
          child: SizedBox(
            width: 300,
            child: Text(
              item,
              style: TextStyle(
                color: Color(COLOR_PRIMARY),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    });
    return _items;
  }
}
