import 'package:smartlecture/models/lecture_model/Section.dart';

class Lecture {
  Lecture({
    this.id,
    this.section,
    this.title,
    this.type,
    this.authorId,
    this.editorId,
    this.createdDate,
    this.editedDate,
  });

  List<Section> section;
  String id = "";
  String title = "";
  String type = "";
  String authorId = "";
  String editorId = "";
  String createdDate = "";
  String editedDate = "";

  factory Lecture.fromJson(Map<String, dynamic> json) {
    Lecture a;
    print(json["SECTION"][0]);
    try {
      a = Lecture(
        id: json["id"] ?? "",
        section:
            List<Section>.from(json["SECTION"].map((x) => Section.fromJson(x))),
        title: json["title"],
        type: json["type"],
        authorId: json["authorId"],
        editorId: json["editorId"],
        createdDate: json["createdDate"],
        editedDate: json["editedDate"],
      );
    } on Exception catch (e) {
      a = Lecture();
    }
    return a;
  }
  factory Lecture.fromJson2(Map<String, dynamic> json) {
    Lecture a;
    print("--------- fromjson 2");
    print(json["SECTION"][0]);
    List<Section> sa = [Section.fromJson(json["SECTION"][0])];
    try {
      a = Lecture(
        id: json["id"] ?? "",
        section: sa,
        title: json["title"],
        type: json["type"],
        authorId: json["authorId"],
        editorId: json["editorId"],
        createdDate: json["createdDate"],
        editedDate: json["editedDate"],
      );
    } on Exception catch (e) {
      a = Lecture();
    }
    return a;
  }
  Map<String, dynamic> toJson() => {
        "SECTION": List<dynamic>.from(section.map((x) => x.toJson())),
        "title": title,
        "type": type,
        "authorId": authorId,
        "editorId": editorId,
        "createdDate": createdDate,
        "editedDate": editedDate,
        "id": id
      };
}
