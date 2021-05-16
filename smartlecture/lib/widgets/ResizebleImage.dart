import 'package:flutter/material.dart';
import 'package:smartlecture/models/ItemImage.dart';
import 'package:smartlecture/ui/modules/Navi.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/widgets/common/ResizebleWidget.dart';
import 'package:smartlecture/widgets/manage/AddLink.dart';

class ResizebleImage extends StatefulWidget {
  final ItemImage data;
  final Function(dynamic) onDataChange;
  const ResizebleImage({Key key, this.data, this.onDataChange})
      : super(key: key);
  @override
  _ResizebleImageState createState() => _ResizebleImageState();
}

class _ResizebleImageState extends State<ResizebleImage> {
  ItemImage temp = new ItemImage();
  @override
  void initState() {
    super.initState();
    temp = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return ResizebleWidget(
      x: widget.data.x,
      y: widget.data.y,
      width: widget.data.width,
      height: widget.data.height,
      child: Image.network(widget.data.url),
      onDoubleTap: () {
        showDialog(
            context: context,
            builder: (_) => new AddLink(
                  data: temp.url,
                  returnData: (s) {
                    temp.url = s;
                    widget.onDataChange(temp);
                    Navigator.of(
                            getIt.get<MyGlobals>().scaffoldKey.currentContext,
                            rootNavigator: true)
                        .pop();
                  },
                ));
      },
      onPositionChange: (x, y) {
        temp.x = x;
        temp.y = y;
        widget.onDataChange(temp);
      },
      onSizeChange: (width, height) {
        temp.width = width;
        temp.height = height;
        widget.onDataChange(temp);
      },
    );
  }
}
