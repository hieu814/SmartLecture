import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/ui/modules/UserService.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/ui/modules/router.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Admin/Dashboard_ViewModel.dart';
import 'package:smartlecture/ui/views/Home/home_viewmodel.dart';

bool _islog = false;
bool _isAdmin;
void main() async {
  await configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  UserService _userService = locator<UserService>();
  _islog = await _userService.isLogged();
  await _userService.getUser().then((value) {
    _isAdmin = value.role == USER_ROLE_ADMIN;
  });
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MenuViewModel>(
        create: (context) => MenuViewModel(),
      ),
      ChangeNotifierProvider<HomeViewModel>(
        create: (context) => HomeViewModel(),
      ),
      ChangeNotifierProvider<AdminViewModel>(
        create: (context) => AdminViewModel(),
      ),
    ],
    child: MyApp(),
  ));
}

//AdminViewModel
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: _islog
          ? _isAdmin
              ? RouteName.adminPage
              : RouteName.homePage
          : RouteName.loginPage,
      onGenerateRoute: MyRouter.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}
