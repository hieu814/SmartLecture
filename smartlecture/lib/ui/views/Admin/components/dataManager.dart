import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:smartlecture/models/lecture_model/LectuteData.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Admin/Dashboard_ViewModel.dart';
import 'package:smartlecture/ui/views/Admin/components/ContributeDetailScreen.dart';
import 'package:smartlecture/ui/views/Admin/components/Filter.dart';
import 'package:smartlecture/ui/views/Admin/components/recent_files.dart';
import 'package:smartlecture/ui/views/Admin/components/storage_details.dart';
import 'package:smartlecture/ui/views/Home/home_viewmodel.dart';
import 'package:smartlecture/ui/views/Lybrary/Lybrary_viewmodel.dart';
import 'package:smartlecture/ui/views/Lybrary/component/ListLecture.dart';
import 'package:smartlecture/widgets/components/AudioPlay.dart';
import 'package:smartlecture/widgets/layout/header.dart';
import 'package:smartlecture/widgets/layout/side_menu.dart';
import 'package:smartlecture/widgets/manage/MyForm.dart';
import '../../../../constants.dart';
import '../../../../responsive.dart';
import 'my_fields.dart';

class DashboardViewDataDetail extends StatefulWidget {
  @override
  State<DashboardViewDataDetail> createState() =>
      _DashboardViewDataDetailState();
}

class _DashboardViewDataDetailState extends State<DashboardViewDataDetail> {
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

class DashboardData extends StatefulWidget {
  @override
  State<DashboardData> createState() => _DashboardDataState();
}

class _DashboardDataState extends State<DashboardData> {
  String paths = "";
  bool status = true;
  @override
  void initState() {
    context.read<AdminViewModel>().setFilterImage("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("----------------DashboardData build" +
        context.read<AdminViewModel>().collection);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(
              isNotMain: true,
            ),
            SizedBox(height: defaultPadding),
            Consumer<AdminViewModel>(builder: (context, model, child) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (model.collection == IMAGES ||
                                model.collection == CONTRIBUTE)
                              Expanded(
                                child: SizedBox(
                                    height: 50,
                                    child: FilterWidget(
                                      returnData: (p) async {
                                        path = p;
                                        if (context
                                                .read<AdminViewModel>()
                                                .collection ==
                                            IMAGES) {
                                          if (!await rebuild()) return;
                                          Future.delayed(Duration.zero,
                                              () async {
                                            await context
                                                .read<AdminViewModel>()
                                                .setFilterImage(path);
                                          });

                                          //setState(() {});
                                        } else if (model.collection ==
                                            CONTRIBUTE) {
                                          context
                                              .read<AdminViewModel>()
                                              .setFilterContribute(
                                                  path: path, status: status);
                                        }
                                      },
                                    )),
                              ),
                            if (model.collection == USERS)
                              Text(
                                "Danh sách",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            if (model.collection == LECTUTES)
                              ElevatedButton.icon(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding * 1.5,
                                    vertical: defaultPadding /
                                        (Responsive.isMobile(context) ? 2 : 1),
                                  ),
                                ),
                                onPressed: () async {
                                  if (model.collection == LECTUTES)
                                    await context
                                        .read<HomeViewModel>()
                                        .addNewLecture()
                                        .then((value) => {
                                              Navigator.pushNamed(context,
                                                  RouteName.sectionPage,
                                                  arguments: LectuteData(
                                                      isSaveToServer: true,
                                                      id: "",
                                                      lecture: value))
                                            });
                                },
                                icon: Icon(Icons.add),
                                label: Text("Add New"),
                              ),
                          ],
                        ),
                        if (model.collection == CONTRIBUTE)
                          Row(
                            children: [
                              ElevatedButton(
                                style: TextButton.styleFrom(),
                                onPressed: () {
                                  context
                                      .read<AdminViewModel>()
                                      .setFilterContribute(path: path);
                                },
                                child: Text("Tất cả"),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              ElevatedButton(
                                style: TextButton.styleFrom(),
                                onPressed: () {
                                  status = false;
                                  context
                                      .read<AdminViewModel>()
                                      .setFilterContribute(
                                          path: path, status: status);
                                },
                                child: Text("Chưa duyệt"),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              ElevatedButton(
                                style: TextButton.styleFrom(),
                                onPressed: () {
                                  status = true;
                                  context
                                      .read<AdminViewModel>()
                                      .setFilterContribute(
                                          path: path, status: status);
                                },
                                child: Text("Đã duyệt"),
                              )
                            ],
                          ),
                        SizedBox(height: defaultPadding),
                        RecentFiles(
                          typeData: model.collection,
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
              );
            })
          ],
        ),
      ),
    );
  }

  Future<bool> rebuild() async {
    if (!mounted) return false;

    // if there's a current frame,
    if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.idle) {
      // wait for the end of that frame.
      await SchedulerBinding.instance.endOfFrame;
      if (!mounted) return false;
    }

    setState(() {});
    return true;
  }
}
