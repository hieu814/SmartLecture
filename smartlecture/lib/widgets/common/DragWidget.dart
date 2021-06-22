import 'package:flutter/material.dart';

class DragWidget extends StatefulWidget {
  final Function onDrag;
  final Function onDragEnd;
  final VoidCallback onDoubleTap;
  final VoidCallback onTap;
  final Widget child;
  DragWidget(
      {Key key,
      this.onDrag,
      this.child,
      this.onDragEnd,
      this.onDoubleTap,
      this.onTap});
  @override
  _DragWidgetState createState() => _DragWidgetState();
}

class _DragWidgetState extends State<DragWidget> {
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
        onDoubleTap: widget.onDoubleTap,
        onTap: widget.onTap,
        child: widget.child);
  }
}
