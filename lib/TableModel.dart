class TableModel {
  TableModel(this.headerData, this.rowData);
  List<String> headerData;
  List<List<String>> rowData;
  factory TableModel.fromJson(Map<String, dynamic> json) {
    var dataFields=json['CovidBedsData'][0]['fields'];
    List<String> listDataHeader = <String>[];
    for(int i=0;i<dataFields.length;i++){
      var strLable=dataFields[i];
      String strLabless=strLable["label"];
      listDataHeader.add(strLabless);
    }
      return TableModel(
          listDataHeader,
        buildRowData(json),
      );
  }
}

List<List<String>> buildRowData(Map<String, dynamic> json){
  List<List<String>> rowDataCollection = [];
  var dataVal=json['CovidBedsData'][0]['data'];
  for(int i=0;i<dataVal.length;i++){
    var strLable=dataVal[i];
    List<String> listDataRow = <String>[];
    for(int i=0;i<strLable.length;i++){
      listDataRow.add(strLable[i]);
    }
    rowDataCollection.add(listDataRow);
  }
  return rowDataCollection;
}