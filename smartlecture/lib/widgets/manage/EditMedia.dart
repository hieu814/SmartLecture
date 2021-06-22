import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EditMedia extends StatefulWidget {
  final String url;
  final Function(String) returnData;

  const EditMedia({Key key, this.url, this.returnData}) : super(key: key);

  @override
  _EditMediaState createState() => _EditMediaState();
}

class _EditMediaState extends State<EditMedia> {
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
    widget.returnData(temp);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 7,
              child: Card(
                child: CachedNetworkImage(
                  imageUrl: temp,
                  placeholder: (context, url) => _getPlaceholder(),
                  errorWidget: (context, url, error) => _getPlaceholder(),
                  fit: BoxFit.fill,
                ),
              )),
          Expanded(
            flex: 2,
            child: TextField(
              keyboardType: TextInputType.url,
              controller: textController,
              maxLines: null,
              onChanged: (s) {
                widget.returnData(temp);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPlaceholder() => Image.asset(
        'assets/images/placeholder.jpg',
        fit: BoxFit.fill,
      );
}

extension HexColor on Color {
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
