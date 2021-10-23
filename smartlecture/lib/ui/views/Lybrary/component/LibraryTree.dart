import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:smartlecture/ui/modules/router_name.dart';
import 'package:smartlecture/ui/views/Lybrary/Lybrary_viewmodel.dart';
import 'package:tree_view/tree_view.dart';

import 'package:smartlecture/models/admin_model/Lybrary.dart';
import 'package:smartlecture/services/authenticate.dart';

import '../../../../constants.dart';

TypeFolder _type;

var db = FireStoreUtils.firestore;
Document document = Document(
  name: 'Tiểu học',
  id: "id",
  isFile: false,
  childData: [
    Document(name: 'Lớp 1', id: "id", childData: [
      Document(
        name: 'Tiếng anh',
        id: "tieuhoc/tienganh/lop1",
        isFile: true,
      )
    ]),
    Document(name: 'Lớp 2', id: "id", childData: [
      Document(
        name: 'Tiếng anh',
        id: "tieuhoc/tienganh/lop2",
        isFile: true,
      )
    ]),
    Document(name: 'Lớp 3', id: "id", childData: [
      Document(
        name: 'Tiếng anh',
        id: "tieuhoc/tienganh/lop3",
        isFile: true,
      )
    ]),
    Document(name: 'Lớp 4', id: "id", childData: [
      Document(
        name: 'Tiếng anh',
        id: "tieuhoc/tienganh/lop4",
        isFile: true,
      )
    ]),
  ],
);

class LibraryTreeView extends StatefulWidget {
  LibraryTreeView({
    Key key,
    this.type,
    this.isComponent,
  }) : super(key: key);
  final bool isComponent;
  final TypeFolder type;
  @override
  _LibraryTreeViewState createState() => _LibraryTreeViewState();
}

class _LibraryTreeViewState extends State<LibraryTreeView> {
  List<Document> documentList = [];
  bool iscmn = false;
  @override
  void initState() {
    documentList.clear();
    documentList.add(document);
    if (widget.isComponent != null) {
      iscmn = widget.isComponent;
    }
    if (widget.type != null) {
      _type = widget.type;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fireStoreCheckAndCreateFolder();
    if (iscmn) {
      return TreeView(
        parentList: _getParentList(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Chọn mục"),
      ),
      body: TreeView(
        parentList: _getParentList(),
      ),
    );
  }

  List<Parent> _getParentList() {
    List<Parent> parentList = [];

    documentList.asMap().forEach((index, document) {
      Parent parent = _getParent(document: document, parentIndex: index);
      parentList.add(parent);
    });

    return parentList;
  }

  Parent _getParent({@required Document document, int parentIndex}) {
    ChildList childList =
        document.childData == null ? null : _getChildList(document: document);

    return Parent(
      parent: _getDocumentWidget(document: document),
      childList: childList,
    );
  }

  ChildList _getChildList({@required Document document}) {
    List<Widget> widgetList = [];

    List<Document> childDocuments = document.childData;
    childDocuments.forEach((childDocument) {
      widgetList.add(Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: _getParent(document: childDocument),
      ));
    });

    return ChildList(children: widgetList);
  }

  Widget _getDocumentWidget({@required Document document}) => document.isFile
      ? _getFileWidget(document: document)
      : _getDirectoryWidget(document: document);

  DirectoryWidget _getDirectoryWidget({@required Document document}) =>
      DirectoryWidget(
        directoryName: document.name,
        lastModified: document.id,
      );

  FileWidget _getFileWidget({@required Document document}) => FileWidget(
        fileName: document.name,
        id: document.id,
      );
}

class FileWidget extends StatelessWidget {
  final String fileName;
  final String id;

  FileWidget({@required this.fileName, @required this.id});

  @override
  Widget build(BuildContext context) {
    Widget fileNameWidget = Text(this.fileName);
    Icon fileIcon = Icon(Icons.insert_drive_file);
    checkAndOpenFolder(String path) async {
      if (_type == TypeFolder.FOLDER_LECTURE) {
        print("   path $path");
        context
            .read<LibraryViewModel>()
            .getdataLybrary(path, false)
            .then((value) {
          Navigator.pushNamed(context, RouteName.listLectures);
        });
      } else if (_type == TypeFolder.FOLDER_CONTRIBUTE) {
        context
            .read<LibraryViewModel>()
            .getdataLybrary(path, true)
            .then((value) {
          Navigator.pushNamed(context, RouteName.listLectures);
        });
      } else
        Navigator.pop(context, "$path");
    }

    return GestureDetector(
      child: Card(
        elevation: 0.0,
        child: ListTile(
          leading: fileIcon,
          title: fileNameWidget,
        ),
      ),
      onTap: () {
        checkAndOpenFolder(id);
      },
    );
  }
}

class DirectoryWidget extends StatelessWidget {
  final String directoryName;
  final String lastModified;
  final VoidCallback onPressedNext;

  DirectoryWidget({
    @required this.directoryName,
    @required this.lastModified,
    this.onPressedNext,
  });

  @override
  Widget build(BuildContext context) {
    Widget titleWidget = Text(directoryName);
    Icon folderIcon = Icon(Icons.folder);

    IconButton expandButton = IconButton(
      icon: Icon(Icons.navigate_next),
      onPressed: onPressedNext,
    );

    Widget lastModifiedWidget = Text(
      lastModified,
    );

    return Card(
      child: ListTile(
        leading: folderIcon,
        title: titleWidget,
        trailing: expandButton,
      ),
    );
  }
}

fireStoreCheckAndCreateFolder() async {
  DocumentSnapshot documentSnapshot = await FireStoreUtils.firestore
      .collection(LIBRARY)
      .doc("lkWGSNrqiB2xoxq3yY2u")
      .get();
  if (documentSnapshot == null || !documentSnapshot.exists) {
    db.collection(LIBRARY).doc("lkWGSNrqiB2xoxq3yY2u").set(document.toMap());
  }
}
