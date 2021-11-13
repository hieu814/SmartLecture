import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/lecture_model/Item.dart';
import 'package:smartlecture/models/lecture_model/Text.dart' as iText;
import 'package:smartlecture/models/lecture_model/Image.dart' as iImage;
import 'package:smartlecture/widgets/components/YoutubePlayer.dart';
import 'package:smartlecture/widgets/dataViewModel/IImage.dart';
import 'package:smartlecture/widgets/dataViewModel/Itext.dart';
import 'package:smartlecture/widgets/dataViewModel/YoutubeComponent.dart';
import 'package:smartlecture/widgets/manage/FormEditMedia.dart';
import 'package:provider/provider.dart';
import 'package:smartlecture/widgets/manage/MyForm.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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

String getYoutubeId(String url) {
  url = url.replaceAll("https://www.youtube.com/watch?v=", "");
  url = url.replaceAll("https://m.youtube.com/watch?v=", "");
  return url;
}

Widget fromItem(Item item) {
  if (typeName.map[item.name] == Type.ITEXTBLOCK) {
    iText.Text data = item.itemInfo.text;
    return Itext(
      text: data,
    );
  } else if (typeName.map[item.name] == Type.IIMAGE) {
    iImage.Image data = item.itemInfo.image;
    return IImage(
      image: data,
    );
  } else if (typeName.map[item.name] == Type.IMAINMEDIA) {
    return YoutubeComponent(
        //item: item,
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
              returnData: (_) => {},
            )),
  );
}

void showInSnackBar(BuildContext context, String value) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(value),
    duration: const Duration(seconds: 1),
  ));
}

Future<void> editDatabase(
    BuildContext context, DocumentSnapshot doc, String type) async {
  return Navigator.push(
    context,
    CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (context) => MyForm(
              doc: doc,
              type: type,
            )),
  );
}
