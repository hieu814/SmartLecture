import 'package:flutter/material.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/lecture_model/Item.dart';
import 'package:smartlecture/widgets/manage/EditText.dart';
import 'package:smartlecture/models/lecture_model/Text.dart' as iText;
import 'package:smartlecture/models/lecture_model/Image.dart' as iImage;
import 'package:smartlecture/widgets/manage/FormEditMedia.dart';

class FormEdit extends StatefulWidget {
  final Item item;
  final Function(iText.Text) returnData;

  const FormEdit({Key key, this.item, this.returnData}) : super(key: key);

  @override
  _FormEditState createState() => _FormEditState();
}

class _FormEditState extends State<FormEdit> {
  TextEditingController textController = new TextEditingController();
  Item temp;
  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      temp = widget.item;
    }
  }

  @override
  Widget build(BuildContext context) {
    return getItem();
  }

  Widget getItem() {
    print("----- item: " + temp.toJson().toString());
    if (typeName.map[temp.name] == Type.ITEXTBLOCK) {
      return Scaffold(
          appBar: AppBar(
            title: Text(widget.item.name ?? ""),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, temp);
                },
                child: Text('Lưu'),
              ),
            ],
          ),
          body: EditText(
            item: temp,
            returnData: (a) {
              temp = a;
            },
          ));
    } else if (typeName.map[temp.name] == Type.IIMAGE) {
      return FormEditMedia(
        isVideo: false,
        url: temp.itemInfo.image.url,
        returnData: (a) {
          temp.itemInfo.image.url = a;
        },
      );
    }
    return Container(
      child: Text("ádasd"),
    );
  }
}
