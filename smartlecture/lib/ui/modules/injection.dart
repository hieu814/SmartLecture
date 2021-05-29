import 'package:get_it/get_it.dart';
import 'package:smartlecture/models/user.dart';
import 'package:smartlecture/ui/modules/Navi.dart';
import 'package:smartlecture/ui/modules/Scale.dart';

final getIt = GetIt.instance;
double globalScaleWidth;
double globalScaleHeight;
Future<void> configureDependencies() async {
  // getIt.registerSingleton<ScalePage>(ScalePage());
  getIt.registerSingleton<MyGlobals>(MyGlobals());
  getIt.registerSingleton<User>(User());
  getIt.registerFactoryParam<ScalePage, double, double>(
      (width, height) => ScalePage(width: width, height: height));
  // getIt.registerFactory<MyGlobals>(() => MyGlobals());
}
