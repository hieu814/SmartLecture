import 'package:flutter/material.dart';
import 'package:smartlecture/models/lecture_model/LectuteData.dart';
import 'package:smartlecture/services/helper.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Section/components/LectureWidget.dart';
import 'package:smartlecture/widgets/components/Page.dart';
import 'package:provider/provider.dart';
import 'package:smartlecture/widgets/layout/side_menu.dart';
import 'home_viewmodel.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String url =
      "data:image/jpeg;base64,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";
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
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: "Email"),
        ],
        onTap: (int id) {
          if (id == 0) {
            Navigator.pushNamed(context, RouteName.homePage);
          } else if (id == 1) {
            Navigator.pushNamed(context, RouteName.sectionPage);
          } else if (id == 2) {
            Navigator.pushNamed(context, RouteName.adminPage);
          }
        },
      ),
    );
  }
}
