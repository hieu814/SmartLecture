import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/models/lecture_model/Lecture.dart';
import 'package:smartlecture/models/lecture_model/LectuteData.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Admin/components/LectureDetail.dart';
import 'package:smartlecture/ui/views/Home/home_viewmodel.dart';
import 'package:smartlecture/widgets/components/Page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartlecture/constants.dart';
import 'package:smartlecture/models/user_model/user.dart';
import 'package:smartlecture/services/helper.dart';
import 'package:smartlecture/ui/modules/function.dart';
import 'package:smartlecture/widgets/popup/popup.dart';

import '../../Dashboard_ViewModel.dart';

class LectureDataDelegate extends StatelessWidget {
  final DocumentSnapshot doc;
  const LectureDataDelegate({Key key, this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Lecture item;
    try {
      item = Lecture.fromJson(doc.data());
    } on Exception catch (e) {
      context.read<AdminViewModel>().deleteItem(doc.id);
    }
    print("delegate odcstring" + doc.data().toString());
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LectureDetail(
                              id: doc.id,
                              lecture: item,
                            )),
                  );
                },
                child: Container(
                  width: 100,
                  height: 100,
                  child: IPage(
                    width: 800,
                    height: 600,
                    page: item.section[0].page[0],
                    isPresentation: true,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 2,
                ),
                Text(
                  "Author: " + item.authorId,
                  maxLines: 1,
                )
              ],
            ),
          ),
          Container(
            height: 100,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Wrap(
                spacing: 2,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(Icons.edit),
                    onTap: () async {
                      Navigator.pushNamed(context, RouteName.sectionPage,
                          arguments: LectuteData(id: doc.id, lecture: item));
                    },
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.delete_rounded,
                      color: Colors.red,
                    ),
                    onTap: () async {
                      popupYesNo(context).then((value) {
                        if (value) {
                          showProgress(context, 'Đang xóa...', false);
                          context
                              .read<AdminViewModel>()
                              .deleteItem(doc.id)
                              .then((value) {
                            hideProgress();
                            showInSnackBar(context, "đã xóa");
                          });
                        }
                      });
                    },
                  ), // icon-1
                  // icon-2
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class asdasd extends StatelessWidget {
  final DocumentSnapshot doc;
  const asdasd({Key key, this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Lecture item = Lecture.fromJson(doc.data());
    return Card(
      child: ListTile(
        leading: Wrap(
          children: [
            Container(
                // child: IPage(
                //   width: 800,
                //   height: 600,
                //   page: item.section[0].page[0],
                //   isPresentation: true,
                // ),
                )
          ],
        ),
        title: Text("item.title"),
        subtitle: Text("item.authorId"),
      ),
    );
  }
}
