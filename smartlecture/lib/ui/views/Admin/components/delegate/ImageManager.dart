import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartlecture/models/admin_model/ImageStore.dart';

import 'package:smartlecture/models/lecture_model/LectuteData.dart';
import 'package:smartlecture/services/helper.dart';
import 'package:smartlecture/ui/modules/Setting.dart';
import 'package:smartlecture/ui/modules/function.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Admin/Dashboard_ViewModel.dart';
import 'package:smartlecture/ui/views/Admin/components/Filter.dart';
import 'package:smartlecture/ui/views/Section/components/LectureWidget.dart';
import 'package:smartlecture/widgets/layout/side_menu.dart';
import 'package:smartlecture/widgets/popup/popup.dart';

List<DocumentSnapshot> _listImage = [];

//setFilterImage
class ImageManager extends StatefulWidget {
  final String path;
  const ImageManager({
    Key key,
    this.path,
  }) : super(key: key);
  @override
  _ImageManagerState createState() => _ImageManagerState();
}

class _ImageManagerState extends State<ImageManager> {
  int _selectedIndex = 0;
  String _url = "";
  int currentIndex = 0;
  @override
  void initState() {
    context.read<AdminViewModel>().setFilterImage(widget.path ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Danh sách hình ảnh"),
          actions: <Widget>[
            ElevatedButton(
              style: TextButton.styleFrom(),
              onPressed: () {
                print("----- pop url $_url");
                Navigator.pop(context, _url);
              },
              child: Text("Chọn"),
            )
          ],
        ),
        body: Column(
          children: [
            FilterWidget(
              width: double.infinity,
              returnData: (path) {
                context.read<AdminViewModel>().setFilterImage(path ?? "");
                setState(() {});
              },
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<Object>(
              stream: context.read<AdminViewModel>().streamDataImage,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                _createRows(snapshot.data);
                return SizedBox(
                  height: 500,
                  child: ListView.builder(
                    itemCount: _listImage.length ?? 0,
                    itemBuilder: (context, int index) {
                      ImageStore _image =
                          ImageStore.fromMap(_listImage[index].data());
                      return GestureDetector(
                          onTap: () {
                            _url = _image.url;
                            currentIndex = index;
                            setState(() {});
                          },
                          child: Card(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) => LectureDetail(
                                        //             id: doc.id,
                                        //             lecture: item,
                                        //           )),
                                        // );
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        child: CachedNetworkImage(
                                          imageUrl: _image.url ?? "",
                                          placeholder: (context, url) =>
                                              _getPlaceholder(),
                                          errorWidget: (context, url, error) =>
                                              _getPlaceholder(),
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "item.title",
                                        maxLines: 2,
                                      ),
                                      Text(
                                        "Author: " + "item.authorId",
                                        maxLines: 1,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Wrap(
                                          spacing: 2,
                                          children: <Widget>[
                                            GestureDetector(
                                              child: Icon(Icons.edit),
                                              onTap: () async {},
                                            ),
                                            GestureDetector(
                                              child: Icon(
                                                Icons.delete_rounded,
                                                color: Colors.red,
                                              ),
                                              onTap: () async {
                                                popupYesNo(context)
                                                    .then((value) {
                                                  if (value) {
                                                    showProgress(context,
                                                        'Đang xóa...', false);
                                                    context
                                                        .read<AdminViewModel>()
                                                        .deleteItem("doc.id")
                                                        .then((value) {
                                                      hideProgress();
                                                      showInSnackBar(
                                                          context, "đã xóa");
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
                          ));
                    },
                  ),
                );
              },
            ),
          ],
        ));
  }

  _createRows(QuerySnapshot snapshot) {
    _listImage.clear();
    _listImage = snapshot.docs.map((DocumentSnapshot documentSnapshot) {
      return documentSnapshot;
    }).toList();
  }

  Widget createDelegate(DocumentSnapshot datastore) {
    ImageStore _image = ImageStore.fromMap(datastore.data());
    return Card(
      child: Container(
          width: 100,
          height: 50,
          child: CachedNetworkImage(
            imageUrl: _image.url,
            placeholder: (context, url) => _getPlaceholder(),
            errorWidget: (context, url, error) => _getPlaceholder(),
            fit: BoxFit.fill,
          )),
    );
  }
}

Widget _getPlaceholder() => Image.asset(
      'assets/images/no_image.png',
      fit: BoxFit.fill,
    );
