import 'package:smartlecture/models/lecture_model/AnswerInfo.dart';

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
        value: json["Value"],
        selectIndex: json["SelectIndex"],
        mediaType: json["MediaType"],
        mediaUrl: json["MediaUrl"],
      );

  Map<String, dynamic> toJson() => {
        "Answers": answers.toJson(),
        "Value": value,
        "SelectIndex": selectIndex,
        "MediaType": mediaType,
        "MediaUrl": mediaUrl,
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
