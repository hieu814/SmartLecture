import 'package:smartlecture/models/ItemElement.dart';
import 'package:smartlecture/models/QuestionClass.dart';

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
        font: json["_font"],
        size: json["_size"],
        color: json["_color"],
        bold: json["_bold"],
        underline: json["_underline"],
        align: json["_align"],
        leading: json["_leading"],
        question: json["_question"] == null ? null : json["_question"],
        crossgameQuestion: json["question"] == null
            ? null
            : QuestionClass.fromJson(json["question"]),
      );

  Map<String, dynamic> toJson() => {
        "item": item == null
            ? null
            : List<dynamic>.from(item.map((x) => x.toJson())),
        "_font": font,
        "_size": size,
        "_color": color,
        "_bold": bold,
        "_underline": underline,
        "_align": align,
        "_leading": leading,
        "_question": question == null ? null : question,
        "question":
            crossgameQuestion == null ? null : crossgameQuestion.toJson(),
      };
}
