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
  final bool isPresentation;

  const IPage({
    Key key,
    this.width,
    this.height,
    this.page,
    this.isPresentation,
  }) : super(key: key);
  @override
  _IPageState createState() => _IPageState();
}

class _IPageState extends State<IPage> {
  ScalePage scale;
  p.Page temp;
  bool ispS = false;
  bool reload = false;
  @override
  void initState() {
    super.initState();
    ispS = widget.isPresentation ?? false;
    scale = new ScalePage(
        width: BASE_WIDTH / widget.width, height: BASE_HEIGHT / widget.height);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant IPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    temp = widget.page;
    reload = !reload;
    return FittedBox(
      key: ValueKey<bool>(reload),
      fit: BoxFit.contain,
      child: Container(
        height: BASE_HEIGHT,
        width: BASE_WIDTH,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/board.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: new Stack(
            children: List.generate(
          temp.items.item.length,
          (index) {
            if (!ispS)
              return Component(scale: scale, item: temp.items.item[index]);
            return ComponentShow(item: temp.items.item[index]);
          },
        )),
      ),
    );
  }
}
