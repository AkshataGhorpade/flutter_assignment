import 'dart:convert';

import 'package:assignment_flutter/TableModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Demo App"),
        ),
        body: FutureBuilder<List<TableModel>>(
          future: generateList(),
          builder: (context, snapShot) {
            if (snapShot.data == null ||
                snapShot.connectionState == ConnectionState.waiting ||
                snapShot.hasError ||
                snapShot.data!.length == 0) {
              return Container(
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: snapShot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final TableModel table = snapShot.data![index];
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: table.headerData.map<DataColumn>((e) {
                          var columnName = e;
                          TextAlign align;
                          if (columnName.contains('<')) {
                            align = TextAlign.start;
                            columnName = columnName.replaceAll('<', '');
                          } else if (columnName.contains('>')) {
                            align = TextAlign.end;
                            columnName = columnName.replaceAll('>', '');
                          } else {
                            align = TextAlign.center;
                          }
                          return DataColumn(
                              label: Text(
                                columnName,
                                textAlign: align,
                              ));
                        }).toList(),
                        rows: table.rowData.map<DataRow>((e) {
                          return DataRow(
                              cells: e
                                  .map<DataCell>((e) => DataCell(Text(e)))
                                  .toList());
                        }).toList(),
                      ),
                    );
                  });
            }
          },
        )
      ),
    );
  }
}

Future<List<TableModel>> generateList() async {
  String responseBody = await rootBundle.loadString("assets/data.json");
   var list = await json.decode(responseBody).cast<Map<String, dynamic>>();
  return await list
      .map<TableModel>((json) => TableModel.fromJson(json))
      .toList();
}


