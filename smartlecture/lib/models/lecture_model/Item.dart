import 'package:smartlecture/models/lecture_model/Appear.dart';
import 'package:smartlecture/models/lecture_model/Audio.dart';
import 'package:smartlecture/models/lecture_model/ItemInfo.dart';

class Item {
  Item({
    this.itemInfo,
    this.appear,
    this.speech,
    this.audio,
    this.id,
    this.name,
    this.type,
    this.x,
    this.y,
    this.width,
    this.height,
    this.scaleX,
    this.scaleY,
    this.rotation,
  });

  ItemInfo itemInfo;
  Appear appear;
  Speech speech;
  Audio audio;
  int id;
  String name;
  String type;
  double x;
  double y;
  double width;
  double height;
  double scaleX;
  double scaleY;
  double rotation;

  factory Item.fromJson(Map<String, dynamic> json) {
    print("-----item: " + json.toString());
    return Item(
      itemInfo: ItemInfo.fromJson(json["ITEM_INFO"]),
      appear: Appear.fromJson(json["APPEAR"]),
      speech: json["SPEECH"] == null ? null : Speech.fromJson(json["SPEECH"]),
      audio: json["AUDIO"] == null ? null : Audio.fromJson(json["AUDIO"]),
      id: json["id"] is int ? json["id"] : int.parse((json["id"])),
      name: json["name"],
      type: json["type"],
      x: json["x"] is double ? json["x"] : double.parse((json["x"])),
      y: json["y"] is double ? json["y"] : double.parse((json["y"])),
      width: json["width"] is double
          ? json["width"]
          : double.parse((json["width"])),
      height: json["height"] is double
          ? json["height"]
          : double.parse((json["height"])),
      scaleX: json["scaleX"] is double
          ? json["scaleX"]
          : double.parse((json["scaleX"])),
      scaleY: json["scaleY"] is double
          ? json["scaleY"]
          : double.parse((json["scaleY"])),
      rotation: json["rotation"] is double
          ? json["rotation"]
          : double.parse((json["rotation"])),
    );
  }

  Map<String, dynamic> toJson() => {
        "ITEM_INFO": itemInfo.toJson(),
        "APPEAR": appear.toJson(),
        "SPEECH": speech == null ? null : speech.toJson(),
        "AUDIO": audio == null ? null : audio.toJson(),
        "id": id,
        "name": name,
        "type": type,
        "x": x,
        "y": y,
        "width": width,
        "height": height,
        "scaleX": scaleX,
        "scaleY": scaleY,
        "rotation": rotation,
      };
}

class Speech {
  Speech({
    this.value,
    this.isMale,
  });

  String value = "";
  String isMale = "false";

  factory Speech.fromJson(Map<String, dynamic> json) {
    return json == null
        ? Speech()
        : Speech(
            value: json["Value"],
            isMale: json["IsMale"],
          );
  }

  Map<String, dynamic> toJson() => {
        "Value": value,
        "IsMale": isMale,
      };
}
