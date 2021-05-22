import 'package:smartlecture/models/ExtendDragEInfo.dart';

class QuestionChooseAndCompleteInfo {
  QuestionChooseAndCompleteInfo({
    this.answerChooseAndCompleteInfo,
    this.extendDragChooseAndCompleteInfo,
    this.value,
    this.selectIndex,
    this.mediaType,
    this.mediaUrl,
  });

  AnswerChooseAndCompleteInfo answerChooseAndCompleteInfo;
  List<ExtendDragEInfo> extendDragChooseAndCompleteInfo;
  String value;
  String selectIndex;
  String mediaType;
  String mediaUrl;

  factory QuestionChooseAndCompleteInfo.fromJson(Map<String, dynamic> json) =>
      QuestionChooseAndCompleteInfo(
        answerChooseAndCompleteInfo: AnswerChooseAndCompleteInfo.fromJson(
            json["AnswerChooseAndCompleteInfo"]),
        extendDragChooseAndCompleteInfo: List<ExtendDragEInfo>.from(
            json["ExtendDragChooseAndCompleteInfo"]
                .map((x) => ExtendDragEInfo.fromJson(x))),
        value: json["_Value"],
        selectIndex: json["_SelectIndex"],
        mediaType: json["_MediaType"],
        mediaUrl: json["_MediaUrl"],
      );

  Map<String, dynamic> toJson() => {
        "AnswerChooseAndCompleteInfo": answerChooseAndCompleteInfo.toJson(),
        "ExtendDragChooseAndCompleteInfo": List<dynamic>.from(
            extendDragChooseAndCompleteInfo.map((x) => x.toJson())),
        "_Value": value,
        "_SelectIndex": selectIndex,
        "_MediaType": mediaType,
        "_MediaUrl": mediaUrl,
      };
}

class AnswerChooseAndCompleteInfo {
  AnswerChooseAndCompleteInfo({
    this.answer,
  });

  String answer;

  factory AnswerChooseAndCompleteInfo.fromJson(Map<String, dynamic> json) =>
      AnswerChooseAndCompleteInfo(
        answer: json["_Answer"],
      );

  Map<String, dynamic> toJson() => {
        "_Answer": answer,
      };
}
