import 'package:flutter/material.dart';
import 'package:smartlecture/models/Page.dart' as p;
import 'package:smartlecture/ui/modules/Scale.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/widgets/Component.dart';
import 'package:smartlecture/widgets/ComponentShow.dart';
import '../constants.dart';

class IPage extends StatefulWidget {
  final double width;
  final double height;
  final p.Page page;
  final Map<int, String> data;
  final bool isPresentation;

  const IPage(
      {Key key,
      this.width,
      this.height,
      this.page,
      this.data,
      this.isPresentation})
      : super(key: key);
  @override
  _IPageState createState() => _IPageState();
}

class _IPageState extends State<IPage> {
  ScalePage scale;
  p.Page temp;
  bool ispS = false;
  @override
  void initState() {
    ispS = widget.isPresentation ?? false;
    scale = new ScalePage(
        width: BASE_WIDTH / widget.width, height: BASE_HEIGHT / widget.height);
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        height: BASE_HEIGHT,
        width: BASE_WIDTH,
        decoration: BoxDecoration(border: Border.all(width: 1)),
        child: Stack(
            children: List.generate(
          widget.page.items.item.length,
          (index) {
            if (!ispS)
              return Component(
                  scale: scale, item: widget.page.items.item[index]);
            return ComponentShow(item: widget.page.items.item[index]);
          },
        )),
      ),
    );
  }
}
