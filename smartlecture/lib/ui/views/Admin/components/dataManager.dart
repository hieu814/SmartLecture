import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartlecture/ui/views/Admin/Dashboard_ViewModel.dart';
import 'package:smartlecture/ui/views/Admin/components/recent_files.dart';
import 'package:smartlecture/ui/views/Admin/components/storage_details.dart';
import 'package:smartlecture/widgets/components/AudioPlay.dart';
import 'package:smartlecture/widgets/layout/header.dart';
import 'package:smartlecture/widgets/layout/side_menu.dart';
import 'package:smartlecture/widgets/manage/MyForm.dart';
import '../../../../constants.dart';
import '../../../../responsive.dart';
import 'my_fields.dart';

class DashboardViewDataDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: DashboardData(),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("----------------DashboardData build");
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(
              isNotMain: true,
            ),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "My Filess",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          ElevatedButton.icon(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding * 1.5,
                                vertical: defaultPadding /
                                    (Responsive.isMobile(context) ? 2 : 1),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) => PlayerControls()),
                              );
                            },
                            icon: Icon(Icons.add),
                            label: Text("Add New"),
                          ),
                        ],
                      ),
                      SizedBox(height: defaultPadding),
                      RecentFiles(
                        typeData: context.read<AdminViewModel>().collection,
                      ),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StarageDetails(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}