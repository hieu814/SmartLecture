import 'package:smartlecture/models/Appear.dart';
import 'package:smartlecture/models/Audio.dart';
import 'package:smartlecture/models/ItemInfo.dart';

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
  String id;
  String name;
  String type;
  String x;
  String y;
  String width;
  String height;
  String scaleX;
  String scaleY;
  String rotation;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemInfo: ItemInfo.fromJson(json["ITEM_INFO"]),
        appear: Appear.fromJson(json["APPEAR"]),
        speech: json["SPEECH"] == null ? null : Speech.fromJson(json["SPEECH"]),
        audio: json["AUDIO"] == null ? null : Audio.fromJson(json["AUDIO"]),
        id: json["_id"],
        name: json["_name"],
        type: json["_type"],
        x: json["_x"],
        y: json["_y"],
        width: json["_width"],
        height: json["_height"],
        scaleX: json["_scaleX"],
        scaleY: json["_scaleY"],
        rotation: json["_rotation"],
      );

  Map<String, dynamic> toJson() => {
        "ITEM_INFO": itemInfo.toJson(),
        "APPEAR": appear.toJson(),
        "SPEECH": speech == null ? null : speech.toJson(),
        "AUDIO": audio == null ? null : audio.toJson(),
        "_id": id,
        "_name": name,
        "_type": type,
        "_x": x,
        "_y": y,
        "_width": width,
        "_height": height,
        "_scaleX": scaleX,
        "_scaleY": scaleY,
        "_rotation": rotation,
      };
}

class Speech {
  Speech({
    this.value,
    this.isMale,
  });

  String value;
  String isMale;

  factory Speech.fromJson(Map<String, dynamic> json) => Speech(
        value: json["_Value"],
        isMale: json["_IsMale"],
      );

  Map<String, dynamic> toJson() => {
        "_Value": value,
        "_IsMale": isMale,
      };
}
