import 'package:smartlecture/models/lecture_model/ExtendDragEInfo.dart';

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
        value: json["Value"],
        selectIndex: json["SelectIndex"],
        mediaType: json["MediaType"],
        mediaUrl: json["MediaUrl"],
      );

  Map<String, dynamic> toJson() => {
        "AnswerChooseAndCompleteInfo": answerChooseAndCompleteInfo.toJson(),
        "ExtendDragChooseAndCompleteInfo": List<dynamic>.from(
            extendDragChooseAndCompleteInfo.map((x) => x.toJson())),
        "Value": value,
        "SelectIndex": selectIndex,
        "MediaType": mediaType,
        "MediaUrl": mediaUrl,
      };
}

class AnswerChooseAndCompleteInfo {
  AnswerChooseAndCompleteInfo({
    this.answer,
  });

  String answer;

  factory AnswerChooseAndCompleteInfo.fromJson(Map<String, dynamic> json) =>
      AnswerChooseAndCompleteInfo(
        answer: json["Answer"],
      );

  Map<String, dynamic> toJson() => {
        "Answer": answer,
      };
}
