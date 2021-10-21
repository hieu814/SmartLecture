import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartlecture/constants.dart';

class MySetting {
  bool _settingIsSync;
  get isSync => _settingIsSync;
  bool _settingnoti;
  get isNoti => _settingnoti;
  Future<Null> saveOption(bool isSelected, String settingName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(settingName, isSelected);
    if (settingName == syncSetting)
      _settingIsSync = await getOption(syncSetting);
    else if (settingName == notificationsSetting)
      _settingnoti = await getOption(notificationsSetting);
    print("");
    print("_settingIsSync: $_settingIsSync");
    print("");
  }

  Future<bool> getOption(String settingName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(settingName);
  }

  load() async {
    _settingIsSync = await getOption(syncSetting);
  }
}
