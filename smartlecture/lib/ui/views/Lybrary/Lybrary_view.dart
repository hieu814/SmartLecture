import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:smartlecture/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartlecture/main.dart';
import 'package:smartlecture/models/lecture_model/LectuteData.dart';
import 'package:smartlecture/models/user_model/user.dart';
import 'package:smartlecture/services/authenticate.dart';
import 'package:smartlecture/services/helper.dart';
import 'package:smartlecture/ui/modules/UserService.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Home/Home_view.dart';
import 'package:smartlecture/ui/views/Home/home_viewmodel.dart';
import 'package:smartlecture/ui/views/Lybrary/Lybrary_viewmodel.dart';
import 'package:smartlecture/ui/views/Lybrary/component/LibraryTree.dart';
import 'package:smartlecture/ui/views/User/components/profile_menu.dart';
import 'package:smartlecture/ui/views/contribute/Contribute_VierwModel.dart';
import 'package:smartlecture/widgets/components/Page.dart';
import 'package:smartlecture/widgets/popup/popup.dart';

File _image;

class LibraryScreen extends StatefulWidget {
  @override
  State createState() => _LibraryState();
}

ImagePicker sl;

class _LibraryState extends State<LibraryScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  TextEditingController _passwordController = new TextEditingController();
  GlobalKey<FormState> _key = new GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;
  String oldPassword, password, confirmPassword;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      retrieveLostData();
    }
    context.read<LibraryViewModel>().load();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: new Container(
          margin: new EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
          child: new Form(
            key: _key,
            autovalidateMode: _validate,
            child: formUI(),
          ),
        ),
      ),
    );
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _imagePicker.getLostData();
    if (response == null) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image = File(response.file.path);
      });
    }
  }

  Widget formUI() {
    return SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          new Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Bài giảng của bạn',
                style: TextStyle(
                    color: Color(COLOR_PRIMARY),
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0),
              )),
          ProfileMenu(
            text: "Xem tất cả",
            icon: "assets/icons/Documents.svg",
            press: () {
              Navigator.pushNamed(context, RouteName.myLectures);
            },
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Thư viện bài giảng',
                style: TextStyle(
                    color: Color(COLOR_PRIMARY),
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0),
              )),
          Container(
            padding: EdgeInsets.all(20),
            height: 500,
            child: LibraryTreeView(
              type: TypeFolder.FOLDER_LECTURE,
              isComponent: true,
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _image = null;
    super.dispose();
  }
}
