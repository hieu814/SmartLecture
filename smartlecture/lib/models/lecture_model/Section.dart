import 'package:smartlecture/models/lecture_model/Page.dart';

class Section {
  Section({
    this.page,
    this.id,
    this.title,
  });

  List<Page> page;
  int id;
  String title;

  factory Section.fromJson(Map<String, dynamic> json) {
    List<Page> data = [];

    print("-----Section: " + json.toString());
    String key = "PAGE";
    if (json[key].runtimeType.toString() == "List<dynamic>") {
      data = List<Page>.from(json[key].map((x) => Page.fromJson(x)));
    } else {
      data.add(Page.fromJson(json[key]));
    }

    return Section(
      page: data,
      id: json["id"] is int ? json["id"] : int.parse((json["id"])),
      title: json["title"],
    );
  }

  Map<String, dynamic> toJson() => {
        "PAGE": List<dynamic>.from(page.map((x) => x.toJson())),
        "id": id,
        "title": title,
      };
}
