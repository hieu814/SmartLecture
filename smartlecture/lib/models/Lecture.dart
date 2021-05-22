import 'package:smartlecture/models/Section.dart';

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
        title: json["_title"],
        type: json["_type"],
        authorId: json["_authorId"],
        editorId: json["_editorId"],
        createdDate: json["_createdDate"],
        editedDate: json["_editedDate"],
      );

  Map<String, dynamic> toJson() => {
        "SECTION": List<dynamic>.from(section.map((x) => x.toJson())),
        "_title": title,
        "_type": type,
        "_authorId": authorId,
        "_editorId": editorId,
        "_createdDate": createdDate,
        "_editedDate": editedDate,
      };
}
