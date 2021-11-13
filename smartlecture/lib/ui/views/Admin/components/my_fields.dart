import 'package:flutter/material.dart';
import 'package:smartlecture/models/admin_model/MyFiles.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Section/SECTION_viewmodel.dart';
import '../../../../constants.dart';
import '../../../../responsive.dart';
import '../Dashboard_ViewModel.dart';
import 'file_info_card.dart';
import 'package:provider/provider.dart';

class MyFiles extends StatefulWidget {
  const MyFiles({
    Key key,
  }) : super(key: key);

  @override
  _MyFilesState createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            // ElevatedButton.icon(
            //   style: TextButton.styleFrom(
            //     padding: EdgeInsets.symmetric(
            //       horizontal: defaultPadding * 1.5,
            //       vertical:
            //           defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
            //     ),
            //   ),
            //   onPressed: () {},
            //   icon: Icon(Icons.add),
            //   label: Text("Add New"),
            // ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatefulWidget {
  const FileInfoCardGridView({
    Key key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  _FileInfoCardGridViewState createState() => _FileInfoCardGridViewState();
}

class _FileInfoCardGridViewState extends State<FileInfoCardGridView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<AdminViewModel>().getDataLength(),
        builder: (context, snapshot) {
          return GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: context.read<AdminViewModel>().datas.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              crossAxisSpacing: defaultPadding,
              mainAxisSpacing: defaultPadding,
              childAspectRatio: widget.childAspectRatio,
            ),
            itemBuilder: (context, index) => FileInfoCard(
              info: context.read<AdminViewModel>().datas[index],
              onSelect: (s) {
                context.read<AdminViewModel>().setCurrentCollection(s);
                Navigator.pushNamed(context, RouteName.dataDetailPage)
                    .then((value) {
                  setState(() {});
                });
              },
            ),
          );
        });
  }
}
