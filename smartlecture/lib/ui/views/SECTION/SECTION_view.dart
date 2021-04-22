import 'dart:developer';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smartlecture/widgets/DragWidget.dart';
import 'package:smartlecture/widgets/ResizebleWidget.dart';

import 'SECTION_viewmodel.dart';

class SECTION extends StatefulWidget {
  @override
  _SECTIONState createState() => _SECTIONState();
}

class _SECTIONState extends State<SECTION> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  MyStream myStream = MyStream();
  @override
  Widget build(BuildContext context) {
    double sx = 1.0, sy = 2.0;
    Offset ts = new Offset(0.1, 0.2);
    List<Offset> t = [Offset(0.1, 0.2), Offset(10.1, 10.2)];

    return Scaffold(
      appBar: AppBar(
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
              ),
              PopupMenuItem(
                value: 2,
                child: Text("Instagram"),
              ),
              PopupMenuItem(
                value: 1,
                child: Image.network(
                    "https://duhocvietglobal.com/wp-content/uploads/2018/12/dat-nuoc-va-con-nguoi-anh-quoc.jpg"),
              ),
              PopupMenuItem(
                value: 1,
                child: Image.network(
                    "https://duhocvietglobal.com/wp-content/uploads/2018/12/dat-nuoc-va-con-nguoi-anh-quoc.jpg"),
              ),
            ],
          )
        ],
      ),
      body: StreamBuilder<List<Offset>>(
          stream: myStream.counterStream,
          builder: (context, snapshot) => Stack(
                children: List.generate(snapshot.data.length, (index) {
                  return ResizebleWidget(
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Center(
                          child: PopupMenuButton(
                        icon: Icon(Icons.share),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: Image.network(
                                "https://duhocvietglobal.com/wp-content/uploads/2018/12/dat-nuoc-va-con-nguoi-anh-quoc.jpg"),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Text("Instagram"),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: Image.network(
                                "https://duhocvietglobal.com/wp-content/uploads/2018/12/dat-nuoc-va-con-nguoi-anh-quoc.jpg"),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: Image.network(
                                "https://duhocvietglobal.com/wp-content/uploads/2018/12/dat-nuoc-va-con-nguoi-anh-quoc.jpg"),
                          ),
                        ],
                      )),
                    ),
                    onPositionChange: (dx, dy) {
                      print("toa do : ($dx:$dy)");
                    },
                    onSizeChange: (width, height) {
                      print("size : ($width:$height)");
                    },
                  );
                }),
              )),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              Offset t = Offset(10.0, 1.0);
              myStream.addx(t);
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(width: 30),
          FloatingActionButton(
            onPressed: () {
              //t.length
              myStream.decre();
            },
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
