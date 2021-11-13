import 'package:get_it/get_it.dart';
import 'package:smartlecture/media/myAudio.dart';
import 'package:smartlecture/models/user_model/user.dart';
import 'package:smartlecture/ui/modules/Navi.dart';
import 'package:smartlecture/ui/modules/Scale.dart';
import 'package:smartlecture/ui/modules/Setting.dart';
import 'package:smartlecture/ui/modules/UserService.dart';

final GetIt locator = GetIt.instance;
double globalScaleWidth;
double globalScaleHeight;
Future<void> configureDependencies() async {
  // getIt.registerSingleton<ScalePage>(ScalePage());
  locator.registerSingleton<MyGlobals>(MyGlobals());
  locator.registerSingleton<User>(User());
  locator.registerLazySingleton(() => new UserService());
  locator.registerLazySingleton(() => new MySetting());
  locator.registerLazySingleton(() => new MyAudio());
  locator.registerFactoryParam<ScalePage, double, double>(
      (width, height) => ScalePage(width: width, height: height));
  // getIt.registerFactory<MyGlobals>(() => MyGlobals());
}
