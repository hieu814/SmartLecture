import 'package:flutter/material.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/Item.dart';
import 'package:smartlecture/models/Text.dart' as iText;
import 'package:smartlecture/widgets/dataViewModel/Itext.dart';

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
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

Widget fromItem(Item item) {
  if (typeName.map[item.name] == Type.ITEXTBLOCK) {
    iText.Text data = item.itemInfo.text;
    return Itext(
      text: data,
    );
  }
  return Text("Double tap to change text");
}
