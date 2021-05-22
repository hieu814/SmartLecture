import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/ui/views/Login/Login.dart';
import 'package:smartlecture/ui/views/Login/SignUp_view.dart';
import 'package:smartlecture/ui/views/Section/Section_view.dart';

import 'models/user.dart';

void main() async {
  await configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static User currentUser;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SectionView(),
    );
  }
}
