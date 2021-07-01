import 'package:smartlecture/models/lecture_model/Item.dart';

class Items {
  Items({
    this.item,
  });

  List<Item> item;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        item: List<Item>.from(json["ITEM"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ITEM": List<dynamic>.from(item.map((x) => x.toJson())),
      };
}
