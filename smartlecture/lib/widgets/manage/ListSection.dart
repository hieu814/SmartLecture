import 'package:flutter/material.dart';
import 'package:smartlecture/models/Lecture.dart';
import 'package:smartlecture/models/Page.dart' as p;
import 'package:smartlecture/widgets/Page.dart';

class ListSection extends StatefulWidget {
  final bool isHorizontal;
  final Lecture lecture;
  final Function(int) onCurrentSectionChange;
  final Function(int) onCurrentPageChange;
  final int currentSectionIndex;
  final int currentPageIndex;
  const ListSection(
      {Key key,
      this.isHorizontal,
      this.lecture,
      this.onCurrentSectionChange,
      this.currentSectionIndex,
      this.onCurrentPageChange,
      this.currentPageIndex})
      : super(key: key);
  @override
  _ListSectionState createState() => _ListSectionState();
}

class _ListSectionState extends State<ListSection> {
  int curPage = 0;
  List<p.Page> pages = [];
  @override
  void initState() {
    super.initState();
    curPage = widget.currentPageIndex ?? 0;
    pages = widget.lecture.section[widget.currentSectionIndex].page;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Container(
                  width: 100,
                  height: 100,
                  child: Column(
                    children: <Widget>[
                      Card(
                        child: Container(
                            width: 100,
                            height: 30,
                            child: PopupMenuButton(
                              child: Center(child: Text("Danh sách")),
                              itemBuilder: (context) {
                                return List.generate(
                                    widget.lecture.section.length, (index) {
                                  return PopupMenuItem(
                                    child: Text(
                                        widget.lecture.section[index].title),
                                  );
                                });
                              },
                              onSelected: (index) {
                                widget.onCurrentSectionChange(index);
                              },
                            ),
                            margin: EdgeInsets.all(5)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        child: Container(
                            child: Text("Thêm"),
                            width: 100,
                            height: 20,
                            margin: EdgeInsets.all(5)),
                      )
                    ],
                  ),
                  margin: EdgeInsets.all(5))),
          Expanded(
            flex: 7,
            child: Container(
              height: 100,
              width: 100,
              child: ListView.builder(
                itemCount: pages.length,
                scrollDirection:
                    widget.isHorizontal ? Axis.horizontal : Axis.vertical,
                itemBuilder: (context, index) {
                  return Card(
                    shape: index == curPage
                        ? new RoundedRectangleBorder(
                            side: new BorderSide(color: Colors.red, width: 2.0),
                            borderRadius: BorderRadius.circular(4.0))
                        : new RoundedRectangleBorder(
                            side:
                                new BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(4.0)),
                    child: GestureDetector(
                      child: IPage(
                        isPresentation: true,
                        width: 100,
                        height: 100,
                        page: pages[index],
                      ),
                      onTap: () {
                        setState(() {
                          curPage = index;
                          //widget.onCurrentPageChange(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Card(
                child: Container(
                    width: 100,
                    height: 100,
                    child: Center(
                      child: IconButton(
                          iconSize: 15, onPressed: null, icon: Icon(Icons.add)),
                    ),
                    margin: EdgeInsets.all(5)),
              ))
        ],
      ),
    );
  }
}
