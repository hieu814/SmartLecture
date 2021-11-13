import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartlecture/models/admin_model/ImageStore.dart';

import 'package:smartlecture/models/lecture_model/LectuteData.dart';
import 'package:smartlecture/ui/modules/Setting.dart';
import 'package:smartlecture/ui/modules/injection.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Admin/Dashboard_ViewModel.dart';
import 'package:smartlecture/ui/views/Admin/components/Filter.dart';
import 'package:smartlecture/ui/views/Section/components/LectureWidget.dart';
import 'package:smartlecture/widgets/layout/side_menu.dart';

List<ImageStore> _listImage = [];

//setFilterImage
class ImageGrid extends StatefulWidget {
  final String path;
  const ImageGrid({
    Key key,
    this.path,
  }) : super(key: key);
  @override
  _ImageGridState createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
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
                  child: GridView.builder(
                    itemCount: _listImage.length ?? 0,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 3),
                    ),
                    itemBuilder: (context, int index) {
                      return GestureDetector(
                        onTap: () {
                          _url = _listImage[index].url;
                          currentIndex = index;
                          setState(() {});
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: index == currentIndex
                                    ? Colors.red
                                    : Colors.transparent,
                                width: 1),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: _listImage[index].url ?? "",
                            placeholder: (context, url) => _getPlaceholder(),
                            errorWidget: (context, url, error) =>
                                _getPlaceholder(),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
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
      return ImageStore.fromMap(documentSnapshot.data());
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
