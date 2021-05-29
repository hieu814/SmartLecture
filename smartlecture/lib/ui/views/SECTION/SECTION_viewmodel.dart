import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:smartlecture/models/Lecture.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/models/Page.dart' as p;

class SectionViewModel extends BaseViewModel {
  Lecture _lecture;
  get lecture => _lecture;

  SectionViewModel() {
    _lecture = new Lecture();
  }
  Future<String> getJson() async {
    return rootBundle.loadString('assets/lectures/example2.json');
  }

  void addComponent(String type) {
    notifyListeners();
  }

  p.Page getPage(int index) {
    List<p.Page> page = _lecture.section[3].page;
    return page[index];
  }

  List<String> getListSection() {
    List<String> t = ["ádasdasdasd", "ádasdasdasdasd"];
    // _lecture.section.forEach((element) {
    //   t.add(element.title);
    // });
  }

  Future load() async {
    String a = await getJson();
    Map<String, dynamic> jsons = json.decode(a);
    _lecture = Lecture.fromJson(jsons["LECTURE"]);
  }

  void updateComponent(dynamic data, int index) {}
}
