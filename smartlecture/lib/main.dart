import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/media/myAudio.dart';
import 'package:smartlecture/models/user_model/user.dart';
import 'package:smartlecture/ui/modules/Setting.dart';
import 'package:smartlecture/ui/modules/UserService.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/ui/modules/router.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Admin/Dashboard_ViewModel.dart';
import 'package:smartlecture/ui/views/Home/home_viewmodel.dart';
import 'package:smartlecture/ui/views/Login/Login_viewmodel.dart';
import 'package:smartlecture/ui/views/Lybrary/Lybrary_viewmodel.dart';
import 'package:smartlecture/ui/views/User/User_viewmodel.dart';
import 'package:smartlecture/ui/views/contribute/Contribute_view.dart';

bool _islog = false;
bool _isAdmin;
User _user;
void main() async {
  await configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  UserService _userService = locator<UserService>();
  locator<MySetting>().load();
  locator<MyAudio>().initAudio();
  await _userService.getUser().then((user) {
    if (user != null) {
      _islog = true;
      _isAdmin = user.role == USER_ROLE_ADMIN;
      print("role: " + user.role);
    } else {
      _islog = false;
    }
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
      ChangeNotifierProvider(
        create: (context) => LoginViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => LibraryViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => UserViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => ContributeViewModel(),
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
