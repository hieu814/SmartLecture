import 'dart:convert';

class Contribute {
  String contributorId;
  String message;
  String lectureId;
  String lectureName;
  String path;
  bool status;
  String date;
  Contribute(
      {this.contributorId = "",
      this.message,
      this.lectureId,
      this.status = false,
      this.date,
      this.path,
      this.lectureName = ""});

  Map<String, dynamic> toJson() {
    return {
      'contributorId': contributorId,
      'message': message,
      'lectureId': lectureId,
      'status': status,
      'date': date,
      'lectureName': lectureName,
      'path': path
    };
  }

  factory Contribute.fromJson(Map<String, dynamic> map) {
    return Contribute(
      contributorId: map['contributorId'],
      message: map['message'],
      lectureId: map['lectureId'],
      status: map['status'],
      date: map['date'],
      lectureName: map['lectureName'],
      path: map['path'],
    );
  }
}
