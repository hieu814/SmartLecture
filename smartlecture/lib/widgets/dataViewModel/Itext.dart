import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:smartlecture/models/Text.dart' as t;
import 'package:smartlecture/ui/modules/function.dart';

class Itext extends StatefulWidget {
  final t.Text text;
  const Itext({
    Key key,
    this.text,
  }) : super(key: key);
  @override
  _ItextState createState() => _ItextState();
}

class _ItextState extends State<Itext> {
  t.Text temp;
  @override
  void initState() {
    super.initState();
    temp = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      temp.text,
      textAlign: getTextAlign(temp.align),
      style: TextStyle(
          fontStyle: toBool(temp.italic) ? FontStyle.italic : FontStyle.normal,
          fontWeight: toBool(temp.bold) ? FontWeight.bold : FontWeight.normal,
          fontSize: temp.size,
          fontFamily: temp.font,
          decoration: toBool(temp.underline)
              ? TextDecoration.underline
              : TextDecoration.none,
          color: hexToColor(temp.color)),
    );
  }
}
//mdColors