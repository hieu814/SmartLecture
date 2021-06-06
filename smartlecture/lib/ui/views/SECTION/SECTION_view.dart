import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/models/Lecture.dart';
import 'package:smartlecture/models/LectuteData.dart';
import 'package:smartlecture/models/common/SectionIndex..dart';
import 'package:smartlecture/ui/modules/Navi.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/widgets/Page.dart';
import 'package:smartlecture/widgets/manage/ListSection.dart';
import 'package:stacked/stacked.dart';
import 'package:smartlecture/models/Page.dart' as p;
import 'Section_viewmodel.dart';

class SectionView extends StatefulWidget {
  final LectuteData data;
  SectionView(this.data);
  @override
  _SectionViewState createState() => _SectionViewState();
}

class _SectionViewState extends State<SectionView> {
  int currentPage = 0;
  int currentSection = 0;
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
    return ViewModelBuilder<SectionViewModel>.reactive(
        viewModelBuilder: () => SectionViewModel(),
        onModelReady: (model) =>
            model.load().then((value) => model.setBusy(false)),
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) {
          if (!isInit) {
            model.setlecture(_lecture);
            isInit = true;
          } else {
            _lecture = model.lecture;
            model.setCurrenindex(SectionIndex(
                currentPageIndex: currentPage,
                currentSectionIndex: currentSection));
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
                : OrientationBuilder(builder: (context, orientation) {
                    if (orientation == Orientation.portrait) {
                      double width = MediaQuery.of(context).size.width;
                      return Column(
                        children: <Widget>[
                          Card(
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              child: DropdownButton<dynamic>(
                                  value: currentSection,
                                  onChanged: (val) {
                                    setState(() {
                                      currentSection = val;
                                      currentPage = 0;
                                    });
                                  },
                                  items: getDropDownMenuItems(_lecture)),
                            ),
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
                                      border: Border.all(
                                          width: 1, color: Colors.red)),
                                  child: IPage(
                                    width: MediaQuery.of(context).size.width,
                                    height: 6 * width / 8,
                                    page: _lecture.section[currentSection]
                                        .page[currentPage],
                                  ),
                                ))
                              ],
                            ),
                          ),
                          Expanded(
                              // width: double.infinity,
                              // height: 80,
                              flex: 2,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                          width: 100,
                                          height: 100,
                                          margin: EdgeInsets.all(5))),
                                  Expanded(
                                    flex: 8,
                                    child: ListSection(
                                      section: _lecture.section[currentSection],
                                      isHorizontal: true,
                                      currentPage: currentPage,
                                      onCurrentPageChange: (index) {
                                        print(
                                            "curren page: " + index.toString());
                                        setState(() {
                                          currentPage = index;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      );
                    } else {
                      double height = MediaQuery.of(context).size.height -
                          AppBar().preferredSize.height -
                          50;
                      return Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            // width: 80,
                            // height: double.infinity,
                            child: ListSection(
                              isHorizontal: true,
                            ),
                          ),
                          Expanded(
                              flex: 7,
                              child: Stack(
                                children: <Widget>[
                                  Center(
                                      child: Container(
                                    height: height,
                                    width: 8 * height / 6,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.green)),
                                    child: IPage(
                                        width: 8 * height / 6,
                                        height: height,
                                        page: _lecture.section[currentSection]
                                            .page[currentPage]),
                                  ))
                                ],
                              )),
                        ],
                      );
                    }
                  }),
            bottomNavigationBar: BottomAppBar(
              child: Container(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.format_color_text),
                        onPressed: () async {
                          model.addComponent("type");
                        }),
                    IconButton(icon: Icon(Icons.image_sharp), onPressed: () {}),
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
