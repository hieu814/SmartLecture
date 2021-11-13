import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartlecture/models/admin_model/ImageStore.dart';
import 'package:smartlecture/models/lecture_model/Lecture.dart';
import 'package:smartlecture/models/lecture_model/LectuteData.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Admin/components/DetailImage.dart';
import 'package:smartlecture/ui/views/Admin/components/LectureDetail.dart';
import 'package:smartlecture/ui/views/Home/home_viewmodel.dart';
import 'package:smartlecture/ui/views/Lybrary/Lybrary_viewmodel.dart';
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

class ImageDeledate extends StatefulWidget {
  final DocumentSnapshot doc;
  const ImageDeledate({Key key, this.doc}) : super(key: key);

  @override
  State<ImageDeledate> createState() => _ImageDeledateState();
}

class _ImageDeledateState extends State<ImageDeledate> {
  @override
  Widget build(BuildContext context) {
    ImageStore item;
    try {
      item = ImageStore.fromMap(widget.doc.data());
    } on Exception catch (e) {
      context.read<AdminViewModel>().deleteItem(widget.doc.id);
    }
    print("delegate odcstring" + widget.doc.data().toString());
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return DetailImage(
                      url: item.url ?? "",
                    );
                  }));
                },
                child: Container(
                  width: 100,
                  height: 100,
                  child: CachedNetworkImage(
                    imageUrl: item.url ?? "",
                    placeholder: (context, url) => _getPlaceholder(),
                    errorWidget: (context, url, error) => _getPlaceholder(),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: FutureBuilder(
                initialData: User(),
                future: context.read<LibraryViewModel>().getAuthor(item.userID),
                builder: (BuildContext context, AsyncSnapshot<User> users) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Người upload:   ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.0)),
                          Text(
                              users.data.firstName == ""
                                  ? "Không rõ"
                                  : users.data.fullName(),
                              style: TextStyle(fontSize: 15.0)),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Ngày upload:   ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.0)),
                          Text(
                              item.createDate == "" || item.createDate == null
                                  ? "Không rõ"
                                  : item.createDate.split(" ").last,
                              style: TextStyle(fontSize: 15.0)),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Mục:   ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.0)),
                          Text(
                              item.path == "" || item.path == null
                                  ? "Không rõ"
                                  : item.path.split("/").last ?? "",
                              style: TextStyle(fontSize: 15.0)),
                        ],
                      ),
                    ],
                  );
                }),
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
                      await popupFilter(context).then((value) {
                        item.path = value;
                        context
                            .read<AdminViewModel>()
                            .updateItem(widget.doc.id, item.toMap());
                      });
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
                          //showProgress(context, 'Đang xóa...', false);
                          context
                              .read<AdminViewModel>()
                              .deleteItem(widget.doc.id)
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

Widget _getPlaceholder() => Image.asset(
      'assets/images/no_image.png',
      fit: BoxFit.fill,
    );
