import 'package:flutter/material.dart';

class ListLectures extends StatefulWidget {
  ListLectures({Key key}) : super(key: key);

  static const String _title = 'Danh sách bài giảng';

  @override
  State<ListLectures> createState() => _ListLecturesState();
}

class _ListLecturesState extends State<ListLectures> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ListLectures._title),
        automaticallyImplyLeading: true,
      ),
      body: const MyStatelessWidget(),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatefulWidget {
  const MyStatelessWidget({Key key}) : super(key: key);

  @override
  State<MyStatelessWidget> createState() => _MyStatelessWidgetState();
}

class _MyStatelessWidgetState extends State<MyStatelessWidget> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Name',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Age',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Role',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Sarah')),
            DataCell(Text('19')),
            DataCell(Text('Student')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Janine')),
            DataCell(Text('43')),
            DataCell(Text('Professor')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('William')),
            DataCell(Text('27')),
            DataCell(Text('Associate Professor')),
          ],
        ),
      ],
    );
  }
}
