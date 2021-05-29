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

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemInfo: ItemInfo.fromJson(json["ITEM_INFO"]),
        appear: Appear.fromJson(json["APPEAR"]),
        speech: json["SPEECH"] == null ? null : Speech.fromJson(json["SPEECH"]),
        audio: json["AUDIO"] == null ? null : Audio.fromJson(json["AUDIO"]),
        id: int.parse((json["_id"])),
        name: json["_name"],
        type: json["_type"],
        x: double.parse((json["_x"])),
        y: double.parse((json["_y"])),
        width: double.parse((json["_width"])),
        height: double.parse((json["_height"])),
        scaleX: double.parse((json["_scaleX"])),
        scaleY: double.parse((json["_scaleY"])),
        rotation: double.parse((json["_rotation"])),
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
