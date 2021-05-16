import 'package:flutter/material.dart';
import 'package:smartlecture/ui/views/SECTION/Section_view.dart';

class Router {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'LoginPage':
        return MaterialPageRoute(builder: (context) => SECTION());
      case 'DonePage':
        return MaterialPageRoute(builder: (context) => SECTION());
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
