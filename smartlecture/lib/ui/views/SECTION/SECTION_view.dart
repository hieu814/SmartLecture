import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smartlecture/models/ItemText.dart';
import 'package:smartlecture/models/common/Item.dart';
import 'package:smartlecture/ui/modules/Navi.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/widgets/Component.dart';
import 'package:stacked/stacked.dart';

import 'Section_viewmodel.dart';

class SECTION extends StatefulWidget {
  @override
  _SECTIONState createState() => _SECTIONState();
}

class _SECTIONState extends State<SECTION> {
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
        onModelReady: (model) => SectionViewModel(),
        builder: (context, model, child) => Scaffold(
              key: getIt.get<MyGlobals>().scaffoldKey,
              resizeToAvoidBottomInset: false,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(40.0),
                child: AppBar(
                  title: Text("home"),
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
                  return Column(
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width,
                                decoration:
                                    BoxDecoration(border: Border.all(width: 1)),
                                child: Stack(
                                  children: List.generate(
                                      model.getdatas().length, (index) {
                                    return Component(
                                      data: model.getdatas()[index],
                                      onDataChange: (data) {
                                        print(data.toString());
                                        model.updateComponent(data, index);
                                      },
                                    );
                                  }),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          // width: double.infinity,
                          // height: 80,
                          flex: 2,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Container(
                                width: 50.0,
                                color: Colors.red,
                              ),
                              Container(
                                width: 50.0,
                                color: Colors.orange,
                              ),
                              Container(
                                width: 50.0,
                                color: Colors.pink,
                              ),
                              Container(
                                width: 50.0,
                                color: Colors.yellow,
                              ),
                            ],
                          )),
                    ],
                  );
                } else {
                  return Row(
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          // width: 80,
                          // height: double.infinity,
                          child: ListView(
                            children: <Widget>[
                              Container(
                                width: 50.0,
                                height: 100,
                                color: Colors.red,
                              ),
                              Container(
                                width: 50.0,
                                height: 100,
                                color: Colors.orange,
                              ),
                              Container(
                                width: 50.0,
                                height: 100,
                                color: Colors.pink,
                              ),
                              Container(
                                width: 50.0,
                                height: 100,
                                color: Colors.yellow,
                              ),
                            ],
                          )),
                      Expanded(
                        flex: 7,
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.height,
                                height: MediaQuery.of(context).size.height,
                                decoration:
                                    BoxDecoration(border: Border.all(width: 1)),
                                child: Stack(
                                  children: List.generate(
                                      model.getdatas().length, (index) {
                                    //ItemText data = model.getdatas()[index];
                                    return Component(
                                      data: model.getdatas()[index],
                                    );
                                  }),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
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
                          onPressed: () {}),
                      IconButton(
                          icon: Icon(Icons.image_sharp), onPressed: () {}),
                      IconButton(
                          icon: Icon(Icons.video_label), onPressed: () {}),
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
                          icon: Icon(Icons.format_bold_sharp),
                          onPressed: () {}),
                      IconButton(
                          icon: Icon(Icons.format_color_fill),
                          onPressed: () {}),
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
                      ItemText txt = new ItemText.argument(text: "1");
                      print("object--------------------------------");
                      Item t = new Item.argument(
                          id: 1,
                          height: 0,
                          width: 0,
                          name: "s",
                          rotation: 0,
                          scaleX: 0,
                          scaleY: 0,
                          type: "!",
                          x: 0,
                          y: 0);
                      print(txt.toJson());
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
            ));
  }
}
