import 'package:smartlecture/models/lecture_model/Section.dart';

class Lecture {
  Lecture({
    this.section,
    this.title,
    this.type,
    this.authorId,
    this.editorId,
    this.createdDate,
    this.editedDate,
  });

  List<Section> section;
  String title;
  String type;
  String authorId;
  String editorId;
  String createdDate;
  String editedDate;

  factory Lecture.fromJson(Map<String, dynamic> json) => Lecture(
        section:
            List<Section>.from(json["SECTION"].map((x) => Section.fromJson(x))),
        title: json["title"],
        type: json["type"],
        authorId: json["authorId"],
        editorId: json["editorId"],
        createdDate: json["createdDate"],
        editedDate: json["editedDate"],
      );

  Map<String, dynamic> toJson() => {
        "SECTION": List<dynamic>.from(section.map((x) => x.toJson())),
        "title": title,
        "type": type,
        "authorId": authorId,
        "editorId": editorId,
        "createdDate": createdDate,
        "editedDate": editedDate,
      };
}
