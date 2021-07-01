import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartlecture/models/admin_model/RecentFile.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:smartlecture/models/lecture_model/Lecture.dart';
import 'package:smartlecture/models/user_model/user.dart';
import '../../../../constants.dart';

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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(_typeData)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    return DataTable2(
                        columnSpacing: defaultPadding,
                        minWidth: 600,
                        columns: _titleTable(),
                        rows: _createRows(snapshot.data));
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

List<DataColumn> _titleTable() {
  List<String> dataList = [];

  if (_typeData == USERS) {
    dataList = listUserTitle;
  } else if (_typeData == LECTUTES) {
    dataList = listLectureTitle;
  }
  return dataList.map((e) {
    return DataColumn2(size: ColumnSize.L, label: Text(e));
  }).toList();
}

List<DataRow> _createRows(QuerySnapshot snapshot) {
  List<DataRow> newList =
      snapshot.docs.map((DocumentSnapshot documentSnapshot) {
    return dataRow(documentSnapshot);
  }).toList();

  return newList;
}

DataRow dataRow(DocumentSnapshot documentSnapshot) {
  List<String> dataList = [];
  if (_typeData == USERS) {
    User u = User.fromJson(documentSnapshot.data());
    dataList.add(u.fullName());
    dataList.add(u.email);
    dataList.add(u.phoneNumber);
    dataList.add(DateFormat('yyyy-MM-dd')
        .format(u.lastOnlineTimestamp.toDate())
        .toString());
    dataList.add(u.role);
  } else if (_typeData == LECTUTES) {
    Lecture a = Lecture.fromJson(documentSnapshot.data());
    dataList.add(a.title);
    dataList.add(a.authorId);
    dataList.add(a.createdDate);
    dataList.add(a.editedDate);
  }
  return DataRow(
      cells: List.generate(
    dataList.length,
    (index) => DataCell(Text(dataList[index]),
        placeholder: true, showEditIcon: index == dataList.length - 1),
  ));
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
