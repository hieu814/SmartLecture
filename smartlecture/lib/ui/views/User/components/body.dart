import 'package:flutter/material.dart';
import 'package:smartlecture/models/user_model/user.dart';
import 'package:smartlecture/services/helper.dart';
import 'package:smartlecture/ui/modules/UserService.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Home/home_viewmodel.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    UserService _userService = locator<UserService>();
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          buildName(_userService.currentUser),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Sửa thông tin",
            icon: "assets/icons/User Icon.svg",
            press: () {
              Navigator.pushNamed(context, RouteName.editUser).then((value) {
                setState(() {});
              });
            },
          ),
          ProfileMenu(
            text: "Thông báo",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Cài đặt",
            icon: "assets/icons/Settings.svg",
            press: () {
              Navigator.pushNamed(context, RouteName.setting);
            },
          ),
          ProfileMenu(
            text: "Đổi mật khẩu",
            icon: "", //"assets/icons/Question mark.svg",
            iconWidget: Icon(Icons.password_sharp),
            press: () {
              Navigator.pushNamed(context, RouteName.changePass);
            },
          ),
          ProfileMenu(
            text: "Đăng xuất",
            icon: "assets/icons/Log out.svg",
            press: () async {
              showProgress(context, 'Đang đăng xuất...', false);
              _userService.logout();
              hideProgress();
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteName.loginPage, ModalRoute.withName('/'));
            },
          ),
        ],
      ),
    );
  }

  Widget buildName(User user) {
    print("-------- buildName");
    return Column(
      children: [
        Text(
          user.fullName(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
  }
}
