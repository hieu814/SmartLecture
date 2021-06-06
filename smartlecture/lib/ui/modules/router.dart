import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/models/Lecture.dart';
import 'package:smartlecture/models/LectuteData.dart';
import 'package:smartlecture/ui/modules/UserService.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Home/home_view.dart';
import 'package:smartlecture/ui/views/Login/Login.dart';
import 'package:smartlecture/ui/views/Login/SignUp_view.dart';
import 'package:smartlecture/ui/views/Section/Section_view.dart';

class MyRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.loginPage:
        return MaterialPageRoute(builder: (context) => LoginView());
      case RouteName.homePage:
        return MaterialPageRoute(builder: (context) => HomeView());
      case RouteName.sectionPage:
        var data = settings.arguments as LectuteData;
        return MaterialPageRoute(builder: (context) => SectionView(data));
      case RouteName.signUpPage:
        return MaterialPageRoute(builder: (context) => SignUpView());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
