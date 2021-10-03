class AnswerInfo {
  AnswerInfo({
    this.id,
    this.type,
    this.value,
    this.answer,
    this.answerInfoDetail,
  });

  int id;
  String type;
  String value;
  String answer;
  List<AnswerInfoDetail> answerInfoDetail;

  factory AnswerInfo.fromJson(Map<String, dynamic> json) {
    print("");
    print("------AnswerInfo: " + json.toString());
    return AnswerInfo(
      id: json["Id"] is int ? json["Id"] : int.parse((json["Id"])),
      type: json["Type"] == null ? null : json["Type"],
      value: json["Value"] == null ? null : json["Value"],
      answer: json["Answer"] == null ? null : json["Answer"],
      answerInfoDetail: json["AnswerInfoDetail"] == null
          ? null
          : List<AnswerInfoDetail>.from(json["AnswerInfoDetail"]
              .map((x) => AnswerInfoDetail.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Type": type == null ? null : type,
        "Value": value == null ? null : value,
        "Answer": answer == null ? null : answer,
        "AnswerInfoDetail": answerInfoDetail == null
            ? null
            : List<dynamic>.from(answerInfoDetail.map((x) => x.toJson())),
      };
}

class AnswerInfoDetail {
  AnswerInfoDetail({
    this.id,
    this.imageUrl,
    this.answerCheck,
  });

  int id;
  String imageUrl;
  String answerCheck;

  factory AnswerInfoDetail.fromJson(Map<String, dynamic> json) =>
      AnswerInfoDetail(
        id: json["id"] is int ? json["id"] : int.parse((json["id"])),
        imageUrl: json["ImageUrl"],
        answerCheck: json["AnswerCheck"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ImageUrl": imageUrl,
        "AnswerCheck": answerCheck,
      };
}
