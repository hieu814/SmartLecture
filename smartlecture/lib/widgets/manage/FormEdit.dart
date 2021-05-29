import 'package:flutter/material.dart';
import 'package:smartlecture/models/Item.dart';
import 'package:smartlecture/models/Text.dart' as iText;
import 'package:smartlecture/widgets/manage/EditText.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.name),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, textController.text);
            },
            child: Text('Lưu'),
          ),
        ],
      ),
      body: EditText(),
    );
  }
}
