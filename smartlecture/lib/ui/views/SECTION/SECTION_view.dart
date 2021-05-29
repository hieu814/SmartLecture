import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smartlecture/models/Lecture.dart';
import 'package:smartlecture/ui/modules/Navi.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/widgets/Component.dart';
import 'package:smartlecture/widgets/Page.dart';
import 'package:smartlecture/widgets/manage/ListSection.dart';
import 'package:stacked/stacked.dart';
import 'package:smartlecture/models/Page.dart' as p;
import '../../../constants.dart';
import 'Section_viewmodel.dart';

class SectionView extends StatefulWidget {
  @override
  _SectionViewState createState() => _SectionViewState();
}

class _SectionViewState extends State<SectionView> {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    //]);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SectionViewModel>.reactive(
        viewModelBuilder: () => SectionViewModel(),
        onModelReady: (model) => model.load(),
        builder: (context, model, child) {
          int currentSectionIndex = 0;
          List<String> titles = model.getListSection();
          return Scaffold(
            key: getIt.get<MyGlobals>().scaffoldKey,
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                title: DropdownButton<String>(
                  hint: new Text('Pickup on every'),
                  value: titles[currentSectionIndex],
                  items: titles.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      currentSectionIndex = titles.indexOf(value);
                    });
                  },
                ),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                  PopupMenuButton(
                    icon: Icon(Icons.share),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: Image.network(
                            "https://duhocvietglobal.com/wp-content/uploads/2018/12/dat-nuoc-va-con-nguoi-anh-quoc.jpg"),
                      )
                    ],
                  )
                ],
              ),
            ),
            body: OrientationBuilder(builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                double width = MediaQuery.of(context).size.width;
                return Column(
                  children: <Widget>[
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
                              page: model.getPage(3),
                            ),
                          ))
                        ],
                      ),
                    ),
                    Expanded(
                      // width: double.infinity,
                      // height: 80,
                      flex: 2,
                      child: ListSection(
                        currentSectionIndex: 2,
                        lecture: model.lecture,
                        isHorizontal: true,
                      ),
                    ),
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
                                page: model.getPage(0),
                              ),
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
                          Lecture lecture = model.lecture;
                          p.Page a = lecture.section[0].page[0];
                          print("------------------------");
                          // print(as.section[0].page[0].items.item[0].itemInfo
                          //     .toJson());
                          print(a.toJson());
                          //print(a);
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
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    model.addComponent("1");
                  },
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                ),
                SizedBox(width: 30),
                FloatingActionButton(
                  onPressed: () {
                    model.addComponent("2");
                  },
                  tooltip: 'Decrement',
                  child: Icon(Icons.remove),
                ),
              ],
            ),
          );
        });
  }
}
