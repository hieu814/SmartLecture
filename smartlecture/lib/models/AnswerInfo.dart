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

  factory AnswerInfo.fromJson(Map<String, dynamic> json) => AnswerInfo(
        id: json["_id"] != null ? int.parse((json["_id"])) : 1,
        type: json["_Type"] == null ? null : json["_Type"],
        value: json["_Value"] == null ? null : json["_Value"],
        answer: json["_Answer"] == null ? null : json["_Answer"],
        answerInfoDetail: json["AnswerInfoDetail"] == null
            ? null
            : List<AnswerInfoDetail>.from(json["AnswerInfoDetail"]
                .map((x) => AnswerInfoDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_Id": id,
        "_Type": type == null ? null : type,
        "_Value": value == null ? null : value,
        "_Answer": answer == null ? null : answer,
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
        id: json["_id"] != null ? int.parse((json["_id"])) : 1,
        imageUrl: json["_ImageUrl"],
        answerCheck: json["_AnswerCheck"],
      );

  Map<String, dynamic> toJson() => {
        "_Id": id,
        "_ImageUrl": imageUrl,
        "_AnswerCheck": answerCheck,
      };
}
