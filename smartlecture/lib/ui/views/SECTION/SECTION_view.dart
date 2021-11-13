import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/media/myAudio.dart';
import 'package:smartlecture/models/lecture_model/Lecture.dart';
import 'package:smartlecture/models/lecture_model/LectuteData.dart';
import 'package:smartlecture/models/common/SectionIndex..dart';
import 'package:smartlecture/ui/modules/Navi.dart';
import 'package:smartlecture/ui/modules/function.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Section/SECTION_viewmodel.dart';
import 'package:smartlecture/widgets/components/ListSection.dart';
import 'package:smartlecture/widgets/components/Page.dart';
import 'package:smartlecture/widgets/components/YoutubePlayer.dart';
import 'package:smartlecture/widgets/popup/popup.dart';
import 'package:smartlecture/models/lecture_model/Page.dart' as p;
import 'package:smartlecture/constants.dart' as cst;
import 'package:provider/provider.dart';

class SectionView extends StatefulWidget {
  final LectuteData data;
  SectionView(this.data);
  @override
  _SectionViewState createState() => _SectionViewState();
}

class _SectionViewState extends State<SectionView> {
  SectionIndex index;
  AudioPlayer audioPlayer = AudioPlayer();
  p.Page page;
  String id;
  bool isInit = false;
  play() async {
    int result = await audioPlayer.play(
        "https://aredir.nixcdn.com/NhacCuaTui220/MyLady-Yanbi-MrT-Bueno-TMT_3znvk.mp3?st=sQRIMCC8TcAiq7I0deCB6Q&e=1624533949");
    if (result == 1) {
      // success
    }
  }

  @override
  void initState() {
    super.initState();
    id = widget.data.id;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SectionViewModel(data: widget.data),
        ),
      ],
      builder: (context, child) {
        return Scaffold(
          key: locator.get<MyGlobals>().scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              title: Text(context.read<SectionViewModel>().lecture.title ?? ""),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    popupString(context, "Nhập tên bài giảng",
                            context.read<SectionViewModel>().lecture.title)
                        .then((value) => {
                              if (value != "")
                                {
                                  context.read<SectionViewModel>().modifyTitle(
                                      value == "" ? "Bài giảng mới" : value, 0)
                                }
                            });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.play_arrow),
                  onPressed: () async {
                    Navigator.pushNamed(context, RouteName.presentation,
                        arguments: context.read<SectionViewModel>().lecture);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: () async {
                    context
                        .read<SectionViewModel>()
                        .saveData()
                        .then((value) => showInSnackBar(context, "đã lưu"));
                  },
                ),
              ],
            ),
          ),
          body: Column(
            children: <Widget>[
              Container(
                height: 50,
                width: double.infinity,
                child: Row(children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Container(
                        height: 50,
                        width: double.infinity,
                        child: Consumer<SectionViewModel>(
                          builder: (context, model, child) =>
                              DropdownButton<dynamic>(
                                  value: context
                                      .read<SectionViewModel>()
                                      .currentSection,
                                  onChanged: (val) {
                                    setState(() {
                                      model.setCurrenindex(SectionIndex(
                                          currentPageIndex: 0,
                                          currentSectionIndex: val));
                                    });
                                  },
                                  items: getDropDownMenuItems(model.lecture)),
                        )),
                  ),
                  Expanded(
                      flex: 4,
                      child: Row(
                        children: <Widget>[
                          IconTheme(
                            data: new IconThemeData(color: Colors.cyan),
                            child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () async {
                                  popupString(
                                          context,
                                          "Nhập tên Section",
                                          context
                                              .read<SectionViewModel>()
                                              .lecture
                                              .section[context
                                                  .read<SectionViewModel>()
                                                  .currentSection]
                                              .title)
                                      .then((value) => {
                                            if (value != "")
                                              {
                                                context
                                                    .read<SectionViewModel>()
                                                    .modifyTitle(
                                                        value == ""
                                                            ? "Mục mới"
                                                            : value,
                                                        1)
                                              }
                                          });
                                }),
                          ),
                          IconTheme(
                            data: new IconThemeData(color: Colors.red),
                            child: IconButton(
                                icon: Icon(Icons.highlight_remove_outlined),
                                onPressed: () async {
                                  popupYesNo(context).then((value) {
                                    if (value) {
                                      context
                                          .read<SectionViewModel>()
                                          .deleteSection();
                                    }
                                  });
                                }),
                          ),
                          IconTheme(
                            data: new IconThemeData(color: Colors.green),
                            child: IconButton(
                                icon: Icon(Icons.add_circle),
                                onPressed: () async {
                                  popupString(context, "Nhập tên Section", "")
                                      .then((value) => {
                                            context
                                                .read<SectionViewModel>()
                                                .addSection(value == ""
                                                    ? "Trang mới"
                                                    : value)
                                          });
                                }),
                          )
                        ],
                      ))
                ]),
              ),
              Expanded(
                  flex: 7,
                  child: Consumer<SectionViewModel>(
                    builder: (context, model, child) => Stack(
                      children: <Widget>[
                        Center(
                            child: Container(
                          width: MediaQuery.of(context).size.height,
                          height: 6 * width / 8,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.red)),
                          child: IPage(
                            width: MediaQuery.of(context).size.width,
                            height: 6 * width / 8,
                            onDataChange: (t) {},
                            curentItem: model.currentIndex.currentItemIndex,
                            onCurrentItemIndexChange: (index) {
                              context
                                  .read<SectionViewModel>()
                                  .setCurrenindex(SectionIndex(
                                    currentItemIndex: index,
                                  ));
                            },
                            onAction: (action) async {
                              print("onAction");
                              if (action == 0)
                                context.read<SectionViewModel>().deleteItem();
                              else {
                                await popupString(context, "Nhập đường dẫn", "")
                                    .then((value) {
                                  context
                                      .read<SectionViewModel>()
                                      .updateAudio(value);
                                });
                              }
                            },
                            page: model
                                .lecture
                                .section[model.currentIndex.currentSectionIndex]
                                .page[model.currentIndex.currentPageIndex],
                          ),
                        ))
                      ],
                    ),
                  )),
              Expanded(
                  // width: double.infinity,
                  // height: 80,
                  flex: 3,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child: Container(
                              width: double.infinity,
                              height: 100,
                              child: Row(
                                children: [
                                  Center(
                                    child: GestureDetector(
                                      onDoubleTap: () async {
                                        popupString(
                                                context,
                                                "Nhập tên Page",
                                                context
                                                    .read<SectionViewModel>()
                                                    .lecture
                                                    .section[context
                                                        .read<
                                                            SectionViewModel>()
                                                        .currentSection]
                                                    .page[context
                                                        .read<
                                                            SectionViewModel>()
                                                        .currentPage]
                                                    .title)
                                            .then((value) => {
                                                  if (value != "")
                                                    {
                                                      context
                                                          .read<
                                                              SectionViewModel>()
                                                          .modifyTitle(
                                                              value == ""
                                                                  ? "Trang mới"
                                                                  : value,
                                                              2)
                                                    }
                                                });
                                      },
                                      child: Container(
                                        width: 150,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text(
                                            context
                                                .read<SectionViewModel>()
                                                .lecture
                                                .section[context
                                                    .read<SectionViewModel>()
                                                    .currentSection]
                                                .page[context
                                                    .read<SectionViewModel>()
                                                    .currentPage]
                                                .title,
                                            maxLines: 1,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        await editMedia(
                                                context,
                                                context
                                                    .read<SectionViewModel>()
                                                    .lecture
                                                    .section[context
                                                        .read<
                                                            SectionViewModel>()
                                                        .currentSection]
                                                    .page[context
                                                        .read<
                                                            SectionViewModel>()
                                                        .currentPage]
                                                    .backgroundImage,
                                                false)
                                            .then((value) {
                                          if (value != null || value != "") {
                                            setState(() {});
                                            context
                                                .read<SectionViewModel>()
                                                .changeBackgroundImage(
                                                    value ?? "", 0);
                                          }
                                        });
                                      },
                                      icon: Icon(Icons.image)),
                                  IconButton(
                                    onPressed: () async {
                                      await context
                                          .read<SectionViewModel>()
                                          .addPage();
                                    },
                                    icon: Icon(
                                      Icons.add_circle_outline_sharp,
                                      color: Colors.green,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        popupYesNo(context).then((value) {
                                          if (value) {
                                            context
                                                .read<SectionViewModel>()
                                                .deletePage();
                                          }
                                        });
                                      },
                                      icon: Icon(
                                        Icons.highlight_remove_outlined,
                                        color: Colors.red,
                                      )),
                                ],
                              ))),
                      Expanded(
                        flex: 8,
                        child: Consumer<SectionViewModel>(
                          builder: (context, model, child) {
                            return ListSection(
                              section:
                                  model.lecture.section[model.currentSection],
                              isHorizontal: true,
                              currentPage: model.currentPage,
                              onCurrentPageChange: (index) {
                                model.setCurrenindex(SectionIndex(
                                    currentPageIndex: index,
                                    currentSectionIndex: -1));
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  )),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.format_color_text),
                      onPressed: () async {
                        context
                            .read<SectionViewModel>()
                            .addComponent(cst.Type.ITEXTBLOCK);
                      }),
                  IconButton(
                      icon: Icon(Icons.image_sharp),
                      onPressed: () async {
                        context
                            .read<SectionViewModel>()
                            .addComponent(cst.Type.IIMAGE);
                      }),
                  IconButton(
                      icon: Icon(Icons.video_label),
                      onPressed: () async {
                        context
                            .read<SectionViewModel>()
                            .addComponent(cst.Type.IMAINMEDIA);
                      }),
                  IconButton(
                      icon: Icon(Icons.format_align_center_sharp),
                      onPressed: () async {
                        // locator<MyAudio>().url =
                        //     "https://aredir.nixcdn.com/NhacCuaTui220/MyLady-Yanbi-MrT-Bueno-TMT_3znvk.mp3?st=sQRIMCC8TcAiq7I0deCB6Q&e=1624533949";
                        // play();
                        // locator<MyAudio>().playAudio();
                      }),
                  // IconButton(
                  //     icon: Icon(Icons.format_align_left_sharp),
                  //     onPressed: () {}),
                  // IconButton(
                  //     icon: Icon(Icons.format_align_right_sharp),
                  //     onPressed: () {}),
                  // IconButton(
                  //     icon: Icon(Icons.format_bold_sharp), onPressed: () {}),
                  // IconButton(
                  //     icon: Icon(Icons.format_color_fill), onPressed: () {}),
                  // IconButton(
                  //     icon: Icon(Icons.format_italic_sharp), onPressed: () {}),
                  // IconButton(
                  //     icon: Icon(Icons.format_shapes_sharp), onPressed: () {}),
                  // IconButton(
                  //     icon: Icon(Icons.format_underline_sharp),
                  //     onPressed: () {}),
                  // IconButton(
                  //     icon: Icon(Icons.format_indent_decrease_sharp),
                  //     onPressed: () {}),
                ],
              ),
              //decoration:
              //BoxDecoration(border: Border.all(color: Colors.red)),
            ),
          ),
        );
      },
    );
  }
}

getDropDownMenuItems(Lecture a) {
  print("get lecture ");
  Map<int, dynamic> mapWithIndex = a.section.asMap();
  List<DropdownMenuItem> _items = [];
  mapWithIndex.forEach((index, item) {
    _items.add(
      DropdownMenuItem<int>(
        value: index,
        child: Text(item.title),
      ),
    );
  });
  return _items;
}
