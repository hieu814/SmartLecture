import 'package:get_it/get_it.dart';
import 'package:smartlecture/models/user.dart';
import 'package:smartlecture/ui/modules/Navi.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerSingleton<MyGlobals>(MyGlobals());
  getIt.registerSingleton<User>(User());
  // getIt.registerFactory<MyGlobals>(() => MyGlobals());
}
