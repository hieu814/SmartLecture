import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/ui/views/User/User_viewmodel.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: buildSettingsList(),
    );
  }

  Widget buildSettingsList() {
    context.read<UserViewModel>().load();
    return Consumer<UserViewModel>(builder: (context, model, child) {
      return SettingsList(
        sections: [
          SettingsSection(
            title: 'Common',
            tiles: [
              SettingsTile(
                title: 'Language',
                subtitle: 'English',
                leading: Icon(Icons.language),
                onPressed: (context) {
                  Navigator.of(context).push(MaterialPageRoute(
                      // builder: (_) => LanguagesScreen(),
                      ));
                },
              ),
              // CustomTile(
              //   child: Container(
              //     color: Color(0xFFEFEFF4),
              //     padding: EdgeInsetsDirectional.only(
              //       start: 14,
              //       top: 12,
              //       bottom: 30,
              //       end: 14,
              //     ),
              //     child: Text(
              //       'You can setup the language you want',
              //       style: TextStyle(
              //         color: Colors.grey.shade700,
              //         fontWeight: FontWeight.w400,
              //         fontSize: 13.5,
              //         letterSpacing: -0.5,
              //       ),
              //     ),
              //   ),
              // ),
              SettingsTile.switchTile(
                title: 'Đồng bộ dữ liệu',
                //enabled: notificationsEnabled,

                leading: Icon(Icons.cloud_queue),
                switchValue: model.isSync ?? false,
                onToggle: (value) {
                  model.saveOption(value, syncSetting);
                },
              ),
            ],
          ),
          SettingsSection(
            title: 'Tài khoản',
            tiles: [
              // SettingsTile(title: 'Phone number', leading: Icon(Icons.phone)),
              // SettingsTile(title: 'Email', leading: Icon(Icons.email)),
              SettingsTile(
                  title: 'Đăng xuất', leading: Icon(Icons.exit_to_app)),
            ],
          ),
          SettingsSection(
            title: 'Bảo mật',
            tiles: [
              SettingsTile.switchTile(
                title: 'Thông báo',
                //enabled: notificationsEnabled,
                leading: Icon(Icons.notifications_active),
                switchValue: model.isNoti ?? false,
                onToggle: (value) {
                  model.saveOption(value, notificationsSetting);
                },
              ),
            ],
          ),
        ],
      );
    });
  }
}
