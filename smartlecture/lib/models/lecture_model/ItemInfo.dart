import 'package:smartlecture/models/lecture_model/Crossgame.dart';
import 'package:smartlecture/models/lecture_model/Image.dart';
import 'package:smartlecture/models/lecture_model/Info.dart';
import 'package:smartlecture/models/lecture_model/Media.dart';
import 'package:smartlecture/models/lecture_model/Text.dart';

class ItemInfo {
  ItemInfo({
    this.text,
    this.image,
    this.media,
    this.quizs,
    this.rootquest,
    this.quizInfo,
    this.keoThaImageContentInfo,
    this.chooseAndCompleteInfo,
    this.crossgame,
  });

  Text text;
  Image image;
  Media media;
  Crossgame quizs;
  Rootquest rootquest;
  Info quizInfo;
  Info keoThaImageContentInfo;
  Info chooseAndCompleteInfo;
  Crossgame crossgame;

  factory ItemInfo.fromJson(Map<String, dynamic> json) {
    print("----- ItemInfo: " + json.toString());
    return ItemInfo(
      text: json["TEXT"] == null ? null : Text.fromJson(json["TEXT"]),
      image: json["IMAGE"] == null ? null : Image.fromJson(json["IMAGE"]),
      media: json["MEDIA"] == null ? null : Media.fromJson(json["MEDIA"]),
      quizs: json["quizs"] == null ? null : Crossgame.fromJson(json["quizs"]),
      rootquest: json["rootquest"] == null
          ? null
          : Rootquest.fromJson(json["rootquest"]),
      quizInfo:
          json["QuizInfo"] == null ? null : Info.fromJson(json["QuizInfo"]),
      keoThaImageContentInfo: json["KeoThaImageContentInfo"] == null
          ? null
          : Info.fromJson(json["KeoThaImageContentInfo"]),
      chooseAndCompleteInfo: json["ChooseAndCompleteInfo"] == null
          ? null
          : Info.fromJson(json["ChooseAndCompleteInfo"]),
      crossgame: json["crossgame"] == null
          ? null
          : Crossgame.fromJson(json["crossgame"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "TEXT": text == null ? null : text.toJson(),
        "IMAGE": image == null ? null : image.toJson(),
        "MEDIA": media == null ? null : media.toJson(),
        "quizs": quizs == null ? null : quizs.toJson(),
        "rootquest": rootquest == null ? null : rootquest.toJson(),
        "QuizInfo": quizInfo == null ? null : quizInfo.toJson(),
        "KeoThaImageContentInfo": keoThaImageContentInfo == null
            ? null
            : keoThaImageContentInfo.toJson(),
        "ChooseAndCompleteInfo": chooseAndCompleteInfo == null
            ? null
            : chooseAndCompleteInfo.toJson(),
        "crossgame": crossgame == null ? null : crossgame.toJson(),
      };
}

class Rootquest {
  Rootquest({
    this.whichword,
  });

  Whichword whichword;

  factory Rootquest.fromJson(Map<String, dynamic> json) {
    print("-----Rootquest : " + json.toString());
    return Rootquest(
      whichword: Whichword.fromJson(json["WHICHWORD"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "WHICHWORD": whichword.toJson(),
      };
}

class Whichword {
  Whichword({
    this.dragDrop,
    this.title,
    this.image,
    this.dapan,
    this.mediaType,
    this.mediaUrl,
    this.extendDrag,
    this.mediaurl,
  });

  String dragDrop;
  String title;
  String image;
  String dapan;
  String mediaType;
  String mediaUrl;
  List<ExtendDrag> extendDrag;
  String mediaurl;

  factory Whichword.fromJson(Map<String, dynamic> json) {
    print("-----Whichword : " + json.toString());
    return Whichword(
      dragDrop: json["DRAG_DROP"].toString(),
      title: json["Title"],
      image: json["Image"],
      dapan: json["Dapan"],
      mediaType: json["MediaType"] == null ? null : json["MediaType"],
      mediaUrl: json["MediaUrl"] == null ? null : json["MediaUrl"],
      extendDrag: json["EXTEND_DRAG"] == null
          ? null
          : List<ExtendDrag>.from(
              json["EXTEND_DRAG"].map((x) => ExtendDrag.fromJson(x))),
      mediaurl: json["mediaurl"] == null ? null : json["mediaurl"],
    );
  }

  Map<String, dynamic> toJson() => {
        "DRAG_DROP": dragDrop,
        "Title": title,
        "Image": image,
        "Dapan": dapan,
        "MediaType": mediaType == null ? null : mediaType,
        "MediaUrl": mediaUrl == null ? null : mediaUrl,
        "EXTEND_DRAG": extendDrag == null
            ? null
            : List<dynamic>.from(extendDrag.map((x) => x.toJson())),
        "mediaurl": mediaurl == null ? null : mediaurl,
      };
}

class ExtendDrag {
  ExtendDrag({
    this.data,
  });

  String data;

  factory ExtendDrag.fromJson(Map<String, dynamic> json) => ExtendDrag(
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}
