import 'package:smartlecture/models/lecture_model/Items.dart';

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

  factory Page.fromJson(Map<String, dynamic> json) {
    return Page(
      items: Items.fromJson(json["ITEMS"]),
      id: json["id"] is int ? json["id"] : int.parse((json["id"])),
      title: json["title"],
      backgroundImage: json["backgroundImage"],
      backgroundColor: json["backgroundColor"],
      backgroundAlpha: json["backgroundAlpha"],
    );
  }

  Map<String, dynamic> toJson() => {
        "ITEMS": items.toJson(),
        "id": id,
        "title": title,
        "backgroundImage": backgroundImage,
        "backgroundColor": backgroundColor,
        "backgroundAlpha": backgroundAlpha,
      };
}
