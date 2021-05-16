import 'package:flutter/material.dart';

class AddLink extends StatefulWidget {
  final String data;
  final Function(String) returnData;

  const AddLink({Key key, this.data, this.returnData}) : super(key: key);

  @override
  _AddLinkState createState() => _AddLinkState();
}

class _AddLinkState extends State<AddLink> {
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
      title: new Text("Nhập đường dẫn ảnh"),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: imgUrlController,
              decoration: InputDecoration(
                  hintText: "Image Url", labelText: "Image Url"),
              maxLines: null,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        TextButton(
            child: Text("Save"),
            onPressed: () {
              widget.returnData(imgUrlController.text);
            })
      ],
    );
  }
}
