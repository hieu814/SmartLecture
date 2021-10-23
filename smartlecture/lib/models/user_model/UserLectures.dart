import 'dart:convert';

class MyLectures {
  List<String> lectures;
  MyLectures({
    this.lectures,
  });

  Map<String, dynamic> toMap() {
    return {
      'lectures': lectures,
    };
  }

  factory MyLectures.fromMap(Map<String, dynamic> map) {
    return MyLectures(
      lectures: List<String>.from(map['lectures']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyLectures.fromJson(String source) =>
      MyLectures.fromMap(json.decode(source));
}
