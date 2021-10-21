import 'package:flutter/material.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/lecture_model/LectuteData.dart';
import 'package:smartlecture/models/user_model/user.dart';
import 'package:smartlecture/services/helper.dart';
import 'package:smartlecture/ui/modules/UserService.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Home/home_viewmodel.dart';

import 'package:provider/provider.dart';
import 'package:smartlecture/ui/views/Lybrary/Lybrary_viewmodel.dart';
import 'package:smartlecture/ui/views/User/components/profile_menu.dart';
import 'package:smartlecture/ui/views/User/components/profile_pic.dart';
import 'package:smartlecture/widgets/components/Page.dart';

class MyLectures extends StatefulWidget {
  @override
  State<MyLectures> createState() => _MyLecturesState();
}

class _MyLecturesState extends State<MyLectures> {
  @override
  Widget build(BuildContext context) {
    UserService _userService = locator<UserService>();
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Bài giảng của bạn',
                    style: TextStyle(
                        color: Color(COLOR_PRIMARY),
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0),
                  )),
              SizedBox(height: 20),
              Container(
                height: 300,
                child: Consumer<LibraryViewModel>(
                    builder: (context, model, child) => ListView.builder(
                          itemCount: model.items.length ?? 0,
                          shrinkWrap: true,
                          itemBuilder: (context, int index) {
                            LectuteData item = model.items[index];
                            return Card(
                              child: ListTile(
                                leading: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth: 44,
                                    minHeight: 44,
                                    maxWidth: 64,
                                    maxHeight: 64,
                                  ),
                                  child: IPage(
                                    width: 800,
                                    height: 600,
                                    page: item.lecture.section[0].page[0],
                                    isPresentation: true,
                                  ),
                                ),
                                title: GestureDetector(
                                  child: Text(item.lecture.title),
                                  onTap: () async {
                                    Navigator.pushNamed(
                                        context, RouteName.presentation,
                                        arguments: item.lecture);
                                  },
                                ),
                                trailing: GestureDetector(
                                  child: Icon(Icons.download),
                                  onTap: () async {
                                    model.download(context, index);
                                  },
                                ),
                              ),
                            );
                          },
                        )),
              ),
            ],
          ),
        ));
  }
}
