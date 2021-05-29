import 'package:flutter/material.dart';
import 'package:smartlecture/models/Item.dart';
import 'package:smartlecture/models/Text.dart' as iText;
import 'package:smartlecture/ui/modules/function.dart';

import '../../constants.dart';

class EditText extends StatefulWidget {
  final Item item;
  final Function(iText.Text) returnData;

  const EditText({Key key, this.item, this.returnData}) : super(key: key);

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  TextEditingController textController = new TextEditingController();
  iText.Text temp = new iText.Text();
  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      temp = widget.item.itemInfo.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 100,
            child: TextField(
              style: TextStyle(
                fontStyle:
                    toBool(temp.italic) ? FontStyle.italic : FontStyle.normal,
                fontWeight:
                    toBool(temp.bold) ? FontWeight.bold : FontWeight.normal,
                fontSize: temp.size > 10 ? temp.size : 10,
                fontFamily: temp.font,
                decoration: toBool(temp.underline)
                    ? TextDecoration.underline
                    : TextDecoration.none,
                //color: Color(int.parse(temp.color))
              ),
              keyboardType: TextInputType.multiline,
              controller: textController,
              maxLines: null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                        PopupMenuButton(
                          icon: Icon(Icons.color_lens_rounded),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                value: 1,
                                child: Container(
                                    height: 300,
                                    width: 300,
                                    child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 40,
                                              childAspectRatio: 1,
                                              crossAxisSpacing: 5,
                                              mainAxisSpacing: 5),
                                      itemCount: mdColors.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: EdgeInsets.all(1),
                                          height: 40,
                                          width: 40,
                                          color: hexToColor(mdColors[index]),
                                        );
                                      },
                                    )))
                          ],
                        ),
                        IconButton(
                            icon: Icon(Icons.format_align_left_sharp),
                            onPressed: () {
                              setState(() {
                                temp.align = "left";
                              });
                            }),
                        IconButton(
                            icon: Icon(Icons.format_align_center_sharp),
                            onPressed: () {
                              setState(() {
                                temp.align = "center";
                              });
                            }),
                        IconButton(
                            icon: Icon(Icons.format_align_right_sharp),
                            onPressed: () {
                              setState(() {
                                temp.align = "right";
                              });
                            }),
                        IconButton(
                            icon: Icon(Icons.format_bold_sharp),
                            onPressed: () {
                              setState(() {
                                temp.bold =
                                    temp.bold == "true" ? "false" : "true";
                              });
                            }),
                        IconButton(
                            icon: Icon(Icons.format_italic_sharp),
                            onPressed: () {
                              setState(() {
                                temp.italic =
                                    temp.italic == "true" ? "false" : "true";
                              });
                            }),
                        IconButton(
                            icon: Icon(Icons.format_underline_sharp),
                            onPressed: () {
                              setState(() {
                                temp.italic =
                                    temp.underline == "true" ? "false" : "true";
                              });
                            }),
                        IconButton(
                            icon: Icon(Icons.format_color_fill),
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
    );
  }
}

extension HexColor on Color {
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
