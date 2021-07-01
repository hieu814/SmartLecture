import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';

class CloudStorageInfo {
  final String title, totalStorage;
  final int numOfFiles, percentage;
  final Color color;
  final IconData icon;

  CloudStorageInfo({
    this.icon,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Video",
    numOfFiles: 1328,
    icon: FontAwesomeIcons.youtube,
    totalStorage: "1.9GB",
    color: primaryColor,
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Audio",
    numOfFiles: 1328,
    icon: FontAwesomeIcons.fileAudio,
    totalStorage: "2.9GB",
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Bài giảng",
    numOfFiles: 1328,
    icon: FontAwesomeIcons.bookOpen,
    totalStorage: "1GB",
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  CloudStorageInfo(
    title: "Tài khoản",
    numOfFiles: 5328,
    icon: Icons.supervised_user_circle,
    totalStorage: "7.3GB",
    color: Color(0xFF007EE5),
    percentage: 78,
  ),
];
