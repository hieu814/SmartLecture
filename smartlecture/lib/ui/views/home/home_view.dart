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
            (index) => DragWidget(
                  text1: "12212",
                  text2: "ddsda",
                  child: Container(
                    width: 100,
                    height: 200,
                    color: Colors.blue,
                    child: Center(
                      child: Text("sddssdsd"),
                    ),
                  ),
                )),
      ),
    );
  }
}
