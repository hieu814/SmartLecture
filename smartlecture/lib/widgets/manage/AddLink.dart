import 'package:flutter/material.dart';

class AddOneData extends StatefulWidget {
  final String title;
  final String data;

  const AddOneData({Key key, this.data, this.title}) : super(key: key);

  @override
  _AddOneDataState createState() => _AddOneDataState();
}

class _AddOneDataState extends State<AddOneData> {
  TextEditingController imgUrlController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      imgUrlController.text = widget.data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(widget.title ?? "Nhập"),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: imgUrlController,
              maxLines: null,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Huỷ'),
          onPressed: () {
            Navigator.pop(context, "");
          },
        ),
        TextButton(
            child: Text("Lưu"),
            onPressed: () {
              Navigator.pop(context, imgUrlController.text);
            })
      ],
    );
  }
}
