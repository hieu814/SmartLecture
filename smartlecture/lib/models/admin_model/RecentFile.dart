import 'package:smartlecture/models/lecture_model/Lecture.dart';
import 'package:smartlecture/models/user_model/user.dart';

class ItemStore {
  final String icon, title, date, size;
  final User user;
  final Lecture lecture;
  final int type;
  ItemStore(
      {this.user,
      this.lecture,
      this.type,
      this.icon,
      this.title,
      this.date,
      this.size});
}

List demoRecentFiles = [
  ItemStore(
    icon: "assets/icons/xd_file.svg",
    title: "XD File",
    date: "01-03-2021",
    size: "3.5mb",
  ),
  ItemStore(
    icon: "assets/icons/Figma_file.svg",
    title: "Figma File",
    date: "27-02-2021",
    size: "19.0mb",
  ),
  ItemStore(
    icon: "assets/icons/doc_file.svg",
    title: "Documetns",
    date: "23-02-2021",
    size: "32.5mb",
  ),
  ItemStore(
    icon: "assets/icons/sound_file.svg",
    title: "Sound File",
    date: "21-02-2021",
    size: "3.5mb",
  ),
  ItemStore(
    icon: "assets/icons/media_file.svg",
    title: "Media File",
    date: "23-02-2021",
    size: "2.5gb",
  ),
  ItemStore(
    icon: "assets/icons/pdf_file.svg",
    title: "Sals PDF",
    date: "25-02-2021",
    size: "3.5mb",
  ),
  ItemStore(
    icon: "assets/icons/excle_file.svg",
    title: "Excel File",
    date: "25-02-2021",
    size: "34.5mb",
  ),
];
