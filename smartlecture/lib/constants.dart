import 'package:flutter/material.dart';

const FINISHED_ON_BOARDING = 'finishedOnBoarding';
const COLOR_ACCENT = 0xFFd756ff;
const COLOR_PRIMARY_DARK = 0xFF6900be;
const COLOR_PRIMARY = 0xFF2697FF; //Color(0xFFFF7643)
const FACEBOOK_BUTTON_COLOR = 0xFF415893;
const primaryColor = Color(0xFF2697FF);
const secondaryColor = Colors.greenAccent;
const bgColor = Color(0xFF212332);
Color darkPrimaryColor = Color(0xff6f3d2e);
const defaultPadding = 16.0;

const USER_ROLE_USER = 'user';
const USER_ROLE_ADMIN = 'admin';
const USER_ROLE_TEACHER = 'teacher';
const USERS = 'users';
const LECTUTES = 'lectures';
const LIBRARY = 'library';
const FOLDER = 'folder';
const CONTRIBUTE = 'contribute';
const USER_LECTUTES = 'user_lectures';
const AUDIOS = 'audios';
const IMAGES = 'images';
const VIDEOS = 'videos';
const SIZE_DATA = 'size';
const SIZE_DATA_ID = 'iurjhdusf';
const NO_IMAGE = "assets/images/no_image.png";
const NO_BACKGROUND = "assets/images/transparent.jpg";
String syncSetting = 'isSync';
String notificationsSetting = 'notificationsEnabled';
const double BASE_WIDTH = 800.0; //x
const double BASE_HEIGHT = 600.0; //411
enum DataTypes { LECTURES, AUDIOS, VIDEOS, IMAGES, USERS }
enum Type {
  IMAGE,
  TEXT,
  ITEXTBLOCK,
  IQUIZJOIN,
  IIMAGE,
  IMAINMEDIA,
  IQUIZMULTIPLECHOICE,
  IQUIZTRUEFALSE,
  IQUIZSINGLECHOICE,
  IANHIEN,
  IDIENKHUYET,
  IDROPLIST,
  IKEOTHA,
  ILISTENANDTICK,
  ILISTENANDNUMBER,
  IQUIZJOINIMAGEIMAGE,
  IQUIZJOINTEXTIMAGE,
  IKEOTHAIMAGECONTENT,
  IQUIZSINGLECHOICEWITHIMAGE,
  ICHOOSEANDCOMPLETE,
  ICROSS
}
enum TypeFolder {
  FOLDER_NULL,
  FOLDER_IMAGE,
  FOLDER_CONTRIBUTE,
  FOLDER_VIDEO,
  FOLDER_LECTURE
}
final typeName = EnumValues({
  "image": Type.IMAGE,
  "text": Type.TEXT,
  "iTextBlock": Type.ITEXTBLOCK,
  "iQuizJoin": Type.IQUIZJOIN,
  "iImage": Type.IIMAGE,
  "iMainMedia": Type.IMAINMEDIA,
  "iQuizMultipleChoice": Type.IQUIZMULTIPLECHOICE,
  "iQuizTrueFalse": Type.IQUIZTRUEFALSE,
  "iQuizSingleChoice": Type.IQUIZSINGLECHOICE,
  "iAnHien": Type.IANHIEN,
  "iDienKhuyet": Type.IDIENKHUYET,
  "iDropList": Type.IDROPLIST,
  "iKeoTha": Type.IKEOTHA,
  "iListenAndTick": Type.ILISTENANDTICK,
  "iListenAndNumber": Type.ILISTENANDNUMBER,
  "iQuizJoinImageImage": Type.IQUIZJOINIMAGEIMAGE,
  "iQuizJoinTextImage": Type.IQUIZJOINTEXTIMAGE,
  "iKeoThaImageContent": Type.IKEOTHAIMAGECONTENT,
  "iQuizSingleChoiceWithImage": Type.IQUIZSINGLECHOICEWITHIMAGE,
  "iChooseAndComplete": Type.ICHOOSEANDCOMPLETE,
  "iCross": Type.ICROSS
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

const Map<String, String> label = {
  'email': "Email",
  'firstName': "FirstName",
  'lastName': "LastName",
  'lastOnlineTimestamp': "Last online",
  'phoneNumber': "Phone number",
  'role': "Role",
  '_title': "Title",
  '_authorId': "Author",
  '_editorId': "Editor",
  '_createdDate': "Author",
  '_editedDate': "Edited Date",
  //  '_authorId': "Author",
  //   '_authorId': "Author",
};
