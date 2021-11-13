import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:smartlecture/models/lecture_model/LectuteData.dart';
import 'package:smartlecture/ui/modules/Setting.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Home/home_viewmodel.dart';
import 'package:smartlecture/ui/views/contribute/Contribute_view.dart';
import 'package:smartlecture/widgets/components/Page.dart';
import 'package:smartlecture/widgets/popup/popup.dart';

class LectureDelegate extends StatefulWidget {
  final LectuteData item;
  final double width;
  final double heigth;
  const LectureDelegate({Key key, this.item, this.width, this.heigth})
      : super(key: key);

  @override
  State<LectureDelegate> createState() => _LectureDelegateState();
}

class _LectureDelegateState extends State<LectureDelegate> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
          widget.item.isSaveToServer = locator<MySetting>().isSync;
          Navigator.pushNamed(context, RouteName.sectionPage,
              arguments: widget.item);
        },
        onLongPress: () async {
          bool a = await showMenu<bool>(
            context: context,
            position: RelativeRect.fromLTRB(100, 100, 100, 100),
            items: [
              PopupMenuItem<bool>(child: const Text('Xóa'), value: true),
            ],
            elevation: 8.0,
          );
          if (a) {
            popupYesNo(context).then((value) {
              if (value)
                context
                    .read<HomeViewModel>()
                    .feleteFileLecture(widget.item.path);
            });
            // context.read<HomeViewModel>().feleteFileLecture(widget.item.path);
          }
        },
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                child: IPage(
                  width: widget.width,
                  height: widget.heigth,
                  page: widget.item.lecture.section[0].page[0],
                  isPresentation: true,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                width: double.infinity,
                //color: Colors.yellow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 8),
                    Text(
                      widget.item.lecture.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 15),
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPopupMenu() async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 100, 100),
      items: [
        PopupMenuItem<bool>(child: const Text('Xóa'), value: true),
      ],
      elevation: 8.0,
    );
  }
}
