import 'dart:convert';

import 'package:smartlecture/models/common/Item.dart';

class ItemImage extends Item {
  String url;
  ItemImage() : super() {
    this.url = "url";
  }
  ItemImage.argument(
      {this.url = "",
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
    p['url'] = url;
    return p;
  }

  ItemImage.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    url = map['url'];
  }

  String toJson() => json.encode(toMap());

  factory ItemImage.fromJson(String source) =>
      ItemImage.fromMap(json.decode(source));
}
