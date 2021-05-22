import 'package:smartlecture/models/Crossgame.dart';
import 'package:smartlecture/models/Image.dart';
import 'package:smartlecture/models/Info.dart';
import 'package:smartlecture/models/Media.dart';
import 'package:smartlecture/models/Text.dart';

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

  factory ItemInfo.fromJson(Map<String, dynamic> json) => ItemInfo(
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

  factory Rootquest.fromJson(Map<String, dynamic> json) => Rootquest(
        whichword: Whichword.fromJson(json["WHICHWORD"]),
      );

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

  factory Whichword.fromJson(Map<String, dynamic> json) => Whichword(
        dragDrop: json["DRAG_DROP"],
        title: json["_Title"],
        image: json["_Image"],
        dapan: json["_Dapan"],
        mediaType: json["_MediaType"] == null ? null : json["_MediaType"],
        mediaUrl: json["_MediaUrl"] == null ? null : json["_MediaUrl"],
        extendDrag: json["EXTEND_DRAG"] == null
            ? null
            : List<ExtendDrag>.from(
                json["EXTEND_DRAG"].map((x) => ExtendDrag.fromJson(x))),
        mediaurl: json["_mediaurl"] == null ? null : json["_mediaurl"],
      );

  Map<String, dynamic> toJson() => {
        "DRAG_DROP": dragDrop,
        "_Title": title,
        "_Image": image,
        "_Dapan": dapan,
        "_MediaType": mediaType == null ? null : mediaType,
        "_MediaUrl": mediaUrl == null ? null : mediaUrl,
        "EXTEND_DRAG": extendDrag == null
            ? null
            : List<dynamic>.from(extendDrag.map((x) => x.toJson())),
        "_mediaurl": mediaurl == null ? null : mediaurl,
      };
}

class ExtendDrag {
  ExtendDrag({
    this.data,
  });

  String data;

  factory ExtendDrag.fromJson(Map<String, dynamic> json) => ExtendDrag(
        data: json["_data"],
      );

  Map<String, dynamic> toJson() => {
        "_data": data,
      };
}
