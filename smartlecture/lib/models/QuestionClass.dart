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
        value: json["_value"],
        selectedindex:
            json["_selectedindex"] == null ? null : json["_selectedindex"],
        mediatype: json["_mediatype"],
        mediaurl: json["_mediaurl"],
      );

  Map<String, dynamic> toJson() => {
        "answer": List<dynamic>.from(answer.map((x) => x.toJson())),
        "_value": value,
        "_selectedindex": selectedindex == null ? null : selectedindex,
        "_mediatype": mediatype,
        "_mediaurl": mediaurl,
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
  Type type;
  String value;
  String checked;
  Left left;
  Left right;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["_id"],
        type: json["_type"] == null ? null : json["_type"],
        value: json["_value"] == null ? null : json["_value"],
        checked: json["_checked"] == null ? null : json["_checked"],
        left: json["left"] == null ? null : Left.fromJson(json["left"]),
        right: json["right"] == null ? null : Left.fromJson(json["right"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "_type": type == null ? null : type,
        "_value": value == null ? null : value,
        "_checked": checked == null ? null : checked,
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
  Type type;
  String value;
  String index;

  factory Left.fromJson(Map<String, dynamic> json) => Left(
        id: json["_id"],
        type: json["_type"],
        value: json["_value"],
        index: json["_index"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "_type": type,
        "_value": value,
        "_index": index,
      };
}
