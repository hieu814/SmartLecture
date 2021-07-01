import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/lecture_model/Item.dart';
import 'package:smartlecture/models/lecture_model/Text.dart' as iText;
import 'package:smartlecture/widgets/dataViewModel/IImage.dart';
import 'package:smartlecture/widgets/dataViewModel/Itext.dart';
import 'package:smartlecture/widgets/manage/FormEditMedia.dart';

bool toBool(dynamic x) {
  if (x == null) return false;
  String a = x;
  bool b = a.toLowerCase() == 'true' ?? false;
  return b;
}

TextAlign getTextAlign(String a) {
  a.toLowerCase();
  if (a == "right") {
    return TextAlign.right;
  } else if (a == "left") {
    return TextAlign.left;
  } else if (a == "center") {
    return TextAlign.center;
  }
  return TextAlign.left;
}

Color hexToColor(String code) {
  return new Color(int.parse(code.replaceAll('#', '0xff')));
}

Widget fromItem(Item item) {
  if (typeName.map[item.name] == Type.ITEXTBLOCK) {
    iText.Text data = item.itemInfo.text;
    return Itext(
      text: data,
    );
  } else if (typeName.map[item.name] == Type.IMAGE) {
    iText.Text data = item.itemInfo.text;
    return Itext(
      text: data,
    );
  }
  return IImage();
}

Future<String> editMedia(BuildContext context, String url, bool isVideo) async {
  return Navigator.push(
    context,
    CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (context) => FormEditMedia(
              isVideo: isVideo,
              url: url,
            )),
  );
}
