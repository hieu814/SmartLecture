import 'package:smartlecture/models/lecture_model/AnswerInfo.dart';
import 'package:smartlecture/models/lecture_model/ExtendDragEInfo.dart';

class QuestionKeoThaImageContentInfo {
  QuestionKeoThaImageContentInfo({
    this.answers,
    this.extendDragKeoThaImageInfo,
    this.value,
    this.selectIndex,
    this.mediaType,
    this.mediaUrl,
  });

  QuestionKeoThaImageContentInfoAnswers answers;
  List<ExtendDragEInfo> extendDragKeoThaImageInfo;
  String value;
  String selectIndex;
  String mediaType;
  String mediaUrl;

  factory QuestionKeoThaImageContentInfo.fromJson(Map<String, dynamic> json) {
    print("------QuestionKeoThaImageContentInfo: " + json.toString());
    return QuestionKeoThaImageContentInfo(
      answers: QuestionKeoThaImageContentInfoAnswers.fromJson(json["Answers"]),
      extendDragKeoThaImageInfo: List<ExtendDragEInfo>.from(
          json["ExtendDragKeoThaImageInfo"]
              .map((x) => ExtendDragEInfo.fromJson(x))),
      value: json["Value"],
      selectIndex: json["SelectIndex"],
      mediaType: json["MediaType"],
      mediaUrl: json["MediaUrl"],
    );
  }

  Map<String, dynamic> toJson() => {
        "Answers": answers.toJson(),
        "ExtendDragKeoThaImageInfo": List<dynamic>.from(
            extendDragKeoThaImageInfo.map((x) => x.toJson())),
        "Value": value,
        "SelectIndex": selectIndex,
        "MediaType": mediaType,
        "MediaUrl": mediaUrl,
      };
}

class QuestionKeoThaImageContentInfoAnswers {
  QuestionKeoThaImageContentInfoAnswers({
    this.answerKeoThaImageContentInfo,
  });

  List<AnswerInfo> answerKeoThaImageContentInfo;

  factory QuestionKeoThaImageContentInfoAnswers.fromJson(
      Map<String, dynamic> json) {
    print("");
    print("------QuestionKeoThaImageContentInfoAnswers: " + json.toString());
    return QuestionKeoThaImageContentInfoAnswers(
      answerKeoThaImageContentInfo: List<AnswerInfo>.from(
          json["AnswerKeoThaImageContentInfo"]
              .map((x) => AnswerInfo.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "AnswerKeoThaImageContentInfo": List<dynamic>.from(
            answerKeoThaImageContentInfo.map((x) => x.toJson())),
      };
}
