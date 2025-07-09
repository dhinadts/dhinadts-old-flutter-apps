import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


var schoolID = 3;

class RoughDesignMapping extends StatefulWidget {
  RoughDesignMapping({Key key}) : super(key: key);

  @override
  _RoughDesignMappingState createState() => _RoughDesignMappingState();
}

int count = 0;

class _RoughDesignMappingState extends State<RoughDesignMapping> {
  @override
  void initState() {
    super.initState();
    findMultiSelect();
    findStaff();
  }

  findMultiSelect() async {
    var url = 'http://13.127.33.107/upload/dhanraj/homework/api/android.php';
    Response response;
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "action": "get_subject",
      "schoolid": schoolID,
    });
    response = await dio.post(url, data: formData);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    subjects = jsonDecode(response.data);
    print("subjects:: $subjects");
    print(subjects.length);
    for (var i = 0; i < subjects.length; i++) {
      selectSubjects.add({
        "checkBool": false,
        "subName": subjects[i]["subject"],
        "subID": subjects[i]["sid"]
      });
    }
    setState(() {});
  }

  findStaff() async {
    var url = 'http://13.127.33.107/upload/dhanraj/homework/api/android.php';
    Response response;
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "action": "get_staff",
      "schoolid": schoolID,
    });
    response = await dio.post(url, data: formData);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    staffSelect = jsonDecode(response.data);

    print("staffName: $staffSelect");
    /* staffSelect.forEach((item) {
      if (item["mobile"].startsWith(phone)) {
        staffName = item['name'];
      }
    }); */
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _subjects =
        new List.generate(count, (int i) => new ContactRow1());
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapping Staff with Subjects'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  /* Table(
//          defaultColumnWidth:
//              FixedColumnWidth(MediaQuery.of(context).size.width / 3),
              border: TableBorder.all(
                  color: Colors.black26, width: 1, style: BorderStyle.solid),
              children: [
                TableRow(children: [
                  TableCell(child: Center(child: Text('Title'))),
                  TableCell(child: Center(child: Text('Title'))),
                  TableCell(child: Center(child: Text('Title'))),
                  TableCell(child: Center(child: Text('Title'))),
                  TableCell(child: Center(child: Text('Title'))),
                  TableCell(child: Center(child: Text('Title'))),
                ]),
                TableRow(children: [
                  TableCell(
                    child: Center(child: Text('Value')),
                    verticalAlignment: TableCellVerticalAlignment.bottom,
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Center(child: Text('Value')),
                  ),
                  TableCell(
                      child: Center(
                          child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Value',
                      style: TextStyle(color: Colors.yellow),
                    ),
                  ))),
                  TableCell(
                    child: Center(child: Text('Value')),
                    verticalAlignment: TableCellVerticalAlignment.top,
                  ),
                  TableCell(
                    child: Center(child: Text('Value')),
                    verticalAlignment: TableCellVerticalAlignment.top,
                  ),
                  TableCell(
                    child: Center(child: Text('Value')),
                    verticalAlignment: TableCellVerticalAlignment.top,
                  ),
                ]),
                TableRow(children: [
                  TableCell(child: Center(child: Text('Value'))),
                  TableCell(
                    child: Center(child: Text('Value')),
                  ),
                  TableCell(child: Center(child: Text('Value'))),
                  TableCell(child: Center(child: Text('Value'))),
                  TableCell(child: Center(child: Text('Value'))),
                  TableCell(child: Center(child: Text('Value'))),
                ]),
                TableRow(children: [
                  TableCell(child: Center(child: Text('Value'))),
                  TableCell(
                    child: Center(child: Text('Value')),
                  ),
                  TableCell(child: Center(child: Text('Value'))),
                  TableCell(child: Center(child: Text('Value'))),
                  TableCell(child: Center(child: Text('Value'))),
                  TableCell(child: Center(child: Text('Value'))),
                ])
              ],
            ), */
                  Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: Text("S.No")),
                    Expanded(
                      child: Text("Staff"),
                    ),
                    Expanded(
                      child: Text("Adds"),
                    ),
                    Expanded(
                      child: Text("Subs"),
                    ),
                    Expanded(child: Text("IsCT")),

                    /* Text("Phone"),
                      Text("Staff"),
                      Text("Subs"),
                      Text("IsCT") */
                  ],
                ),
                new Container(
                  child: new ListView(
                    shrinkWrap: true,
                    children: _subjects,
                    scrollDirection: Axis.vertical,
                  ),
                ),
              ])),
          new FlatButton(
            onPressed: _addNewContactRow,
            child: new Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void _addNewContactRow() {
    // if(count<5) {
    setState(() {
      count = count + 1;
      a = "subj" + "$count";
      print(a);
      // TextEditingController a = new TextEditingController();
    });
    // }

    for (var i = 0; i < count; i++) {
      isCTCheckBool.add({
        "value": false,
        "id": 0,
      });
    }
  }
}

var a;
TextEditingController an = new TextEditingController();

class ContactRow1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ContactRow1();
}

class _ContactRow1 extends State<ContactRow1> {
  TextEditingController one = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 200.0,
      padding: new EdgeInsets.all(5.0),
      child: Expanded(
        child: Row(
          children: <Widget>[
            Expanded(flex: 1, child: Text("$count")),
            /* Expanded(
              flex: 1,
              child: TextField(
                
                keyboardType: TextInputType.number,
                onChanged: (value) async {
                  
                  
                    for (var i = 0; i < staffSelect.length; i++) {
                      if (staffSelect[i]["mobile"] ==
                          int.parse((value).toString())) {
                        staffName = staffSelect[i]["name"];
                      }
                    }
                  
                  print(staffName);
                  setState(() {});
                },
              ),
            ), */
            staffName == null
                ? Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () async {
                          /*  for (var i = 0; i < staffSelect.length; i++) {
                      if (staffSelect[i]["mobile"] ==
                          ("9865251150")) {
                        staffName = staffSelect[i]["name"];
                      }
                    } */

                          Dialog errorDialog = Dialog(
                              child: Container(
                                  child: Column(children: <Widget>[
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: staffSelect.length,
                                itemBuilder: (context, i) {
                                  return ListTile(
                                      title: Text("${staffSelect[i]["name"]}"),
                                      trailing: Icon(Icons.arrow_forward_ios),
                                      onTap: () async {
                                        staffName = staffSelect[i]["name"];
                                      });
                                }),
                            Row(
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("CANCEL"),
                                ),
                                RaisedButton(
                                    onPressed: () {
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    child: Text("OK"))
                              ],
                            )
                          ])));
                          await showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  // StatefulBuilder
                                  builder: (context, setState) {
                                    return errorDialog;
                                  },
                                );
                              });
                          print(staffName);
                        },
                        child: Text("Select")))
                : Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () async {
                          /*  for (var i = 0; i < staffSelect.length; i++) {
                      if (staffSelect[i]["mobile"] ==
                          ("9865251150")) {
                        staffName = staffSelect[i]["name"];
                      }
                    } */

                          Dialog errorDialog = Dialog(
                              child: Container(
                                  child: Column(children: <Widget>[
                            Expanded(
                              child: TextField(
                                  controller: one,
                                  onChanged: (value) async {
                                    for (var i = 0;
                                        i < staffSelect.length;
                                        i++) {
                                      if (staffSelect[i]["mobile"] == value) {
                                        setState(() {
                                          staffName = staffSelect[i]["name"];
                                        });
                                      }
                                    }
                                  }),
                            ),
                            staffName == null
                                ? Expanded(child: Text(""))
                                : Text("$staffName"),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: staffSelect.length,
                                itemBuilder: (context, i) {
                                  return ListTile(
                                      title: Text("${staffSelect[i]["name"]}"),
                                      trailing: Icon(Icons.arrow_forward_ios),
                                      onTap: () async {
                                        staffName = staffSelect[i]["name"];
                                      });
                                }),
                            Row(
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("CANCEL"),
                                ),
                                RaisedButton(
                                    onPressed: () {
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    child: Text("OK"))
                              ],
                            )
                          ])));
                          await showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  // StatefulBuilder
                                  builder: (context, setState) {
                                    return errorDialog;
                                  },
                                );
                              });
                          print(staffName);
                        },
                        child: Text("$staffName"))),
            Expanded(
              flex: 1,
              child: GestureDetector(
                  onTap: () async {
                    Dialog errorDialog = Dialog(
                        child: Container(
                      child: Column(
                        children: <Widget>[
                          /* Expanded(
                            child: */
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: selectSubjects.length,
                            itemBuilder: (context, i) {
                              return /* Card(
                                  child: */
                                  /* ListTile(
                                leading: Checkbox(
                                    value: selectSubjects[i]["checkBool"],
                                    onChanged: (value) async {
                                      setState(() {
                                        selectSubjects[i]["checkBool"] = value;
                                        
                                      });
                                      
                                      
                                      print(selectSubjects[i]["checkBool"]);
                                    }),
                                title: Text("${selectSubjects[i]["subName"]}"),

                                // ),
                              ); */
                                  CheckboxListTile(
                                value: selectSubjects[i]["checkBool"],
                                title: Text("${selectSubjects[i]["subName"]}"),
                                onChanged: (value) {
                                  setState(() {
                                    selectSubjects[i]["checkBool"] = value;
                                  });
                                },
                              );
                              /* Row(children: <Widget>[
                                Expanded(
                                  child: Checkbox(
                                      value: selectSubjects[i]["checkBool"],
                                      onChanged: (value) {
                                        setState(() {
                                          value = !value;
                                        });
                                          if (value == true) {
                                            selectSubjects[i]["checkBool"] =
                                                true;
                                          } else {
                                            selectSubjects[i]["checkBool"] =
                                                false;
                                          }
                                        
                                      }),
                                ),
                                Expanded (child: Text("${selectSubjects[i]["subName"]}"),)
                              ]); */
                            },
                          ),
                          //),
                          Row(
                            children: <Widget>[
                              RaisedButton(
                                  child: Text("Cancel"),
                                  onPressed: () => Navigator.pop(context)),
                              RaisedButton(
                                  child: Text("Ok"),
                                  onPressed: () async {
                                    subName.clear();
                                    for (var i = 0;
                                        i < selectSubjects.length;
                                        i++) {
                                      if (true ==
                                          selectSubjects[i]["checkBool"]) {
                                        subName
                                            .add(selectSubjects[i]["subName"]);
                                        subName = subName.toSet().toList();
                                      }
                                    }
                                    setState(() {});
                                    Navigator.pop(context);
                                  }),
                            ],
                          )
                        ],
                      ),
                    ));

                    await showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            // StatefulBuilder
                            builder: (context, setState) {
                              return errorDialog;
                            },
                          );
                        });
                  },
                  child: subName == null ? Text("ADD Subs") : Text("$subName")),
            ),
            Expanded(
                flex: 1,
                child: subName == null ? Text("ADD Subs") : Text("$subName")),
            Expanded(
                flex: 1,
                child: Checkbox(
                    value: false,
                    onChanged: (value) {
                      setState(() {
                        value = !value;
                      });
                    }))
          ],
        ),
      ),
    );
  }
}

var staffSelect = new List();
var staffName; // = new List();
var subjects = new List();
var selectSubjects = new List();
var subName = new List();
var isCTCheckBool = new List();
