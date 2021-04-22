import 'package:flutter/material.dart';

class ManipulatingBall extends StatefulWidget {
  ManipulatingBall({Key key, this.onDrag, this.child, this.onDragEnd});

  final Function onDrag;
  final Function onDragEnd;
  final Widget child;
  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
}

class _ManipulatingBallState extends State<ManipulatingBall> {
  double initX;
  double initY;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanStart: _handleDrag,
        onPanUpdate: _handleUpdate,
        onPanEnd: (_) {
          widget.onDragEnd();
        },
        child: widget.child);
  }
}
