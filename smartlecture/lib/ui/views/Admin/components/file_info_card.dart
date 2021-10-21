import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartlecture/models/admin_model/MyFiles.dart';

import '../../../../constants.dart';

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    Key key,
    this.info,
    this.onSelect,
  }) : super(key: key);
  final Function(String) onSelect;
  final CloudStorageInfo info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(defaultPadding * 0.75),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: info.color.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: FaIcon(
                    info.icon,
                    color: info.color,
                  ),
                ),
              ),
              Text(
                info.numOfFiles.toString(),
                style: TextStyle(
                    color: info.color,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Text(
            info.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          GestureDetector(
            onTap: () {
              String a = info.type ?? "";
              onSelect(a);
            },
            child: Card(
              shadowColor: Colors.red,
              child: Container(
                color: secondaryColor,
                height: 30,
                child: Row(
                  children: [
                    Expanded(flex: 8, child: Text("Chi tiết")),
                    Icon(
                      Icons.arrow_forward_ios,
                      //size: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key key,
    this.color = primaryColor,
    this.percentage,
  }) : super(key: key);

  final Color color;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
