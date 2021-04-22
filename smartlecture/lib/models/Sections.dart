import 'package:smartlecture/models/Image.dart';
import 'package:smartlecture/models/Text.dart';

class Section {
  String title;
  Map<String, dynamic> a;
  void add() {
    Text t = Text("_txt");
    a['text'] = t;
    a['imgs'] = Image("_source");
    t = a['text'];
  }
}
