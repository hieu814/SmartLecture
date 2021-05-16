import 'package:flutter/material.dart';
import 'package:smartlecture/models/ItemImage.dart';
import 'package:smartlecture/models/ItemText.dart';
import 'package:smartlecture/widgets/ResizebleImage.dart';
import 'package:smartlecture/widgets/ResizebleText.dart';

class Component extends StatefulWidget {
  final dynamic data;
  final Function(dynamic) onDataChange;
  const Component({Key key, this.data, this.onDataChange}) : super(key: key);
  @override
  _ComponentState createState() => _ComponentState();
}

class _ComponentState extends State<Component> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.runtimeType == ItemImage) {
      return ResizebleImage(
        data: widget.data,
        onDataChange: (data) {
          widget.onDataChange(data);
        },
      );
    }
    if (widget.data.runtimeType == ItemText) {
      return ResizebleText(
        data: widget.data,
        onDataChange: (data) {
          widget.onDataChange(data);
        },
      );
    }
    return Text("Error");
  }
}
