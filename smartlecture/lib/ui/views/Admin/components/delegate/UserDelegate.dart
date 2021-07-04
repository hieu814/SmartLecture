import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/user_model/user.dart';
import 'package:smartlecture/services/helper.dart';
import 'package:smartlecture/ui/modules/function.dart';
import 'package:smartlecture/widgets/popup/popup.dart';

import '../../Dashboard_ViewModel.dart';

class UserDelegate extends StatelessWidget {
  final DocumentSnapshot doc;
  const UserDelegate({Key key, this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = User.fromJson(doc.data());
    print("delegate odcstring" + doc.data().toString());
    return Card(
      color: Colors.lightGreenAccent,
      child: ListTile(
        leading: CircleAvatar(
          child: displayCircleImage(user.profilePictureURL, 125, false),
        ),
        title: Text(
          user.fullName(),
          style:
              TextStyle(color: user.role == "admin" ? Colors.red : Colors.blue),
        ),
        subtitle: Column(
          children: [
            Row(children: [Text("Email: "), Text(user.email)]),
            Row(children: [Text("Phone number: "), Text(user.phoneNumber)]),
            Row(children: [
              Text("Role: "),
              Text(
                user.role,
                style: TextStyle(
                    color: user.role == "admin" ? Colors.red : Colors.blue),
              )
            ]),
          ],
        ),
        trailing:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Wrap(
            spacing: 2,
            children: <Widget>[
              GestureDetector(
                child: Icon(Icons.edit),
                onTap: () async {
                  editDatabase(context, doc, USERS);
                },
              ),
              GestureDetector(
                child: Icon(
                  Icons.delete_rounded,
                  color: Colors.red,
                ),
                onTap: () async {
                  popupYesNo(context).then((value) {
                    if (value) {
                      context
                          .read<AdminViewModel>()
                          .deleteItem(doc.id)
                          .then((value) => showInSnackBar(context, "đã xóa"));
                    }
                  });
                },
              ), // icon-1
              // icon-2
            ],
          ),
        ]),
      ),
    );
  }
}
