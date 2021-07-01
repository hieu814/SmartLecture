import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:smartlecture/models/lecture_model/LectuteData.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/widgets/components/Page.dart';

class LectureDelegate extends StatelessWidget {
  final LectuteData item;
  final double width;
  final double heigth;
  const LectureDelegate({Key key, this.item, this.width, this.heigth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RouteName.sectionPage, arguments: item);
        },
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                child: IPage(
                  width: width,
                  height: heigth,
                  page: item.lecture.section[0].page[0],
                  isPresentation: true,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                width: double.infinity,
                //color: Colors.yellow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 8),
                    Text(
                      item.lecture.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 15),
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
