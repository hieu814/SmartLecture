import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/media/myAudio.dart';
import 'package:smartlecture/models/lecture_model/Lecture.dart';
import 'package:smartlecture/models/lecture_model/LectuteData.dart';
import 'package:smartlecture/models/common/SectionIndex..dart';
import 'package:smartlecture/ui/modules/Navi.dart';
import 'package:smartlecture/ui/modules/function.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/ui/views/presentation/Presentation_viewModel.dart';
import 'package:smartlecture/widgets/components/ListSection.dart';
import 'package:smartlecture/widgets/components/Page.dart';
import 'package:smartlecture/widgets/popup/popup.dart';
import 'package:smartlecture/models/lecture_model/Page.dart' as p;
import 'package:smartlecture/constants.dart' as cst;
import 'package:provider/provider.dart';

class PresentationView extends StatefulWidget {
  final Lecture data;
  PresentationView(this.data);
  @override
  _PresentationViewState createState() => _PresentationViewState();
}

class _PresentationViewState extends State<PresentationView> {
  SectionIndex index;
  AudioPlayer audioPlayer = AudioPlayer();
  p.Page page;
  bool isInit = false;
  play() async {
    int result = await audioPlayer.play(
        "https://aredir.nixcdn.com/NhacCuaTui220/MyLady-Yanbi-MrT-Bueno-TMT_3znvk.mp3?st=sQRIMCC8TcAiq7I0deCB6Q&e=1624533949");
    if (result == 1) {
      // success
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PresentationViewModel(init: widget.data),
        ),
      ],
      builder: (context, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: OrientationBuilder(
            builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                return Consumer<PresentationViewModel>(
                    builder: (context, model, child) => Stack(
                          children: <Widget>[
                            Center(
                                child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 6 * width / 8,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.red)),
                              child: IPage(
                                width: MediaQuery.of(context).size.height,
                                height: 6 * width / 8,
                                isPresentation: true,
                                curentItem: model.currentIndex.currentItemIndex,
                                page: model
                                    .lecture
                                    .section[
                                        model.currentIndex.currentSectionIndex]
                                    .page[model.currentIndex.currentPageIndex],
                              ),
                            )),
                            Positioned(
                              top: 30,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back),
                              ),
                            ),
                            Positioned(
                                top: MediaQuery.of(context).size.height - 120,
                                child: SizedBox(
                                    height: 60.0,
                                    width: 60.0,
                                    child: FittedBox(
                                      child: FloatingActionButton(
                                        heroTag: "btn4",
                                        child: Icon(Icons.arrow_back_ios),
                                        onPressed: () {
                                          model.decreasePageIndex();
                                        },
                                      ),
                                    ))),
                            Positioned(
                                top: MediaQuery.of(context).size.height - 120,
                                left: MediaQuery.of(context).size.width - 60,
                                child: SizedBox(
                                    height: 60.0,
                                    width: 60.0,
                                    child: FittedBox(
                                      child: FloatingActionButton(
                                        heroTag: "btn3",
                                        child: Icon(Icons.arrow_forward_ios),
                                        onPressed: () {
                                          model.increasePageIndex();
                                        },
                                      ),
                                    ))),
                          ],
                        ));
              } else {
                return Consumer<PresentationViewModel>(
                    builder: (context, model, child) => Stack(
                          children: <Widget>[
                            Center(
                                child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 6 * width / 8,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.red)),
                              child: IPage(
                                width: MediaQuery.of(context).size.width,
                                height: 6 * width / 8,
                                isPresentation: true,
                                curentItem: model.currentIndex.currentItemIndex,
                                page: model
                                    .lecture
                                    .section[
                                        model.currentIndex.currentSectionIndex]
                                    .page[model.currentIndex.currentPageIndex],
                              ),
                            )),
                            Positioned(
                                top: MediaQuery.of(context).size.height / 2,
                                child: SizedBox(
                                    height: 60.0,
                                    width: 60.0,
                                    child: FittedBox(
                                      child: FloatingActionButton(
                                        heroTag: "btn2",
                                        child: Icon(Icons.arrow_back_ios),
                                        onPressed: () {
                                          model.decreasePageIndex();
                                        },
                                      ),
                                    ))),
                            Positioned(
                                top: MediaQuery.of(context).size.height / 2,
                                left: MediaQuery.of(context).size.width - 60,
                                child: SizedBox(
                                    height: 60.0,
                                    width: 60.0,
                                    child: FittedBox(
                                      child: FloatingActionButton(
                                        heroTag: "btn1",
                                        child: Icon(Icons.arrow_forward_ios),
                                        onPressed: () {
                                          model.increasePageIndex();
                                        },
                                      ),
                                    ))),
                            Positioned(
                              top: 30,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back),
                              ),
                            ),
                          ],
                        ));
              }
            },
          ),
        );
      },
    );
  }
}
