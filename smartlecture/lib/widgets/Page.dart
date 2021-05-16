import 'package:flutter/material.dart';

class Page extends StatefulWidget {
  final Map<int, String> data;
  const Page({Key key, this.data}) : super(key: key);
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: List.generate(widget.data.length, (index) => null),
    ));
  }
}
