import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class DragWidget extends StatefulWidget {
  //double x;

  final Widget child;
  final DraggableCanceledCallback onDraggableCanceled;
  final void Function(double price) changePrice;
  final double x;
  final double y;

  const DragWidget(
      {Key key,
      this.onDraggableCanceled,
      this.changePrice,
      this.x,
      this.y,
      this.child})
      : super(key: key);

  void getpositionaa() {
    changePrice(10.0);
  }

  @override
  _DragWidgetState createState() => _DragWidgetState();
}

class _DragWidgetState extends State<DragWidget> {
  double widths = 100.0, heights = 200.0;
  Offset position;
  //void onmov(int x) {}; void Function(Velocity velocity, Offset offset);
  @override
  void initState() {
    super.initState();
    position = Offset(100.0, 200.0);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: 100,
      height: 240,
      left: widget.x,
      top: widget.y,
      child: Stack(
        children: <Widget>[
          Draggable(
              child: widget.child,
              feedback: Container(
                decoration: new BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.grey)),
                width: 1,
                height: 200,
              ),
              onDraggableCanceled: widget.onDraggableCanceled),
          Positioned(
              left: 100 / 2 - 5,
              top: widget.y,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ))
        ],
      ),
    );
  }
}
