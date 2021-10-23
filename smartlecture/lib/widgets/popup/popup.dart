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

Future<bool> popupYesNo(BuildContext context, {String title}) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(title ?? "Bạn có chăc không?"),
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

Future<bool> popup2Option(BuildContext context,
    {String title, String op1, String op2}) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(title ?? ""),
      actions: [
        TextButton(
            child: Text(op1, style: TextStyle(color: Colors.blue)),
            onPressed: () {
              Navigator.pop(context, false);
            }),
        TextButton(
            child: Text(op2, style: TextStyle(color: Colors.blue)),
            onPressed: () {
              Navigator.pop(context, true);
            }),
        TextButton(
            child: Text("Hủy", style: TextStyle(color: Colors.grey)),
            onPressed: () {
              Navigator.pop(context, null);
            }),
      ],
    ),
  );
}

Future<bool> popupOK(BuildContext context, String title) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(title),
      actions: [
        TextButton(
            child: Text("OK", style: TextStyle(color: Colors.black)),
            onPressed: () {
              Navigator.pop(context, true);
            }),
      ],
    ),
  );
}
