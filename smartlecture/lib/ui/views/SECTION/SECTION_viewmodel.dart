import 'package:smartlecture/models/ItemImage.dart';
import 'package:smartlecture/models/ItemText.dart';
import 'package:smartlecture/models/common/Item.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';

class SectionViewModel extends BaseViewModel {
  ItemImage t = new ItemImage.argument(
      x: 100,
      y: 100,
      width: 100,
      height: 100,
      url:
          "https://duhocvietglobal.com/wp-content/uploads/2018/12/dat-nuoc-va-con-nguoi-anh-quoc.jpg");
  ItemText txt = new ItemText.argument(
      x: 100, y: 100, width: 100, height: 100, text: "Input there", type: "1");

  List<dynamic> listdata = [];
  SectionViewModel() {
    listdata.add(txt);
  }

  List<dynamic> getdatas() => this.listdata;

  void addComponent(String type) {
    if (type == "2") {
      listdata.add(t);
    } else if (type == "1") {
      listdata.add(txt);
    }
    notifyListeners();
  }

  void updateComponent(dynamic data, int index) {
    listdata[index] = data;
  }
}
