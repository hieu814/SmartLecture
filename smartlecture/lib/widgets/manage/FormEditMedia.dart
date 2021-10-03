import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/widgets/manage/EditMedia.dart';

class FormEditMedia extends StatefulWidget {
  final String url;
  final bool isVideo;
  final Function(String) returnData;
  const FormEditMedia({Key key, this.url, this.returnData, this.isVideo})
      : super(key: key);

  @override
  _FormEditMediaState createState() => _FormEditMediaState();
}

class _FormEditMediaState extends State<FormEditMedia> {
  TextEditingController textController = new TextEditingController();
  String temp;

  @override
  void initState() {
    super.initState();
    temp = widget.url ?? "";
    textController.text = temp;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, temp);
              },
              child: Text('Lưu'),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Card(
                    child: Container(
                      width: width,
                      height: width * 6 / 8,
                      child: CachedNetworkImage(
                        imageUrl: temp,
                        placeholder: (context, url) => _getPlaceholder(),
                        errorWidget: (context, url, error) => _getPlaceholder(),
                        fit: BoxFit.fill,
                      ),
                    ),
                  )),
              SizedBox(
                height: 100,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Đường dẫn",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: textController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (s) {
                        temp = s;
                        widget.returnData(temp);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _getPlaceholder() => Image.asset(
        'assets/images/no_image.png',
        fit: BoxFit.fill,
      );
}
