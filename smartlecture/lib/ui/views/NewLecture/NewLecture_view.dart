import 'dart:developer';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smartlecture/widgets/DragWidget.dart';
import 'package:smartlecture/widgets/ResizebleWidget.dart';

import 'NewLecture_viewmodel.dart';

class NewLecture extends StatefulWidget {
  @override
  _NewLectureState createState() => _NewLectureState();
}

class _NewLectureState extends State<NewLecture> {
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
          )
        ],
      ),
      body: StreamBuilder<List<Offset>>(
          stream: myStream.counterStream,
          builder: (context, snapshot) => Stack(
                children: List.generate(snapshot.data.length, (index) {
                  return ResizebleWidget(
                    child: Text(
                      '''I' idea.
  1. Draw size  newdas variables of sizes
  3. Refresh the siewewze.''',
                    ),
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
// DragWidget(
//                       x: snapshot.data[index].dx,
//                       y: snapshot.data[index].dy,
//                       onDraggableCanceled: (Velocity velocity, Offset offset) {
//                         setState(() {
//                           RenderBox renderBox = context.findRenderObject();
//                           //sy=renderBox.globalToLocal(offset).dy
//                           //t.add(renderBox.globalToLocal(offset));
//                           myStream.sua(index, renderBox.globalToLocal(offset));
//                         });
//                       },
//                       child: Container(
//                         decoration: new BoxDecoration(
//                             color: Colors.transparent,
//                             border: Border.all(color: Colors.red)),
//                         child: Image.network(
//                             "https://upload.wikimedia.org/wikipedia/vi/archive/1/1d/20210321120435%21N%C6%A1i_n%C3%A0y_c%C3%B3_anh_-_Single_Cover.jpg"),
//                       ));