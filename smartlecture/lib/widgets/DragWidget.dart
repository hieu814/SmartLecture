import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class DragWidget extends StatefulWidget {
  final String text1;
  final String text2;
  final Widget child;

  const DragWidget({Key key, this.text1, this.text2, this.child})
      : super(key: key);

  @override
  _DragWidgetState createState() => _DragWidgetState();
}

class _DragWidgetState extends State<DragWidget> {
  double width = 100.0, height = 200.0;
  Offset position;
  @override
  void initState() {
    super.initState();
    position = Offset(100.0, 200.0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          width: 100,
          height: 240,
          left: position.dx,
          top: position.dy,
          child: Draggable(
            child: widget.child,
            feedback: Container(
              decoration: new BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.grey)),
              width: 1,
              height: 200,
            ),
            onDraggableCanceled: (Velocity velocity, Offset offset) {
              setState(() {
                RenderBox renderBox = context.findRenderObject();
                position = renderBox.globalToLocal(offset);
              });
            },
          ),
        ),
      ],
    );
  }
}
