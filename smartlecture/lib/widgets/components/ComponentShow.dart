import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/media/myAudio.dart';

import 'package:smartlecture/models/lecture_model/Item.dart';
import 'package:smartlecture/ui/modules/function.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/widgets/components/YoutubeView.dart';

class ComponentShow extends StatefulWidget {
  final Item item;
  const ComponentShow({
    Key key,
    this.item,
  }) : super(key: key);
  @override
  _ComponentShowState createState() => _ComponentShowState();
}

class _ComponentShowState extends State<ComponentShow> {
  @override
  void dispose() {
    locator<MyAudio>().stopAudio();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.item.y,
      left: widget.item.x,
      child: GestureDetector(
        onTap: () async {
          if (typeName.map[widget.item.name] == Type.IMAINMEDIA) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => YoutubeView(
                        url: widget.item.itemInfo.media.mediaUrl,
                      )),
            );
          } else {
            if (locator<MyAudio>().audioState != "Playing") {
              locator<MyAudio>().url =
                  "https://aredir.nixcdn.com/NhacCuaTui220/MyLady-Yanbi-MrT-Bueno-TMT_3znvk.mp3?st=sQRIMCC8TcAiq7I0deCB6Q&e=1624533949";
              locator<MyAudio>().playAudio();
            } else {
              locator<MyAudio>().stopAudio();
            }
          }
        },
        child: Container(
          width: widget.item.width,
          height: widget.item.height,
          child: fromItem(widget.item),
        ),
      ),
    );
  }
}
