import 'package:flutter/material.dart';

class BallWidget extends StatelessWidget {
  final double diameter;

  //const BallWidget(this.diameter);
  const BallWidget({Key key, this.diameter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
    );
  }
}
