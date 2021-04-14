import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartlecture/widgets/DragWidget.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Offset ts = new Offset(0.1, 0.2);
    List<Offset> t = [
      Offset(0.1, 0.2),
      Offset(19.1, 19.2),
      Offset(29.1, 29.2),
      Offset(39.1, 49.2)
    ];
    List<int> text = [1, 2, 3, 4];
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
      body: Stack(
        children: List.generate(
            text.length,
            (index) => Positioned(
                  width: 100,
                  height: 240,
                  left: 1,
                  top: 2,
                  child: Draggable(
                    child: Container(
                      color: Colors.red,
                    ),
                    feedback: Container(
                      decoration: new BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.grey)),
                      width: 1,
                      height: 200,
                    ),
                    onDraggableCanceled: (Velocity velocity, Offset offset) {
                      setState(() {
                        RenderBox renderBox = context.findRenderObject();
                        // position = renderBox.globalToLocal(offset);
                        // widget.y = position.dx;
                      });
                    },
                  ),
                )),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => {},
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(width: 30),
          FloatingActionButton(
            onPressed: () {},
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
