import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/ui/modules/UserService.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/ui/modules/router.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Home/home_view.dart';
import 'package:smartlecture/ui/views/Login/SignUp_view.dart';
import 'package:smartlecture/ui/views/Login/Login.dart';

import 'models/user.dart';

void main() async {
  await configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  UserService _userService = locator<UserService>();
  bool islog = await _userService.isLogged();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    initialRoute: islog ? RouteName.homePage : RouteName.loginPage,
    onGenerateRoute: MyRouter.generateRoute,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: RouteName.loginPage,
      onGenerateRoute: MyRouter.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
