import 'package:smartlecture/models/lecture_model/ItemElement.dart';
import 'package:smartlecture/models/lecture_model/QuestionClass.dart';

class Crossgame {
  Crossgame({
    this.item,
    this.font,
    this.size,
    this.color,
    this.bold,
    this.underline,
    this.align,
    this.leading,
    this.question,
    this.crossgameQuestion,
  });

  List<ItemElement> item;
  String font;
  String size;
  String color;
  String bold;
  String underline;
  String align;
  String leading;
  String question;
  QuestionClass crossgameQuestion;

  factory Crossgame.fromJson(Map<String, dynamic> json) => Crossgame(
        item: json["item"] == null
            ? null
            : List<ItemElement>.from(
                json["item"].map((x) => ItemElement.fromJson(x))),
        font: json["font"],
        size: json["size"],
        color: json["color"],
        bold: json["bold"],
        underline: json["underline"],
        align: json["align"],
        leading: json["leading"],
        question: json["question"] == null ? null : json["question"],
        crossgameQuestion: json["question"] == null
            ? null
            : QuestionClass.fromJson(json["question"]),
      );

  Map<String, dynamic> toJson() => {
        "item": item == null
            ? null
            : List<dynamic>.from(item.map((x) => x.toJson())),
        "font": font,
        "size": size,
        "color": color,
        "bold": bold,
        "underline": underline,
        "align": align,
        "leading": leading,
        "question": question == null ? null : question,
        "question":
            crossgameQuestion == null ? null : crossgameQuestion.toJson(),
      };
}
