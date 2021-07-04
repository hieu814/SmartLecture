import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';

class CloudStorageInfo {
  String title, type;
  int numOfFiles, percentage;
  Color color;
  IconData icon;

  CloudStorageInfo({
    this.icon,
    this.title,
    this.type,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

List<CloudStorageInfo> demoMyFiles = [
  CloudStorageInfo(
    title: "Video",
    numOfFiles: 0,
    type: VIDEOS,
    icon: FontAwesomeIcons.youtube,
    color: primaryColor,
  ),
  CloudStorageInfo(
    title: "Audio",
    numOfFiles: 0,
    icon: FontAwesomeIcons.fileAudio,
    type: AUDIOS,
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Bài giảng",
    numOfFiles: 0,
    icon: FontAwesomeIcons.bookOpen,
    type: LECTUTES,
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  CloudStorageInfo(
    title: "Tài khoản",
    numOfFiles: 0,
    icon: Icons.supervised_user_circle,
    type: USERS,
    color: Color(0xFF007EE5),
    percentage: 78,
  ),
];
