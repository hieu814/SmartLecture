import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/models/Lecture.dart';
import 'package:smartlecture/models/LectuteData.dart';
import 'package:smartlecture/models/Section.dart';
import 'package:smartlecture/models/common/SectionIndex..dart';
import 'package:smartlecture/ui/modules/Navi.dart';
import 'package:smartlecture/ui/modules/function.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/widgets/Page.dart';
import 'package:smartlecture/widgets/manage/AddLink.dart';
import 'package:smartlecture/widgets/manage/ListSection.dart';
import 'package:smartlecture/widgets/popup/popup.dart';
import 'package:stacked/stacked.dart';
import 'package:smartlecture/models/Page.dart' as p;
import 'Section_viewmodel.dart';
import 'package:smartlecture/constants.dart' as cst;

class SectionView extends StatefulWidget {
  final LectuteData data;
  SectionView(this.data);
  @override
  _SectionViewState createState() => _SectionViewState();
}

class _SectionViewState extends State<SectionView> {
  int currentPage = 0;
  int currentSection = 0;
  int currentItem = 0;

  p.Page page;
  Lecture _lecture;
  String id;
  bool isInit = false;
  @override
  void initState() {
    super.initState();
    _lecture = widget.data.lecture;
    id = widget.data.id;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ViewModelBuilder<SectionViewModel>.reactive(
        viewModelBuilder: () => SectionViewModel(),
        onModelReady: (model) =>
            model.load().then((value) => model.setBusy(false)),
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) {
          if (!isInit) {
            isInit = true;
            model.setlecture(_lecture);
          } else {
            SectionIndex p = model.currentIndex;

            _lecture = model.lecture;
            currentPage = p.currentPageIndex;
            currentSection = p.currentSectionIndex;
            currentItem = p.currentItemIndex;
            // model.setCurrenindex(SectionIndex(
            //     currentPageIndex: currentPage,
            //     currentSectionIndex: currentSection));
          }

          return Scaffold(
            key: locator.get<MyGlobals>().scaffoldKey,
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                title: Text(_lecture.title ?? ""),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      popupString(context, "Nhập tên bài giảng", _lecture.title)
                          .then((value) => {
                                if (value != "")
                                  {
                                    model.modifyTitle(
                                        value == "" ? "Bài giảng mới" : value,
                                        0)
                                  }
                              });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            body: model.isBusy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
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
                              child: DropdownButton<dynamic>(
                                  value: currentSection,
                                  onChanged: (val) {
                                    setState(() {
                                      currentSection = val;
                                      currentPage = 0;
                                      model.setCurrenindex(SectionIndex(
                                          currentPageIndex: currentPage,
                                          currentSectionIndex: val));
                                    });
                                  },
                                  items: getDropDownMenuItems(_lecture)),
                            ),
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
                                                  _lecture
                                                      .section[currentSection]
                                                      .title)
                                              .then((value) => {
                                                    if (value != "")
                                                      {
                                                        model.modifyTitle(
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
                                        icon: Icon(
                                            Icons.highlight_remove_outlined),
                                        onPressed: () async {
                                          popupYesNo(context).then((value) {
                                            if (value) {
                                              setState(() {
                                                if (currentSection > 0)
                                                  currentSection--;
                                                currentPage = 0;
                                                model.deleteSection();
                                              });
                                            }
                                          });
                                        }),
                                  ),
                                  IconTheme(
                                    data:
                                        new IconThemeData(color: Colors.green),
                                    child: IconButton(
                                        icon: Icon(Icons.add_circle),
                                        onPressed: () async {
                                          popupString(context,
                                                  "Nhập tên Section", "")
                                              .then((value) => {
                                                    model.addSection(value == ""
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
                        child: Stack(
                          children: <Widget>[
                            Center(
                                child: Container(
                              width: MediaQuery.of(context).size.height,
                              height: 6 * width / 8,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.red)),
                              child: IPage(
                                width: MediaQuery.of(context).size.width,
                                height: 6 * width / 8,
                                onDataChange: (t) {},
                                curentItem: currentItem,
                                onCurrentItemIndexChange: (index) {
                                  setState(() {
                                    model.setCurrenindex(SectionIndex(
                                      currentItemIndex: index,
                                    ));
                                  });
                                },
                                page: _lecture
                                    .section[currentSection].page[currentPage],
                              ),
                            ))
                          ],
                        ),
                      ),
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
                                                        _lecture
                                                            .section[
                                                                currentSection]
                                                            .page[currentPage]
                                                            .title)
                                                    .then((value) => {
                                                          if (value != "")
                                                            {
                                                              model.modifyTitle(
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
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Text(
                                                    _lecture
                                                        .section[currentSection]
                                                        .page[currentPage]
                                                        .title,
                                                    maxLines: 1,
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () async {
                                                await editMedia(
                                                        context,
                                                        _lecture
                                                            .section[
                                                                currentSection]
                                                            .page[currentPage]
                                                            .backgroundImage,
                                                        false)
                                                    .then((value) {
                                                  if (value != null ||
                                                      value != "") {
                                                    model.changeBackgroundImage(
                                                        value ?? "", 0);
                                                  }
                                                });
                                              },
                                              icon: Icon(Icons.image)),
                                          IconButton(
                                            onPressed: () async {
                                              await model.addPage();
                                            },
                                            icon: Icon(
                                              Icons.add_circle_outline_sharp,
                                              color: Colors.green,
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () async {
                                                setState(() {});
                                                popupYesNo(context)
                                                    .then((value) {
                                                  if (value) {
                                                    model.deletePage();
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
                                child: ListSection(
                                  section: _lecture.section[currentSection],
                                  isHorizontal: true,
                                  currentPage: currentPage,
                                  onCurrentPageChange: (index) {
                                    setState(() {
                                      model.setCurrenindex(SectionIndex(
                                          currentPageIndex: index,
                                          currentSectionIndex: -1));
                                    });
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
                          model.addComponent(cst.Type.ITEXTBLOCK);
                        }),
                    IconButton(
                        icon: Icon(Icons.image_sharp),
                        onPressed: () async {
                          model.addComponent(cst.Type.IIMAGE);
                        }),
                    IconButton(icon: Icon(Icons.video_label), onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.format_align_center_sharp),
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.format_align_left_sharp),
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.format_align_right_sharp),
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.format_bold_sharp), onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.format_color_fill), onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.format_italic_sharp),
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.format_shapes_sharp),
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.format_underline_sharp),
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.format_indent_decrease_sharp),
                        onPressed: () {}),
                  ],
                ),
                //decoration:
                //BoxDecoration(border: Border.all(color: Colors.red)),
              ),
            ),
          );
        });
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
