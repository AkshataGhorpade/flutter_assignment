import 'dart:convert';

import 'package:assignment_flutter/TableModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() => runApp(MyApp());
const String dataCovidJson = '''
{
	"fields": [{

		"id": "a",

		"label": "S.No",

		"type": "string"

	}, {

		"id": "b",

		"label": "Name of the District",

		"type": "string"

	}, {

		"id": "c",

		"label": "Earmarked beds for COVID with O2 supply under CHC and CDH as on 26.08.2021",

		"type": "string"

	}, {

		"id": "d",

		"label": "Earmarked beds for COVID with Non O2 supply under CHC and CDH as on 26.08.2021",

		"type": "string"

	}, {

		"id": "e",

		"label": "Earmarked beds for COVID in ICU under CHC and CDH as on 26.08.2021",

		"type": "string"

	}, {

		"id": "f",

		"label": "Occupancy of beds with O2 supply under CHC and CDH as on 26.08.2021",

		"type": "string"

	}, {

		"id": "g",

		"label": "Occupancy of beds with Non O2 supply under CHC and CDH as on 26.08.2021",

		"type": "string"

	}, {

		"id": "h",

		"label": "Occupancy of beds in ICU under CHC and CDH as on 26.08.2021",

		"type": "string"

	}, {

		"id": "i",

		"label": "Vacancy of beds with O2 supply under CHC and CDH as on 26.08.2021",

		"type": "string"

	}, {

		"id": "j",

		"label": "Vacancy of beds with Non O2 supply under CHC and CDH as on 26.08.2021",

		"type": "string"

	}, {

		"id": "k",

		"label": "Vacancy of beds in ICU under CHC and CDH as on 26.08.2021",

		"type": "string"

	}, {

		"id": "l",

		"label": "Total Vacant beds under CHC and CDH as on 26.08.2021",

		"type": "string"

	}],

	"data": [

		["1", "Ariyalur", "452", "145", "83", "34", "13", "3", "418", "132", "80", "630"],

		["2", "Chengalpattu", "2076", "2851", "676", "47", "47", "35", "2029", "2804", "641", "5474"],

		["3", "Chennai", "8602", "3937", "1978", "414", "378", "212", "8188", "3559", "1766", "13513"],

		["4", "Coimbatore", "4564", "1986", "648", "406", "233", "119", "4158", "1753", "529", "6440"],

		["5", "Cuddalore", "1182", "582", "176", "39", "35", "62", "1143", "547", "114", "1804"],

		["6", "Dharmapuri", "413", "214", "178", "39", "18", "31", "374", "196", "147", "717"],

		["7", "Dindigul", "841", "1045", "179", "14", "52", "6", "827", "993", "173", "1993"],

		["8", "Erode", "2184", "1040", "337", "222", "163", "55", "1962", "877", "282", "3121"],

		["9", "Kallakurichi", "602", "253", "80", "22", "14", "14", "580", "239", "66", "885"],

		["10", "Kancheepuram", "1324", "1209", "127", "62", "12", "6", "1262", "1197", "121", "2580"],

		["11", "Kanniyakumari", "1034", "1044", "247", "23", "73", "18", "1011", "971", "229", "2211"],

		["12", "Karur", "1010", "231", "160", "44", "12", "15", "966", "219", "145", "1330"],

		["13", "Krishnagiri", "974", "179", "142", "57", "0", "32", "917", "179", "110", "1206"],

		["14", "Madurai", "3143", "958", "682", "91", "25", "52", "3052", "933", "630", "4615"],

		["15", "Mayiladuthurai", "280", "220", "14", "44", "58", "2", "236", "162", "12", "410"],

		["16", "Nagapattinam", "304", "290", "66", "15", "63", "8", "289", "227", "58", "574"],

		["17", "Namakkal", "657", "366", "195", "70", "18", "19", "587", "348", "176", "1111"],

		["18", "Nilgiris", "580", "328", "81", "95", "59", "28", "485", "269", "53", "807"],

		["19", "Perambalur", "365", "364", "100", "3", "8", "1", "362", "356", "99", "817"],

		["20", "Pudukkottai", "710", "464", "100", "30", "90", "17", "680", "374", "83", "1137"],

		["21", "Ramanathapuram", "801", "843", "161", "4", "2", "0", "797", "841", "161", "1799"],

		["22", "Ranipet", "471", "149", "38", "9", "33", "0", "462", "116", "38", "616"],

		["23", "Salem", "1930", "1594", "528", "222", "140", "80", "1708", "1454", "448", "3610"],

		["24", "Sivaganga", "1181", "575", "188", "15", "41", "7", "1166", "534", "181", "1881"],

		["25", "Tenkasi", "328", "274", "81", "0", "12", "0", "328", "262", "81", "671"],

		["26", "Thanjavur", "781", "1004", "268", "183", "142", "43", "598", "862", "225", "1685"],

		["27", "Theni", "1071", "487", "134", "5", "12", "0", "1066", "475", "134", "1675"],

		["28", "Thoothukudi", "987", "290", "212", "15", "9", "10", "972", "281", "202", "1455"],

		["29", "Tiruchirappalli", "2425", "1354", "507", "88", "81", "33", "2337", "1273", "474", "4084"],

		["30", "Tirunelveli", "647", "355", "237", "31", "1", "7", "616", "354", "230", "1200"],

		["31", "Tirupathur", "485", "383", "85", "32", "45", "8", "453", "338", "77", "868"],

		["32", "Tiruppur", "898", "587", "237", "77", "19", "22", "821", "568", "215", "1604"],

		["33", "Tiruvallur", "1365", "681", "234", "69", "30", "14", "1296", "651", "220", "2167"],

		["34", "Tiruvannamalai", "1003", "226", "205", "99", "21", "27", "904", "205", "178", "1287"],

		["35", "Tiruvarur", "419", "265", "150", "54", "36", "28", "365", "229", "122", "716"],

		["36", "Vellore", "1035", "334", "239", "37", "36", "19", "998", "298", "220", "1516"],

		["37", "Villupuram", "551", "272", "128", "52", "23", "13", "499", "249", "115", "863"],

		["38", "Virudhunagar", "1089", "381", "165", "4", "20", "1", "1085", "361", "164", "1610"]

	]

}
''';


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


