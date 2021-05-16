import 'dart:convert';

import 'package:smartlecture/models/common/Item.dart';

class ItemText extends Item {
  String text = "";
  ItemText() : super() {
    this.text = "";
  }
  ItemText.argument(
      {this.text,
      id,
      String name = "",
      String type = "",
      double x = 0,
      double y = 0,
      double width = 0,
      double height = 0,
      double scaleX = 0,
      double scaleY = 0,
      double rotation = 0})
      : super.argument(
            id: id,
            name: name,
            x: x,
            y: y,
            width: width,
            height: height,
            scaleX: scaleX,
            scaleY: scaleY,
            rotation: rotation);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> p = super.toMap();
    p['text'] = text;
    return p;
  }

  ItemText.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    text = map['text'];
  }

  String toJson() => json.encode(toMap());

  factory ItemText.fromJson(String source) =>
      ItemText.fromMap(json.decode(source));
}
