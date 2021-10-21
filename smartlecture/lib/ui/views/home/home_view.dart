import 'package:flutter/material.dart';
import 'package:smartlecture/models/lecture_model/LectuteData.dart';
import 'package:smartlecture/ui/modules/Setting.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Section/components/LectureWidget.dart';
import 'package:provider/provider.dart';
import 'package:smartlecture/widgets/layout/side_menu.dart';
import 'home_viewmodel.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    context.read<HomeViewModel>().load();
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[],
      ),
      drawer: SideMenu(),
      body: Consumer<HomeViewModel>(
          builder: (context, model, child) => GridView.builder(
                itemCount: model.items.length ?? 0,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.4),
                ),
                itemBuilder: (context, int index) {
                  LectuteData item = model.items[index];
                  return LectureDelegate(
                    item: item,
                    width: MediaQuery.of(context).size.width,
                    heigth: 300,
                  );
                },
              )),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(Icons.drive_file_move_outlined), label: "Library"),
        ],
        onTap: (int id) async {
          if (id == 0) {
            setState(() {});
            // Navigator.pushNamedAndRemoveUntil(
            //     context, RouteName.homePage, ModalRoute.withName('/'));
          } else if (id == 1) {
            await context
                .read<HomeViewModel>()
                .addNewLecture()
                .then((value) => {
                      Navigator.pushNamed(context, RouteName.sectionPage,
                          arguments: LectuteData(
                              id: "",
                              lecture: value,
                              isSaveToServer: locator<MySetting>().isSync))
                    });
          } else if (id == 2) {
            //final a = await context.read<HomeViewModel>().loadAllLecture();
            Navigator.pushNamed(context, RouteName.Library);
          }
        },
      ),
    );
  }
}
