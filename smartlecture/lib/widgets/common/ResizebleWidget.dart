import 'package:flutter/material.dart';
import 'package:smartlecture/ui/modules/Scale.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/widgets/common/BallWidget.dart';
import 'package:smartlecture/widgets/common/DragWidget.dart';

const ballDiameter = 20.0;
const minsize = 30.0;

class ResizebleWidget extends StatefulWidget {
  final void Function(double dx, double dy) onPositionChange;
  final void Function(double height, double width) onSizeChange;
  final VoidCallback onDoubleTap;
  final VoidCallback onTap;
  final VoidCallback onHold;
  final bool isSelect;
  final double width;
  final double height;
  final double x;
  final double y;
  final Widget child;
  final ScalePage scale;
  ResizebleWidget(
      {this.child,
      this.onPositionChange,
      this.onSizeChange,
      this.width = 50,
      this.height = 50,
      this.x = 80,
      this.y = 80,
      this.onDoubleTap,
      this.scale,
      this.isSelect,
      this.onTap,
      this.onHold});

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
            child: DragWidget(
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: widget.isSelect ?? false
                            ? Colors.red
                            : Colors.black)),
                child: widget.child,
              ),
              onDrag: (dx, dy) {
                setState(() {
                  top = top + dy * widget.scale.height;
                  left = left + dx * widget.scale.width;
                  //getIt.get<ScalePage>();
                });
              },
              onDoubleTap: widget.onDoubleTap,
              onHold: widget.onHold,
              onTap: widget.onTap,
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
          child: DragWidget(
            child: BallWidget(diameter: ballDiameter),
            onDrag: (dx, dy) {
              var newHeight = height - dy * widget.scale.width;
              setState(() {
                height = newHeight > minsize ? newHeight : minsize;
                top = top + dy * widget.scale.width;
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
          child: DragWidget(
            child: BallWidget(diameter: ballDiameter),
            onDrag: (dx, dy) {
              var newWidth = width + dx * widget.scale.height;
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
          child: DragWidget(
            child: BallWidget(diameter: ballDiameter),
            onDrag: (dx, dy) {
              var newHeight = height + dy * widget.scale.width;
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
          child: DragWidget(
            child: BallWidget(diameter: ballDiameter),
            onDrag: (dx, dy) {
              var newWidth = width - dx * widget.scale.height;
              setState(() {
                width = newWidth > minsize ? newWidth : minsize;
                left = left + dx * widget.scale.height;
              });
            },
            onDragEnd: () {
              widget.onSizeChange(height, width);
            },
          ),
        ),
        // bottom right
        Positioned(
          top: top + height - ballDiameter / 2,
          left: left + width - ballDiameter / 2,
          child: DragWidget(
            child: BallWidget(diameter: ballDiameter),
            onDrag: (dx, dy) {
              var mid =
                  (dx * widget.scale.height + dy * widget.scale.width) / 2;

              var newHeight = height + 2 * mid;
              var newWidth = width + 2 * mid;

              setState(() {
                height = newHeight > 0 ? newHeight : 0;
                width = newWidth > 0 ? newWidth : 0;
                top = top - mid;
                left = left - mid;
              });
            },
          ),
        ),
        // bottom left
        Positioned(
          top: top + height - ballDiameter / 2,
          left: left - ballDiameter / 2,
          child: DragWidget(
            child: BallWidget(diameter: ballDiameter),
            onDrag: (dx, dy) {
              var mid =
                  ((dx * widget.scale.height * -1) + dy * widget.scale.width) /
                      2;

              var newHeight = height + 2 * mid;
              var newWidth = width + 2 * mid;

              setState(() {
                height = newHeight > 0 ? newHeight : 0;
                width = newWidth > 0 ? newWidth : 0;
                top = top - mid;
                left = left - mid;
              });
            },
          ),
        ),
        // top right
        Positioned(
          top: top - ballDiameter / 2,
          left: left + width - ballDiameter / 2,
          child: DragWidget(
            child: BallWidget(diameter: ballDiameter),
            onDrag: (dx, dy) {
              var mid =
                  (dx * widget.scale.height + (dy * widget.scale.width * -1)) /
                      2;

              var newHeight = height + 2 * mid;
              var newWidth = width + 2 * mid;

              setState(() {
                height = newHeight > 0 ? newHeight : 0;
                width = newWidth > 0 ? newWidth : 0;
                top = top - mid;
                left = left - mid;
              });
            },
          ),
        ),
        // top left
        Positioned(
          top: top - ballDiameter / 2,
          left: left - ballDiameter / 2,
          child: DragWidget(
            child: BallWidget(diameter: ballDiameter),
            onDrag: (dx, dy) {
              var mid =
                  (dx * widget.scale.height + dy * widget.scale.width) / 2;
              var newHeight = height - 2 * mid;
              var newWidth = width - 2 * mid;

              setState(() {
                height = newHeight > 0 ? newHeight : 0;
                width = newWidth > 0 ? newWidth : 0;
                top = top + mid;
                left = left + mid;
              });
            },
          ),
        ),
      ],
    );
  }
}
