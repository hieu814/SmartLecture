import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/user_model/user.dart';
import 'package:smartlecture/services/authenticate.dart';
import 'package:smartlecture/services/helper.dart';
import 'package:smartlecture/ui/modules/Setting.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Home/Home_view.dart';
import 'package:stacked/stacked.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class UserViewModel extends ChangeNotifier {
  bool _settingIsSync;
  get isSync => _settingIsSync;
  bool _settingnoti;
  get isNoti => _settingnoti;
  Future<Null> saveOption(bool isSelected, String settingName) async {
    await locator<MySetting>().saveOption(isSelected, settingName).then((_) {
      if (settingName == syncSetting)
        _settingIsSync = locator<MySetting>().isSync;
      else if (settingName == notificationsSetting)
        _settingnoti = locator<MySetting>().isNoti;
      notifyListeners();
    });
  }

  load() async {
    await locator<MySetting>().load();
    _settingIsSync = await locator<MySetting>().getOption(syncSetting);
  }
}
