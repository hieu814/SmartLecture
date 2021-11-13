import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/admin_model/Contribute.dart';
import 'package:smartlecture/models/admin_model/Lybrary.dart';
import 'package:smartlecture/models/lecture_model/Lecture.dart';
import 'package:smartlecture/models/user_model/user.dart';
import 'package:smartlecture/ui/modules/UserService.dart';
import 'package:smartlecture/ui/modules/function.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Admin/Dashboard_ViewModel.dart';
import 'package:smartlecture/ui/views/Admin/components/ContributeDetailScreen.dart';
import 'package:smartlecture/ui/views/Lybrary/Lybrary_viewmodel.dart';

bool isadmin = false;
int _value;

class ListLectures extends StatefulWidget {
  ListLectures({Key key}) : super(key: key);

  static const String _title = 'Danh sách bài giảng';

  @override
  State<ListLectures> createState() => _ListLecturesState();
}

class _ListLecturesState extends State<ListLectures> {
  @override
  void initState() {
    isadmin = locator<UserService>().currentUser.role == USER_ROLE_ADMIN;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ListLectures._title),
        automaticallyImplyLeading: true,
      ),
      body: const Contribute_Widget(),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class Contribute_Widget extends StatefulWidget {
  const Contribute_Widget({Key key}) : super(key: key);

  @override
  State<Contribute_Widget> createState() => _Contribute_WidgetState();
}

class _Contribute_WidgetState extends State<Contribute_Widget> {
  @override
  Widget build(BuildContext context) {
    //context.read<LibraryViewModel>().getdataLybrary("");

    return Consumer<LibraryViewModel>(builder: (context, model, child) {
      return StreamBuilder<Object>(
          stream: context.read<LibraryViewModel>().streamData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Danh sách bài giảng",
                          style: TextStyle(
                              color: Color(COLOR_PRIMARY),
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0),
                        )),
                    SizedBox(height: 20),
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
    });
  }

  List<Widget> _createRows(QuerySnapshot snapshot) {
    List<Widget> newList = [];
    newList = snapshot.docs.map((DocumentSnapshot documentSnapshot) {
      return createDelegate(documentSnapshot);
    }).toList();
    return newList;
  }

  Widget createDelegate(DocumentSnapshot datastore) {
    User us = User();
    Contribute data = Contribute.fromJson(datastore.data());
    return Card(
      child: ListTile(
        leading: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 44,
            minHeight: 44,
            maxWidth: 64,
            maxHeight: 64,
          ),
          child: Icon(Icons.insert_drive_file),
        ),
        title: GestureDetector(
          child: Text(data.lectureName ?? ""),
          onTap: () async {
            // Navigator.pushNamed(
            //     context, RouteName.presentation,
            //     arguments: item.lecture);
          },
        ),
        subtitle: FutureBuilder(
            initialData: User(),
            future:
                context.read<LibraryViewModel>().getAuthor(data.contributorId),
            builder: (BuildContext context, AsyncSnapshot<User> users) {
              us = users.data;
              return new Text("Tác giả: " + users.data.fullName());
            }),
        trailing: PopupMenuButton(
            icon: Icon(Icons.more_vert),
            elevation: 20,
            enabled: true,
            onSelected: (value) async {
              _value = value;
              if (isadmin) {
                if (value == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContributeDetail(
                              id: datastore.id,
                              contibute: data,
                              user: us,
                              folderId: data.path,
                            )),
                  );
                }
              } else {
                Lecture a = await context
                    .read<AdminViewModel>()
                    .getLectureFromId(data.lectureId);
                if (value == 1) {
                  Navigator.pushNamed(context, RouteName.presentation,
                      arguments: a);
                } else {
                  await context
                      .read<LibraryViewModel>()
                      .downloadFromLybrary(context, a, data.lectureId)
                      .then((value) {
                    showInSnackBar(context, "Đã tải về");
                  });
                }
              }
            },
            itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text(isadmin ? "Chi tiết" : "Xem"),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text(isadmin ? "Duyệt" : "Tải về"),
                    value: 2,
                  ),
                ]),
      ),
    );
  }
}

List<PopupMenuEntry<dynamic>> createButton() {
  if (isadmin) {
    return [
      PopupMenuItem(
        child: Text("Xem"),
        value: 1,
      ),
      PopupMenuItem(
        child: Text("Tải về"),
        value: 2,
      ),
    ];
  } else {
    return [
      PopupMenuItem(
        child: Text("Chi tiết"),
        value: 1,
      ),
    ];
  }
}
