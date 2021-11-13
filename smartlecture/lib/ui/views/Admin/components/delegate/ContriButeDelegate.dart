import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/models/admin_model/Contribute.dart';

import 'package:smartlecture/ui/views/Admin/components/ContributeDetailScreen.dart';

import 'package:smartlecture/ui/views/Lybrary/Lybrary_viewmodel.dart';
import 'package:smartlecture/widgets/components/Page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/user_model/user.dart';
import 'package:smartlecture/services/helper.dart';
import 'package:smartlecture/ui/modules/function.dart';
import 'package:smartlecture/widgets/popup/popup.dart';

import '../../Dashboard_ViewModel.dart';

int _value;

class ContributeDeledate extends StatefulWidget {
  final DocumentSnapshot doc;
  const ContributeDeledate({Key key, this.doc}) : super(key: key);

  @override
  State<ContributeDeledate> createState() => _ContributeDeledateState();
}

class _ContributeDeledateState extends State<ContributeDeledate> {
  @override
  Widget build(BuildContext context) {
    Contribute data = Contribute.fromJson(widget.doc.data());
    User us = User();
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
              if (value == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContributeDetail(
                            id: widget.doc.id,
                            contibute: data,
                            user: us,
                            folderId: data.path,
                          )),
                );
              }
              if (value == 2) {
                String id = widget.doc.id;
                data.status = true;
                await context
                    .read<AdminViewModel>()
                    .approveContribute(id, data)
                    .then((_) async {
                  await popupOK(context, "Đã duyệt");
                });
              }
            },
            itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text("Chi tiết"),
                    value: 1,
                  ),
                  if (data.status == false)
                    PopupMenuItem(
                      child: Text("Duyệt"),
                      value: 2,
                    ),
                ]),
      ),
    );
  }
}
