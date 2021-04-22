import 'package:flutter/material.dart';
import 'package:smartlecture/widgets/BallWidget.dart';
import 'package:smartlecture/widgets/ManipulatingBall.dart';

const ballDiameter = 10.0;
const minsize = 30.0;

class ResizebleWidget extends StatefulWidget {
  final void Function(double dx, double dy) onPositionChange;
  final void Function(double width, double height) onSizeChange;
  final double width;
  final double height;
  final double x;
  final double y;
  final Widget child;
  ResizebleWidget(
      {this.child,
      this.onPositionChange,
      this.onSizeChange,
      this.width = 50,
      this.height = 50,
      this.x = 80,
      this.y = 80});

  @override
  _ResizebleWidgetState createState() => _ResizebleWidgetState();
}

class _ResizebleWidgetState extends State<ResizebleWidget> {
  double height = 0;
  double width = 0;
  double top = 0;
  double left = 0;

  @override
  void initState() {
    super.initState();
    height = widget.height;
    width = widget.width;
    top = widget.y;
    left = widget.x;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: Container(
            child: ManipulatingBall(
              child: Container(
                width: width,
                height: height,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: widget.child,
              ),
              onDrag: (dx, dy) {
                setState(() {
                  top = top + dy;
                  left = left + dx;
                });
              },
              onDragEnd: () {
                widget.onPositionChange(left, top);
              },
            ),
          ),
        ),
        // top middle
        Positioned(
          top: top - ballDiameter / 2,
          left: left + width / 2 - ballDiameter / 2,
          child: ManipulatingBall(
            child: BallWidget(diameter: ballDiameter),
            onDrag: (dx, dy) {
              var newHeight = height - dy;
              setState(() {
                height = newHeight > minsize ? newHeight : minsize;
                top = top + dy;
              });
            },
            onDragEnd: () {
              widget.onSizeChange(height, width);
            },
          ),
        ),
        // center right
        Positioned(
          top: top + height / 2 - ballDiameter / 2,
          left: left + width - ballDiameter / 2,
          child: ManipulatingBall(
            child: BallWidget(diameter: ballDiameter),
            onDrag: (dx, dy) {
              var newWidth = width + dx;
              setState(() {
                width = newWidth > minsize ? newWidth : minsize;
              });
            },
            onDragEnd: () {
              widget.onSizeChange(height, width);
            },
          ),
        ),
        // bottom center
        Positioned(
          top: top + height - ballDiameter / 2,
          left: left + width / 2 - ballDiameter / 2,
          child: ManipulatingBall(
            child: BallWidget(diameter: ballDiameter),
            onDrag: (dx, dy) {
              var newHeight = height + dy;
              setState(() {
                height = newHeight > minsize ? newHeight : minsize;
              });
            },
            onDragEnd: () {
              widget.onSizeChange(height, width);
            },
          ),
        ),
        //left center
        Positioned(
          top: top + height / 2 - ballDiameter / 2,
          left: left - ballDiameter / 2,
          child: ManipulatingBall(
            child: BallWidget(diameter: ballDiameter),
            onDrag: (dx, dy) {
              var newWidth = width - dx;
              setState(() {
                width = newWidth > minsize ? newWidth : minsize;
                left = left + dx;
              });
            },
            onDragEnd: () {
              widget.onSizeChange(height, width);
            },
          ),
        ),
      ],
    );
  }
}
