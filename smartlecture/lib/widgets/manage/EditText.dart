import 'package:flutter/material.dart';
import 'package:smartlecture/models/Item.dart';
import 'package:smartlecture/models/Text.dart' as iText;
import 'package:smartlecture/models/common/MyColors.dart';
import 'package:smartlecture/ui/modules/function.dart';

import '../../constants.dart';

class EditText extends StatefulWidget {
  final Item item;
  final Function(Item) returnData;

  const EditText({Key key, this.item, this.returnData}) : super(key: key);

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  TextEditingController textController = new TextEditingController();

  Item temp;
  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      temp = widget.item;
      textController.text = temp.itemInfo.text.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.returnData(temp);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      PopupMenuButton(
                        icon: Icon(
                          Icons.format_color_text,
                          color: hexToColor(temp.itemInfo.text.color),
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              padding: EdgeInsets.all(0),
                              enabled: false,
                              value: 1,
                              child: Center(
                                child: Container(
                                    height: 300,
                                    width: 100,
                                    child: ListView.builder(
                                      itemCount: mainColors.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          child: Card(
                                            child: Container(
                                              padding: EdgeInsets.all(1),
                                              height: 40,
                                              width: 40,
                                              color: mainColors[index],
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              temp.itemInfo.text.color =
                                                  mainColors[index]
                                                      .toHex()
                                                      .toString();
                                            });
                                          },
                                        );
                                      },
                                    )),
                              ))
                        ],
                      ),
                      IconButton(
                          icon: Icon(Icons.format_bold_sharp),
                          onPressed: () {
                            setState(() {
                              temp.itemInfo.text.bold =
                                  temp.itemInfo.text.bold == "true"
                                      ? "false"
                                      : "true";
                            });
                          }),
                      IconButton(
                          icon: Icon(Icons.format_italic_sharp),
                          onPressed: () {
                            setState(() {
                              temp.itemInfo.text.italic =
                                  temp.itemInfo.text.italic == "true"
                                      ? "false"
                                      : "true";
                            });
                          }),
                      IconButton(
                          icon: Icon(Icons.format_underline_sharp),
                          onPressed: () {
                            setState(() {
                              temp.itemInfo.text.underline =
                                  temp.itemInfo.text.underline == "true"
                                      ? "false"
                                      : "true";
                            });
                          }),
                      IconButton(
                          icon: Icon(Icons.format_align_left_sharp),
                          onPressed: () {
                            setState(() {
                              temp.itemInfo.text.align = "left";
                            });
                          }),
                      IconButton(
                          icon: Icon(Icons.format_align_center_sharp),
                          onPressed: () {
                            setState(() {
                              temp.itemInfo.text.align = "center";
                            });
                          }),
                      IconButton(
                          icon: Icon(Icons.format_align_right_sharp),
                          onPressed: () {
                            setState(() {
                              temp.itemInfo.text.align = "right";
                            });
                          }),
                      Container(
                        child: DropdownButton<int>(
                          value: temp.itemInfo.text.size.toInt(),
                          onChanged: (i) {
                            setState(() {
                              temp.itemInfo.text.size = i.toDouble();
                            });
                          },
                          items: List.generate(
                              40,
                              (index) => DropdownMenuItem<int>(
                                    value: index,
                                    child: Text(index.toString()),
                                  )),
                        ),
                      )
                    ],
                  ),
                  //decoration:
                  //BoxDecoration(border: Border.all(color: Colors.red)),
                )),
          ),
          Expanded(
            flex: 7,
            child: TextField(
              style: TextStyle(
                  fontStyle: toBool(temp.itemInfo.text.italic)
                      ? FontStyle.italic
                      : FontStyle.normal,
                  fontWeight: toBool(temp.itemInfo.text.bold)
                      ? FontWeight.bold
                      : FontWeight.normal,
                  fontSize: temp.itemInfo.text.size,
                  fontFamily: temp.itemInfo.text.font,
                  decoration: toBool(temp.itemInfo.text.underline)
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  color: hexToColor(temp.itemInfo.text.color)),
              keyboardType: TextInputType.multiline,
              controller: textController,
              maxLines: null,
              textAlign: getTextAlign(temp.itemInfo.text.align),
              onChanged: (s) {
                temp.itemInfo.text.text = s;
                widget.returnData(temp);
              },
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
