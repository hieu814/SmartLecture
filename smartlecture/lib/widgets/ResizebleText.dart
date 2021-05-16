import 'package:flutter/material.dart';
import 'package:smartlecture/models/ItemText.dart';
import 'package:smartlecture/widgets/common/ResizebleWidget.dart';
import 'package:smartlecture/widgets/manage/AddLink.dart';

class ResizebleText extends StatefulWidget {
  final ItemText data;
  final Function(dynamic) onDataChange;
  const ResizebleText({Key key, this.data, this.onDataChange})
      : super(key: key);
  @override
  _ResizebleTextState createState() => _ResizebleTextState();
}

class _ResizebleTextState extends State<ResizebleText> {
  TextEditingController textController = new TextEditingController();
  FocusNode _focusNode;
  ItemText temp = new ItemText();
  @override
  void initState() {
    super.initState();
    textController.text = widget.data.text;
    temp = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return ResizebleWidget(
      x: widget.data.x,
      y: widget.data.y,
      width: widget.data.width,
      height: widget.data.height,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          isDense: false,
          contentPadding: const EdgeInsets.all(10.0),
          // Added this
        ),
        expands: true,
        controller: textController,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        onEditingComplete: () {
          _focusNode.unfocus();
        },

        // textInputAction: TextInputAction.done
      ),
      onDoubleTap: () {
        showDialog(
            context: context,
            builder: (_) => new AddLink(
                  //txtDescription: "asdasad",
                  returnData: (s) {
                    Navigator.of(context).pop();
                  },
                ));
      },
      onPositionChange: (x, y) {
        temp.x = x;
        temp.y = y;
      },
      onSizeChange: (width, height) {
        temp.width = width;
        temp.height = height;
      },
    );
  }
}
