import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/ui/views/Admin/Dashboard_ViewModel.dart';
import 'package:smartlecture/widgets/manage/MyForm.dart';
import '../../../../constants.dart';
import 'delegate/LectureDataDelegate.dart';
import 'delegate/UserDelegate.dart';
import 'package:provider/provider.dart';

String _typeData;

class RecentFiles extends StatefulWidget {
  const RecentFiles({
    Key key,
    this.typeData,
  }) : super(key: key);
  final String typeData;
  @override
  _RecentFilesState createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {
  @override
  void initState() {
    _typeData = widget.typeData ?? USERS;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<AdminViewModel>().setCurrentCollection(_typeData);
    return StreamBuilder<Object>(
        stream: context.read<AdminViewModel>().streamData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else
            return Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recent Files",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Container(
                    width: 1000,
                    height: 500,
                    child: Container(
                      child: ListView(
                        children: _createRows(snapshot.data),
                      ),
                    ),
                  ),
                ],
              ),
            );
        });
  }

  void moveManageData() async {
    await Navigator.push(
      context,
      CupertinoPageRoute(
          fullscreenDialog: true, builder: (context) => MyForm()),
    ).then((value) {
      if (value == null) return;
    });
  }

  List<Widget> _createRows(QuerySnapshot snapshot) {
    context.read<AdminViewModel>().setDataLength(snapshot.docs.length);
    List<Widget> newList = [];
    if (_typeData == USERS) {
      newList = snapshot.docs.map((DocumentSnapshot documentSnapshot) {
        return UserDelegate(doc: documentSnapshot);
      }).toList();
    } else if (_typeData == LECTUTES) {
      newList = snapshot.docs.map((DocumentSnapshot documentSnapshot) {
        return LectureDataDelegate(doc: documentSnapshot);
      }).toList();
    }

    return newList;
  }
}

_createDelegate(DocumentSnapshot documentSnapshot) {
  if (_typeData == USERS) {
    return UserDelegate(doc: documentSnapshot);
  } else if (_typeData == LECTUTES) {
    return UserDelegate(doc: documentSnapshot);
  }
}

List<String> listUserTitle = [
  "Tên",
  "Email",
  "SDT",
  "Đăng nhập lần cuối",
  "Quyền"
];

List<String> listLectureTitle = [
  "Title",
  "Author",
  "Created Date",
  "Edited Date"
];
List<String> listAudioTitle = [
  "Tên",
  "Email",
  "SDT"
  // "Đăng nhập lần cuối",
  // "Quyền"
];
List<String> listVideoTitle = [
  "Tên",
  "Email",
  "SDT"
  // "Đăng nhập lần cuối",
  // "Quyền"
];

class InsertDeleteUpdate extends StatelessWidget {
  const InsertDeleteUpdate({Key key, this.onTap}) : super(key: key);
  final Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      IconButton(
          onPressed: onTap(0),
          icon: Icon(
            Icons.add_circle_outline_outlined,
            color: Colors.green,
          )),
      IconButton(
          onPressed: onTap(1),
          icon: Icon(
            Icons.edit,
            color: Colors.blue,
          )),
      IconButton(
          onPressed: onTap(2),
          icon: Icon(
            Icons.delete_forever_sharp,
            color: Colors.red,
          ))
    ]);
  }
}
