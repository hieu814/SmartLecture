import 'package:flutter/material.dart';
import 'package:smartlecture/models/Lecture.dart';
import 'package:smartlecture/models/Page.dart' as p;
import 'package:smartlecture/models/Section.dart';
import 'package:smartlecture/widgets/Page.dart';

class ListSection extends StatefulWidget {
  final bool isHorizontal;
  final Section section;
  final int currentPage;
  final Function(int) onCurrentPageChange;
  const ListSection({
    Key key,
    this.isHorizontal,
    this.section,
    this.currentPage,
    this.onCurrentPageChange,
  }) : super(key: key);
  @override
  _ListSectionState createState() => _ListSectionState();
}

class _ListSectionState extends State<ListSection> {
  int curPage = 0;
  List<p.Page> pages = [];
  bool reload = false;
  @override
  void initState() {
    super.initState();

    curPage = widget.currentPage ?? 0;
    pages = widget.section.page;
  }

  @override
  void dispose() {
    print("lisst ection f=dis");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    reload = !reload;
    curPage = widget.currentPage;
    pages = widget.section.page;

    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
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
                        });
                        widget.onCurrentPageChange(curPage);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
