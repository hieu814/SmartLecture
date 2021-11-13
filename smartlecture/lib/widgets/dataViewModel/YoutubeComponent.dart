import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartlecture/models/lecture_model/Text.dart' as t;
import 'package:smartlecture/ui/modules/function.dart';

class YoutubeComponent extends StatefulWidget {
  final String url;

  const YoutubeComponent({
    Key key,
    this.url,
  }) : super(key: key);
  @override
  _YoutubeComponentState createState() => _YoutubeComponentState();
}

class _YoutubeComponentState extends State<YoutubeComponent> {
  String temp;
  @override
  void initState() {
    super.initState();
    temp = widget.url;
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fill,
      child: Image.asset(
        'assets/images/ytb.PNG',
      ),
    );
  }
}
//mdColors