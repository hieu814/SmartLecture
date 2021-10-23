import 'dart:convert';

class LectureDataStore {
  String images = "";
  String contributeId = "";
  String video = "";
  bool status = false;
  LectureDataStore(
      {this.images, this.contributeId, this.video, this.status = false});

  Map<String, dynamic> toMap() {
    return {
      'images': images,
      'contributeId': contributeId,
      'video': video,
      'status': status,
    };
  }

  factory LectureDataStore.fromMap(Map<String, dynamic> map) {
    return LectureDataStore(
      images: map['images'] ?? "",
      contributeId: map['contributeId'] ?? "",
      video: map['video'] ?? "",
      status: map['status'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory LectureDataStore.fromJson(String source) =>
      LectureDataStore.fromMap(json.decode(source));
}

class Document {
  String name;
  bool isFile;
  String id;
  String path;
  List<Document> childData;

  Document({
    this.name,
    this.id,
    this.isFile = false,
    this.path,
    this.childData = const <Document>[],
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isFile': isFile,
      'id': id,
      'path': path,
      'childData': childData?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Document.fromMap(Map<String, dynamic> map) {
    return Document(
      name: map['name'],
      isFile: map['isFile'],
      id: map['id'],
      path: map['path'],
      childData: List<Document>.from(
          map['childData']?.map((x) => Document.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Document.fromJson(String source) =>
      Document.fromMap(json.decode(source));
}
