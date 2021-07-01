import 'package:smartlecture/models/lecture_model/Question.dart';
import 'package:smartlecture/models/lecture_model/QuestionChooseAndCompleteInfo.dart';
import 'package:smartlecture/models/lecture_model/QuestionKeoThaImageContentInfo.dart';

class Info {
  Info({
    this.questionChooseAndCompleteInfo,
    this.size,
    this.bold,
    this.underline,
    this.align,
    this.leading,
    this.questionKeoThaImageContentInfo,
    this.question,
  });

  QuestionChooseAndCompleteInfo questionChooseAndCompleteInfo;
  String size;
  String bold;
  String underline;
  String align;
  String leading;
  QuestionKeoThaImageContentInfo questionKeoThaImageContentInfo;
  Question question;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        questionChooseAndCompleteInfo:
            json["QuestionChooseAndCompleteInfo"] == null
                ? null
                : QuestionChooseAndCompleteInfo.fromJson(
                    json["QuestionChooseAndCompleteInfo"]),
        size: json["_Size"],
        bold: json["_Bold"],
        underline: json["_Underline"],
        align: json["_Align"],
        leading: json["_Leading"],
        questionKeoThaImageContentInfo:
            json["QuestionKeoThaImageContentInfo"] == null
                ? null
                : QuestionKeoThaImageContentInfo.fromJson(
                    json["QuestionKeoThaImageContentInfo"]),
        question: json["Question"] == null
            ? null
            : Question.fromJson(json["Question"]),
      );

  Map<String, dynamic> toJson() => {
        "QuestionChooseAndCompleteInfo": questionChooseAndCompleteInfo == null
            ? null
            : questionChooseAndCompleteInfo.toJson(),
        "_Size": size,
        "_Bold": bold,
        "_Underline": underline,
        "_Align": align,
        "_Leading": leading,
        "QuestionKeoThaImageContentInfo": questionKeoThaImageContentInfo == null
            ? null
            : questionKeoThaImageContentInfo.toJson(),
        "Question": question == null ? null : question.toJson(),
      };
}
