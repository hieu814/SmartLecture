import 'package:smartlecture/models/Page.dart';

class Section {
  Section({
    this.page,
    this.id,
    this.title,
  });

  List<Page> page;
  int id;
  String title;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        page: List<Page>.from(json["PAGE"].map((x) => Page.fromJson(x))),
        id: int.parse((json["_id"])),
        title: json["_title"],
      );

  Map<String, dynamic> toJson() => {
        "PAGE": List<dynamic>.from(page.map((x) => x.toJson())),
        "_id": id,
        "_title": title,
      };
}
