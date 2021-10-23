import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/lecture_model/Item.dart';
import 'package:smartlecture/ui/modules/Scale.dart';
import 'package:smartlecture/ui/modules/function.dart';
import 'package:smartlecture/widgets/common/ResizebleWidget.dart';
import 'package:smartlecture/widgets/manage/FormEdit.dart';

class Component extends StatefulWidget {
  final Item item;
  final Function(Item) onDataChange;
  final bool isSelect;
  final VoidCallback onTap;
  final ScalePage scale;
  const Component(
      {Key key,
      this.onDataChange,
      this.item,
      this.scale,
      this.isSelect,
      this.onTap})
      : super(key: key);
  @override
  _ComponentState createState() => _ComponentState();
}

class _ComponentState extends State<Component> {
  Item temp = new Item();
  @override
  void initState() {
    super.initState();
    temp = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    temp = widget.item;
    return ResizebleWidget(
      isSelect: widget.isSelect ?? false,
      scale: widget.scale,
      x: temp.x,
      y: temp.y,
      width: temp.width,
      height: temp.height,
      child: fromItem(widget.item),
      onDoubleTap: moveManageData,
      onPositionChange: (x, y) {
        temp.x = x;
        temp.y = y;
        widget.onDataChange(temp);
      },
      onTap: widget.onTap,
      onSizeChange: (height, width) {
        temp.width = width;
        temp.height = height;
        widget.onDataChange(temp);
      },
    );
  }

  void savedata(Item s) async {
    setState(() {
      temp = s;
    });

    widget.onDataChange(temp);
  }

  void moveManageData() async {
    if (typeName.map[temp.name] == Type.IIMAGE) {
      await editMedia(context, temp.itemInfo.image.url, false).then((value) {
        if (value != null || value != "") {
          temp.itemInfo.image.url = value;
          savedata(temp);
        }
      });
    } else {
      await Navigator.push(
        context,
        CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (context) => FormEdit(
                  item: temp,
                )),
      ).then((value) {
        if (value == null) return;
        savedata(value);
      });
    }
  }
}
