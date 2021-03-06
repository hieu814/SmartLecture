import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartlecture/models/lecture_model/Lecture.dart';
import 'package:smartlecture/models/lecture_model/LectuteData.dart';
import 'package:smartlecture/services/helper.dart';
import 'package:smartlecture/ui/modules/UserService.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:xml2json/xml2json.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserService _userService = locator<UserService>();
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(_userService.currentUser.firstName ?? ""),
            accountEmail: Text(_userService.currentUser.email ?? ""),
            onDetailsPressed: () {},
            otherAccountsPictures: [
              IconButton(
                  onPressed: () async {
                    await _userService.logout();
                    Navigator.pushNamedAndRemoveUntil(
                        context, RouteName.loginPage, ModalRoute.withName('/'));
                  },
                  icon: const Icon(Icons.logout_outlined))
            ],
            currentAccountPicture: CircleAvatar(
              child: displayCircleImage(
                  _userService.currentUser.profilePictureURL, 125, false),
            ),
          ),
          // DrawerListTile(
          //   title: "Dashboard",
          //   svgSrc: "assets/icons/menu_dashbord.svg",
          //   press: () {
          //     Navigator.pushNamed(context, RouteName.adminPage);
          //   },
          // ),
          // DrawerListTile(
          //   title: "User",
          //   svgSrc: "assets/icons/menu_tran.svg",
          //   press: () {
          //     Navigator.pushNamed(context, RouteName.userProfile);
          //   },
          // ),
          DrawerListTile(
            title: "????ng g??p b??i gi???ng",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              Navigator.pushNamed(context, RouteName.contribute);
            },
          ),
          DrawerListTile(
            title: "M??? b??i gi???ng",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () async {
              String data = await readLecture();
              final myTransformer = Xml2Json();
              // Parse a simple XML string
              myTransformer.parse(data);
              // Transform to JSON using Badgerfish
              var _json = myTransformer.toGData();
              print('Json');
              print('');
              print(_json);
              print('');
              try {
                Lecture a = Lecture.fromJson(json.decode(_json)["LECTURE"]);
                Navigator.pushNamed(context, RouteName.sectionPage,
                    arguments: LectuteData(id: "", lecture: a));
                print("-------- fromjson ok: ");
              } catch (e) {
                print("fromjson err: " + e.toString());
              }

              FirebaseFirestore firestore = FirebaseFirestore.instance;
              await firestore.collection("test").add({
                "data": toXML(Lecture.fromJson(json.decode(_json)["LECTURE"]))
              });

              // print('');
              // print('data ${a.title}');
              // Navigator.pushNamed(context, RouteName.sectionPage,
              //     arguments: LectuteData(id: "", lecture: a));
            },
          ),
          DrawerListTile(
            title: "Th?? vi???n",
            svgSrc: "assets/icons/menu_store.svg",
            press: () async {
              final value =
                  await Navigator.pushNamed(context, RouteName.libraryTree);
              print("------------------path : $value");
            },
          ),
          DrawerListTile(
            title: "Th??ng b??o",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "T??i kho???n",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              Navigator.pushNamed(context, RouteName.userProfile);
            },
          ),
          DrawerListTile(
            title: "C??i ?????t",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              Navigator.pushNamed(context, RouteName.setting);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key key,
    // For selecting those three line once press "Command+D"
    this.title,
    this.svgSrc,
    this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.black,
        height: 16,
      ),
      title: Text(
        title,
        //style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
