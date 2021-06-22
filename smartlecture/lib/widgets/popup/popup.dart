import 'package:flutter/material.dart';
import 'package:smartlecture/widgets/manage/AddLink.dart';

Future<String> popupString(
    BuildContext context, String title, String oldData) async {
  return await showDialog(
      context: context,
      builder: (context) => AddOneData(
            title: title,
            data: oldData,
          ));
}

Future<bool> popupYesNo(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text("Bạn có chăc không?"),
      actions: [
        TextButton(
            child: Text("Không", style: TextStyle(color: Colors.grey)),
            onPressed: () {
              Navigator.pop(context, false);
            }),
        TextButton(
            child: Text("Có!", style: TextStyle(color: Colors.blue)),
            onPressed: () {
              Navigator.pop(context, true);
            })
      ],
    ),
  );
}
