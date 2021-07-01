import 'package:flutter/material.dart';
import 'package:smartlecture/models/lecture_model/LectuteData.dart';

import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Admin/Dashboard_View.dart';
import 'package:smartlecture/ui/views/Admin/components/dataManager.dart';
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
      case RouteName.adminPage:
        return MaterialPageRoute(builder: (context) => DashboardView());
      case RouteName.dataDetailPage:
        return MaterialPageRoute(
            builder: (context) => DashboardViewDataDetail());
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
