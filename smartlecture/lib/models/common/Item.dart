import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Item {
  int id;
  String name;
  String type;
  double x;
  double y;
  double width;
  double height;
  double scaleX;
  double scaleY;
  double rotation;
  Item.argument({
    this.id,
    this.name,
    this.type,
    this.x,
    this.y,
    this.width,
    this.height,
    this.scaleX,
    this.scaleY,
    this.rotation,
  });
  void setPosition(Offset t) {
    this.x = t.dx;
    this.y = t.dy;
  }

  Item() {
    this.id = 0;
    this.name = "";
    this.type = "";
    this.x = 0.0;
    this.y = 0.0;
    this.width = 50;
    this.height = 50;
    this.scaleX = 0.0;
    this.scaleY = 0.0;
    this.rotation = 0.0;
  }
  void setSize(double width, double height) {
    this.width = width;
    this.height = height;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'x': x,
      'y': y,
      'width': width,
      'height': height,
      'scaleX': scaleX,
      'scaleY': scaleY,
      'rotation': rotation,
    };
  }

  Item.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    type = map['type'];
    x = map['x'];
    y = map['y'];
    width = map['width'];
    height = map['height'];
    scaleX = map['scaleX'];
    scaleY = map['scaleY'];
    rotation = map['rotation'];
  }

  String toJson() => json.encode(toMap());

  Item.fromJson(String source) {
    Item.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return 'Item(id: $id, name: $name, type: $type, x: $x, y: $y, width: $width, height: $height, scaleX: $scaleX, scaleY: $scaleY, rotation: $rotation)';
  }
}
