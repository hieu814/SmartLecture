class QuestionClass {
  QuestionClass({
    this.answer,
    this.value,
    this.selectedindex,
    this.mediatype,
    this.mediaurl,
  });

  List<Answer> answer;
  String value;
  String selectedindex;
  String mediatype;
  String mediaurl;

  factory QuestionClass.fromJson(Map<String, dynamic> json) => QuestionClass(
        answer:
            List<Answer>.from(json["answer"].map((x) => Answer.fromJson(x))),
        value: json["value"],
        selectedindex:
            json["selectedindex"] == null ? null : json["selectedindex"],
        mediatype: json["mediatype"],
        mediaurl: json["mediaurl"],
      );

  Map<String, dynamic> toJson() => {
        "answer": List<dynamic>.from(answer.map((x) => x.toJson())),
        "value": value,
        "selectedindex": selectedindex == null ? null : selectedindex,
        "mediatype": mediatype,
        "mediaurl": mediaurl,
      };
}

class Answer {
  Answer({
    this.id,
    this.type,
    this.value,
    this.checked,
    this.left,
    this.right,
  });

  String id;
  String type;
  String value;
  String checked;
  Left left;
  Left right;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"] ?? "0",
        type: json["type"],
        value: json["value"] == null ? null : json["value"],
        checked: json["checked"] == null ? null : json["checked"],
        left: json["left"] == null ? null : Left.fromJson(json["left"]),
        right: json["right"] == null ? null : Left.fromJson(json["right"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type == null ? null : type,
        "value": value == null ? null : value,
        "checked": checked == null ? null : checked,
        "left": left == null ? null : left.toJson(),
        "right": right == null ? null : right.toJson(),
      };
}

class Left {
  Left({
    this.id,
    this.type,
    this.value,
    this.index,
  });

  String id;
  String type;
  String value;
  String index;

  factory Left.fromJson(Map<String, dynamic> json) => Left(
        id: json["id"] ?? "0",
        type: json["type"],
        value: json["value"],
        index: json["index"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "value": value,
        "index": index,
      };
}
