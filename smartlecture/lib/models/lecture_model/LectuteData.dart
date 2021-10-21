import 'package:smartlecture/models/lecture_model/Lecture.dart';

class LectuteData {
  String id;
  Lecture lecture;
  bool isSaveToServer = false;
  LectuteData({this.id, this.lecture, this.isSaveToServer});
}
