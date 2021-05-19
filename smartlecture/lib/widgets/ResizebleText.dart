import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/models/ItemText.dart';
import 'package:smartlecture/widgets/common/ResizebleWidget.dart';
import 'package:smartlecture/widgets/manage/AddLink.dart';
import 'package:smartlecture/widgets/manage/EditText.dart';

class ResizebleText extends StatefulWidget {
  final ItemText data;
  final Function(dynamic) onDataChange;
  const ResizebleText({Key key, this.data, this.onDataChange})
      : super(key: key);
  @override
  _ResizebleTextState createState() => _ResizebleTextState();
}

class _ResizebleTextState extends State<ResizebleText> {
  FocusNode _focusNode;
  ItemText temp = new ItemText();
  @override
  void initState() {
    super.initState();
    temp = widget.data;
  }

  void savedata(dynamic s) {
    temp.text = s;
    widget.onDataChange(temp);
  }

  void moveToSecondPage() async {
    final information = await Navigator.push(
      context,
      CupertinoPageRoute(
          fullscreenDialog: true, builder: (context) => EditText()),
    );

    savedata(information);
  }

  @override
  Widget build(BuildContext context) {
    return ResizebleWidget(
      x: widget.data.x,
      y: widget.data.y,
      width: widget.data.width,
      height: widget.data.height,
      child: Text(widget.data.text),
      onDoubleTap: () {
        moveToSecondPage();
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
