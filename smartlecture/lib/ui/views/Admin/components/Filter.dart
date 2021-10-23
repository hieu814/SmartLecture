import 'package:flutter/material.dart';

import '../../../../constants.dart';

List<String> _list = [
  "Tất cả",
  "tieuhoc/tienganh/lop1",
  "tieuhoc/tienganh/lop2",
  "tieuhoc/tienganh/lop3",
  "tieuhoc/tienganh/lop4"
];

class FilterWidget extends StatefulWidget {
  final String title;
  final String data;
  final double width;
  final double height;
  final Function(String) returnData;
  const FilterWidget(
      {Key key,
      this.data,
      this.title,
      this.returnData,
      this.width,
      this.height})
      : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  TextEditingController imgUrlController = new TextEditingController();
  int index = 0;
  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      imgUrlController.text = widget.data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 50,
      width: widget.width ?? 50,
      child: DropdownButton<dynamic>(
          iconSize: 30,
          isExpanded: true,
          value: index,
          onChanged: (val) {
            setState(() {
              index = val;
              widget.returnData(index == 0 ? "" : _list[index]);
            });
          },
          items: etDropDownMenuItems()),
    );
  }

  etDropDownMenuItems() {
    print("get lecture ");

    List<DropdownMenuItem> _items = [];
    List<String> list = _list;
    _list.asMap().forEach((index, item) {
      print(item);
      _items.add(
        DropdownMenuItem<int>(
          value: index,
          child: SizedBox(
            width: 300,
            child: Text(
              item,
              style: TextStyle(
                color: Color(COLOR_PRIMARY),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    });
    return _items;
  }
}
