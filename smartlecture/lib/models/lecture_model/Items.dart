import 'package:smartlecture/models/lecture_model/Item.dart';

class Items {
  Items({
    this.item,
  });

  List<Item> item;

  factory Items.fromJson(Map<String, dynamic> json) {
    print("----- items: " + json.toString());
    List<Item> data = [];
    print("-----Section: " + json.toString());
    String key = "ITEM";
    if (json[key].runtimeType.toString() == "List<dynamic>") {
      data = List<Item>.from(json[key].map((x) => Item.fromJson(x)));
    } else {
      data.add(Item.fromJson(json[key]));
    }
    return Items(
      item: data,
    );
  }

  Map<String, dynamic> toJson() => {
        "ITEM": List<dynamic>.from(item.map((x) => x.toJson())),
      };
}
