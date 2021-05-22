import 'package:flutter/material.dart';

class ListSection extends StatefulWidget {
  final bool isHorizontal;

  const ListSection({Key key, this.isHorizontal}) : super(key: key);
  @override
  _ListSectionState createState() => _ListSectionState();
}

class _ListSectionState extends State<ListSection> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.green,
                  margin: EdgeInsets.all(5))),
          Expanded(
            flex: 7,
            child: Container(
              height: 100,
              width: 100,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection:
                    widget.isHorizontal ? Axis.horizontal : Axis.vertical,
                itemBuilder: (context, index) {
                  return Container(
                      width: 100,
                      height: 100,
                      color: Colors.red,
                      margin: EdgeInsets.all(5));
                },
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Card(
                child: Container(
                    width: 100,
                    height: 100,
                    child: Center(
                      child: IconButton(
                          iconSize: 15, onPressed: null, icon: Icon(Icons.add)),
                    ),
                    margin: EdgeInsets.all(5)),
              ))
        ],
      ),
    );
  }
}
