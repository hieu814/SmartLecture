import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:smartlecture/models/admin_model/MyFiles.dart';

import '../../../../constants.dart';

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    Key key,
    this.info,
    this.onSelect,
  }) : super(key: key);
  final Function(int) onSelect;
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
              PopupMenuButton(
                initialValue: 0,
                padding: EdgeInsets.all(0),
                color: secondaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                icon: Icon(Icons.more_vert, color: Colors.black),
                onSelected: onSelect,
                itemBuilder: (context) {
                  return List.generate(1, (index) {
                    return PopupMenuItem(
                      value: index,
                      child: Center(child: Text("Chi tiết")),
                    );
                  });
                },
              ),
            ],
          ),
          Text(
            info.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          ProgressLine(
            color: info.color,
            percentage: info.percentage,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${info.numOfFiles} Files",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.black38),
              ),
              Text(
                info.totalStorage,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.red),
              ),
            ],
          )
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
