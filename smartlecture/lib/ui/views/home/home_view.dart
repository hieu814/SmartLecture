import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyApp extends StatelessWidget {
  Widget _portraitView() {
    // Return Your Widget View Here Which you want to Load on Portrait Orientation.
    return Container(
        width: 300.00,
        color: Colors.green,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Text(' Portrait View Detected. ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, color: Colors.white)));
  }

  Widget _landscapeView() {
    // // Return Your Widget View Here Which you want to Load on Landscape Orientation.
    return Container(
        width: 300.00,
        color: Colors.pink,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Text(' Landscape View Detected.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, color: Colors.white)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('Detect Device Screen Orientation')),
            body: OrientationBuilder(builder: (context, orientation) {
              return Center(
                  child: orientation == Orientation.portrait
                      ? _portraitView()
                      : _landscapeView());
            })));
  }
}
