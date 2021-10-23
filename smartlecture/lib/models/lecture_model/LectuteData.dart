import 'package:smartlecture/models/lecture_model/Lecture.dart';

class LectuteData {
  String id;
  String idMyLectures;
  Lecture lecture;
  bool isSaveToServer = false;
  String path;
  LectuteData(
      {this.id,
      this.idMyLectures,
      this.lecture,
      this.isSaveToServer,
      this.path});
}
