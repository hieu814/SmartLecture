import 'dart:convert';

class SizeData {
  int lectureSize;
  int usersSize;
  int contributeSize;
  int audiosSize;
  int imagesSize;
  SizeData({
    this.lectureSize = 0,
    this.usersSize = 0,
    this.contributeSize = 0,
    this.audiosSize = 0,
    this.imagesSize = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'lectureSize': lectureSize,
      'usersSize': usersSize,
      'contributeSize': contributeSize,
      'audiosSize': audiosSize,
      'imagesSize': imagesSize,
    };
  }

  factory SizeData.fromMap(Map<String, dynamic> map) {
    return SizeData(
      lectureSize: map['lectureSize'],
      usersSize: map['usersSize'],
      contributeSize: map['contributeSize'],
      audiosSize: map['audiosSize'],
      imagesSize: map['imagesSize'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SizeData.fromJson(String source) =>
      SizeData.fromMap(json.decode(source));
}
