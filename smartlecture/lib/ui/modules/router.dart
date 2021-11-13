import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/lecture_model/Lecture.dart';
import 'package:smartlecture/models/lecture_model/LectuteData.dart';

import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Admin/Dashboard_View.dart';
import 'package:smartlecture/ui/views/Admin/components/dataManager.dart';
import 'package:smartlecture/ui/views/Admin/components/delegate/ImageManager.dart';
import 'package:smartlecture/ui/views/Home/home_view.dart';
import 'package:smartlecture/ui/views/Login/Login.dart';
import 'package:smartlecture/ui/views/Login/SignUp_view.dart';
import 'package:smartlecture/ui/views/Lybrary/Lybrary_view.dart';
import 'package:smartlecture/ui/views/Lybrary/component/LibraryTree.dart';
import 'package:smartlecture/ui/views/Lybrary/component/ListLecture.dart';
import 'package:smartlecture/ui/views/Lybrary/component/MyLectures.dart';
import 'package:smartlecture/ui/views/Presentation/Presentation_view.dart';
import 'package:smartlecture/ui/views/Section/Section_view.dart';
import 'package:smartlecture/ui/views/User/SettingScreen.dart';
import 'package:smartlecture/ui/views/User/components/ChangePass_view.dart';
import 'package:smartlecture/ui/views/User/components/EditUser.dart';
import 'package:smartlecture/ui/views/User/profile_screen.dart';
import 'package:smartlecture/ui/views/contribute/Contribute_VierwModel.dart';

class MyRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.loginPage:
        return MaterialPageRoute(builder: (context) => LoginView());
      case RouteName.libraryTree:
        var data = settings.arguments as TypeFolder;
        return MaterialPageRoute(
            builder: (context) => LibraryTreeView(
                  type: data,
                ));
      case RouteName.homePage:
        return MaterialPageRoute(builder: (context) => HomeView());
      case RouteName.sectionPage:
        var data = settings.arguments as LectuteData;
        return MaterialPageRoute(builder: (context) => SectionView(data));
      case RouteName.signUpPage:
        return MaterialPageRoute(builder: (context) => SignUpView());
      case RouteName.adminPage:
        return MaterialPageRoute(builder: (context) => DashboardView());
      case RouteName.userProfile:
        return MaterialPageRoute(builder: (context) => ProfileScreen());
      case RouteName.changePass:
        return MaterialPageRoute(builder: (context) => ChangePasswordScreen());
      case RouteName.Library:
        return MaterialPageRoute(builder: (context) => LibraryScreen());
      case RouteName.myLectures:
        return MaterialPageRoute(builder: (context) => My_Lectures());
      case RouteName.listLectures:
        return MaterialPageRoute(builder: (context) => ListLectures());
      case RouteName.editUser:
        return MaterialPageRoute(builder: (context) => EditUserView());
      case RouteName.presentation:
        var data = settings.arguments as Lecture;
        return MaterialPageRoute(builder: (context) => PresentationView(data));
      case RouteName.dataDetailPage:
        return MaterialPageRoute(
            builder: (context) => DashboardViewDataDetail());
      case RouteName.setting:
        return MaterialPageRoute(builder: (context) => SettingsScreen());
      case RouteName.contribute:
        return MaterialPageRoute(builder: (context) => ContributeScreen());
      case RouteName.imageManager:
        return MaterialPageRoute(builder: (context) => ImageManager());
      case '/':
        // don't generate route on start-up
        return null;
      default:
        //exit(0);
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
