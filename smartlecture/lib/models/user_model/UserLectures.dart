import 'dart:convert';

class UserLecture {
  List<String> lectures;
  UserLecture({
    this.lectures,
  });

  Map<String, dynamic> toMap() {
    return {
      'lectures': lectures,
    };
  }

  factory UserLecture.fromMap(Map<String, dynamic> map) {
    return UserLecture(
      lectures: List<String>.from(map['lectures']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLecture.fromJson(String source) =>
      UserLecture.fromMap(json.decode(source));
}
