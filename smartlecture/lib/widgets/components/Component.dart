import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/lecture_model/Item.dart';
import 'package:smartlecture/ui/modules/Scale.dart';
import 'package:smartlecture/ui/modules/function.dart';
import 'package:smartlecture/widgets/common/ResizebleWidget.dart';
import 'package:smartlecture/widgets/components/YoutubePlayer.dart';
import 'package:smartlecture/widgets/manage/FormEdit.dart';

class Component extends StatefulWidget {
  final Item item;
  final Function(Item) onDataChange;
  final bool isSelect;
  final VoidCallback onHold;
  final VoidCallback onTap;
  final ScalePage scale;
  const Component(
      {Key key,
      this.onDataChange,
      this.item,
      this.scale,
      this.isSelect,
      this.onTap,
      this.onHold})
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
      onDoubleTap: () async {
        await moveManageData().then((value) {
          setState(() {});
        });
      },
      onPositionChange: (x, y) {
        temp.x = x;
        temp.y = y;
        widget.onDataChange(temp);
      },
      onHold: widget.onHold,
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

  Future moveManageData() async {
    if (typeName.map[temp.name] == Type.IIMAGE) {
      await editMedia(context, temp.itemInfo.image.url, false).then((value) {
        if (value != null || value != "") {
          temp.itemInfo.image.url = value;
          savedata(temp);
          setState(() {});
        }
      });
    } else if (typeName.map[temp.name] == Type.ITEXTBLOCK) {
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
        setState(() {});
      });
    } else if (typeName.map[temp.name] == Type.IMAINMEDIA) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => YoutubePlayerEdit(
                  url: temp.itemInfo.media.mediaUrl,
                )),
      ).then((url) {
        if (url != null) {
          print("                   url: $url");
          temp.itemInfo.media.mediaUrl = url;
        }
      });
    }
    setState(() {});
  }
}
