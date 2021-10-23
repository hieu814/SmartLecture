import 'dart:convert';

class ImageStore {
  String url;
  String userID;
  String path;
  String createDate;
  ImageStore({this.url, this.userID, this.path, this.createDate});

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'userID': userID,
      'path': path,
      'createDate': createDate,
    };
  }

  factory ImageStore.fromMap(Map<String, dynamic> map) {
    return ImageStore(
      url: map['url'],
      userID: map['userID'],
      path: map['path'],
      createDate: map['createDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageStore.fromJson(String source) =>
      ImageStore.fromMap(json.decode(source));
}
