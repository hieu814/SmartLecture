import 'package:flutter/material.dart';

import 'package:smartlecture/models/lecture_model/Item.dart';
import 'package:smartlecture/ui/modules/function.dart';

class ComponentShow extends StatefulWidget {
  final Item item;
  const ComponentShow({
    Key key,
    this.item,
  }) : super(key: key);
  @override
  _ComponentShowState createState() => _ComponentShowState();
}

class _ComponentShowState extends State<ComponentShow> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.item.y,
      left: widget.item.x,
      child: Container(
        width: widget.item.width,
        height: widget.item.height,
        child: fromItem(widget.item),
      ),
    );
  }
}
