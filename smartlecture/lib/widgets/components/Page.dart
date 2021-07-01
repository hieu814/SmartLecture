import 'package:flutter/material.dart';
import 'package:smartlecture/models/lecture_model/Page.dart' as p;
import 'package:smartlecture/ui/modules/Scale.dart';
import 'package:smartlecture/widgets/components/Component.dart';
import 'package:smartlecture/widgets/components/ComponentShow.dart';
import 'package:smartlecture/widgets/manage/CacheImg.dart';
import '../../constants.dart';

class IPage extends StatefulWidget {
  final double width;
  final double height;
  final int curentItem;
  final p.Page page;
  final bool isPresentation;
  final Function(p.Page) onDataChange;
  final Function(int) onCurrentItemIndexChange;
  const IPage({
    Key key,
    this.width,
    this.height,
    this.page,
    this.isPresentation,
    this.onDataChange,
    this.onCurrentItemIndexChange,
    this.curentItem,
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
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Stack(children: <Widget>[
          Container(
            child: CacheImg(
              url: widget.page.backgroundImage,
            ),
            height: BASE_HEIGHT,
            width: BASE_WIDTH,
          ),
          Stack(
              children: List.generate(
            temp.items.item.length,
            (index) {
              if (!ispS)
                return Component(
                  isSelect: widget.curentItem == index,
                  scale: scale,
                  item: temp.items.item[index],
                  onDataChange: (t) {
                    temp.items.item[index] = t;
                    widget.onDataChange(temp);
                  },
                  onTap: () {
                    widget.onCurrentItemIndexChange(index);
                  },
                );
              return ComponentShow(item: temp.items.item[index]);
            },
          ))
        ]),
      ),
    );
  }
}
