import 'package:flutter/material.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/ui/views/Login/Test.dart';
import 'package:smartlecture/ui/views/Section/Section_view.dart';

void main() async {
  await configureDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SECTION(),
    );
  }
}
