import 'package:smartlecture/models/Items.dart';

class Page {
  Page({
    this.items,
    this.id,
    this.title,
    this.backgroundImage,
    this.backgroundColor,
    this.backgroundAlpha,
  });

  Items items;
  int id;
  String title;
  String backgroundImage;
  String backgroundColor;
  String backgroundAlpha;

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        items: Items.fromJson(json["ITEMS"]),
        id: int.parse((json["_id"])),
        title: json["_title"],
        backgroundImage: json["_backgroundImage"],
        backgroundColor: json["_backgroundColor"],
        backgroundAlpha: json["_backgroundAlpha"],
      );

  Map<String, dynamic> toJson() => {
        "ITEMS": items.toJson(),
        "_id": id,
        "_title": title,
        "_backgroundImage": backgroundImage,
        "_backgroundColor": backgroundColor,
        "_backgroundAlpha": backgroundAlpha,
      };
}
