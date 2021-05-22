import 'package:smartlecture/models/AnswerInfo.dart';

class Question {
  Question({
    this.answers,
    this.value,
    this.selectIndex,
    this.mediaType,
    this.mediaUrl,
  });

  QuestionAnswers answers;
  String value;
  String selectIndex;
  String mediaType;
  String mediaUrl;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        answers: QuestionAnswers.fromJson(json["Answers"]),
        value: json["_Value"],
        selectIndex: json["_SelectIndex"],
        mediaType: json["_MediaType"],
        mediaUrl: json["_MediaUrl"],
      );

  Map<String, dynamic> toJson() => {
        "Answers": answers.toJson(),
        "_Value": value,
        "_SelectIndex": selectIndex,
        "_MediaType": mediaType,
        "_MediaUrl": mediaUrl,
      };
}

class QuestionAnswers {
  QuestionAnswers({
    this.answerInfo,
  });

  List<AnswerInfo> answerInfo;

  factory QuestionAnswers.fromJson(Map<String, dynamic> json) =>
      QuestionAnswers(
        answerInfo: List<AnswerInfo>.from(
            json["AnswerInfo"].map((x) => AnswerInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "AnswerInfo": List<dynamic>.from(answerInfo.map((x) => x.toJson())),
      };
}
