import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/Item.dart';
import 'package:smartlecture/models/Text.dart' as iText;
import 'package:smartlecture/ui/modules/Navi.dart';
import 'package:smartlecture/ui/modules/Scale.dart';
import 'package:smartlecture/ui/modules/function.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/widgets/common/ResizebleWidget.dart';
import 'package:smartlecture/widgets/dataViewModel/Itext.dart';
import 'package:smartlecture/widgets/manage/AddLink.dart';
import 'package:smartlecture/widgets/manage/FormEdit.dart';

class Component extends StatefulWidget {
  final Item item;
  final Function(dynamic) onDataChange;
  final ScalePage scale;
  const Component({Key key, this.onDataChange, this.item, this.scale})
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
    return new ResizebleWidget(
      scale: widget.scale,
      x: temp.x,
      y: temp.y,
      width: temp.width,
      height: temp.height,
      child: fromItem(widget.item),
      onDoubleTap: moveManageData,
      onPositionChange: (x, y) {
        // temp.x = x;
        // temp.y = y;
        //widget.onDataChange(temp);
      },
      onSizeChange: (width, height) {
        // temp.width = width;
        // temp.height = height;
        widget.onDataChange(temp);
      },
    );
  }

  void savedata(Item s) async {
    temp = s;
    //widget.onDataChange(temp);
  }

  void moveManageData() async {
    final information = await Navigator.push(
      context,
      CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (context) => FormEdit(
                item: temp,
              )),
    );
    if (information == null) return;
    savedata(information);
  }
}
