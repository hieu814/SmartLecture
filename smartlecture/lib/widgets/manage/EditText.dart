import 'package:flutter/material.dart';

class EditText extends StatefulWidget {
  final String data;
  final Function(String) returnData;

  const EditText({Key key, this.data, this.returnData}) : super(key: key);

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  TextEditingController textController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      textController.text = widget.data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick an option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 100,
              child: TextField(
                keyboardType: TextInputType.multiline,
                controller: textController,
                maxLines: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, textController.text);
                },
                child: Text('Nope.'),
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 0),
                    child: Container(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.format_color_text),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(Icons.image_sharp), onPressed: () {}),
                          IconButton(
                              icon: Icon(Icons.video_label), onPressed: () {}),
                          IconButton(
                              icon: Icon(Icons.format_align_center_sharp),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(Icons.format_align_left_sharp),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(Icons.format_align_right_sharp),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(Icons.format_bold_sharp),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(Icons.format_color_fill),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(Icons.format_italic_sharp),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(Icons.format_shapes_sharp),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(Icons.format_underline_sharp),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(Icons.format_indent_decrease_sharp),
                              onPressed: () {}),
                        ],
                      ),
                      //decoration:
                      //BoxDecoration(border: Border.all(color: Colors.red)),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
