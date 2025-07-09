import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:dio/dio.dart';

var schoolID = 1;

class RoughMappingStaffWithSub extends StatefulWidget {
  RoughMappingStaffWithSub({Key key}) : super(key: key);

  @override
  _RoughMappingStaffWithSubState createState() =>
      _RoughMappingStaffWithSubState();
}

class _RoughMappingStaffWithSubState extends State<RoughMappingStaffWithSub> {
  var resultClass;
  String phone;

  @override
  void initState() {
    super.initState();
    classList();
    findMultiSelect();
    findStaff();
    completeList.clear();
  }

  classList() async {
    var url = 'http://13.127.33.107/upload/dhanraj/homework/api/android.php';

    Response response;
    Dio dio = new Dio();

    FormData formData = new FormData.fromMap({
      "action": "get_class_by_group",
      "schoolid": schoolID,
      "acyid": 1,
    });
    classIDs.add("Class Select");
    sectionIDs.add("Section Select");
    response = await dio.post(url, data: formData);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    resultClass = jsonDecode(response.data);
    print("classLength:: ${resultClass.length}");
    for (var i = 0; i < resultClass.length; i++) {
      classIDs.add("${resultClass[i]["class"]}");
      // sectionIDs.add("${result[i]["section"]}");
    }
    print("subjects:: $classIDs");
    print(classIDs.length);
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
      isCTCheckBool.add({"checkBool": false, "yes": "No"});
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

  findSections() async {
    for (var i = 0; i < resultClass.length; i++) {
      if (classSelect.toString() == resultClass[i]["class"]) {
        sectionIDs.add(resultClass[i]["section"]["section"]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Academic Year: 20/21",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20),
                        ))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: DropdownButton(
                                elevation: 0,
                                underline: Container(),
                                isExpanded: true,
                                isDense: true,
                                value: classSelect,
                                onChanged: (newValue) {
                                  setState(() {
                                    classSelect = newValue;
                                    findSections();
                                  });

                                  setState(() {});
                                },
                                items: classIDs.map((classes) {
                                  return DropdownMenuItem(
                                    child: new Text(classes),
                                    value: classes,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: DropdownButton(
                                elevation: 0,
                                underline: Container(),
                                isExpanded: true,
                                isDense: true,
                                value: sectionSelect,
                                onChanged: (newValue) {
                                  setState(() {
                                    sectionSelect = newValue;
                                  });
                                },
                                items: sectionIDs.map((sections) {
                                  return DropdownMenuItem(
                                    child: new Text(sections),
                                    value: sections,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Staff Name :",
                                    style: TextStyle(fontSize: 18),
                                  )),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                    child: Text(
                                      "$staffName",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    onTap: () async {
                                      Dialog errorDialog = Dialog(
                                          child: Container(
                                              child: Column(children: <Widget>[
                                        Expanded(
                                          child: TextField(
                                              decoration: InputDecoration(
                                                  hintText: "Enter number",
                                                  suffixIcon: IconButton(
                                                      icon: Icon(Icons.search),
                                                      onPressed: () {
                                                        for (var i = 0;
                                                            i <
                                                                staffSelect
                                                                    .length;
                                                            i++) {
                                                          if (staffSelect[i]
                                                                  ["mobile"] ==
                                                              phone) {
                                                            setState(() {
                                                              staffName =
                                                                  staffSelect[i]
                                                                      ["name"];
                                                            });
                                                          } else {
                                                            setState(() {
                                                              staffName =
                                                                  "No Teacher";
                                                            });
                                                          }
                                                        }
                                                      })),
                                              onChanged: (value) async {
                                                phone = value;
                                                for (var i = 0;
                                                    i < staffSelect.length;
                                                    i++) {
                                                  if (staffSelect[i]
                                                          ["mobile"] ==
                                                      value) {
                                                    setState(() {
                                                      staffName = staffSelect[i]
                                                          ["name"];
                                                    });
                                                  }
                                                }
                                              }),
                                        ),
                                        staffName == null
                                            ? Expanded(
                                                child: Text(
                                                "No Teacher",
                                                style: TextStyle(fontSize: 20),
                                              ))
                                            : Expanded(
                                                child: Text(
                                                  "$staffName",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: staffSelect.length,
                                            itemBuilder: (context, i) {
                                              return ListTile(
                                                  title: Text(
                                                      "${staffSelect[i]["name"]}"),
                                                  subtitle: Text(
                                                      "${staffSelect[i]["mobile"]}"),
                                                  trailing: Icon(
                                                      Icons.arrow_forward_ios),
                                                  onTap: () async {
                                                    staffName =
                                                        staffSelect[i]["name"];
                                                    mobileNU = int.parse(
                                                        staffSelect[i]["mobile"]
                                                            .toString());
                                                  });
                                            }),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
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
                                    }),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Subjects      :",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () async {
                                    Dialog errorDialog = Dialog(
                                        child: Container(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            ListView.builder(
                                              physics: ClampingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: selectSubjects.length,
                                              itemBuilder: (context, i) {
                                                return CheckboxListTile(
                                                  value: selectSubjects[i]
                                                      ["checkBool"],
                                                  title: Text(
                                                      "${selectSubjects[i]["subName"]}"),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectSubjects[i]
                                                          ["checkBool"] = value;
                                                    });
                                                  },
                                                );
                                              },
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                RaisedButton(
                                                    child: Text("Cancel"),
                                                    onPressed: () =>
                                                        Navigator.pop(context)),
                                                RaisedButton(
                                                    child: Text("Ok"),
                                                    onPressed: () async {
                                                      subName.clear();
                                                      for (var i = 0;
                                                          i <
                                                              selectSubjects
                                                                  .length;
                                                          i++) {
                                                        if (true ==
                                                            selectSubjects[i]
                                                                ["checkBool"]) {
                                                          subName.add(
                                                              selectSubjects[i]
                                                                  ["subName"]);
                                                          subName = subName
                                                              .toSet()
                                                              .toList();
                                                        }
                                                      }
                                                      setState(() {});
                                                      Navigator.pop(context);
                                                    }),
                                              ],
                                            )
                                          ],
                                        ),
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
                                  child: subName.length == 0
                                      ? Text(
                                          "ADD Subs",
                                          style: TextStyle(fontSize: 18),
                                        )
                                      : ListView.builder(
                                          itemCount: subName.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, i) {
                                            var a = i + 1;
                                            return Text(
                                              "$a.${subName[i]}",
                                              style: TextStyle(fontSize: 18),
                                            );
                                          }),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "iSCT             :",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Checkbox(
                                      value: isCTCheckBool[0]["checkBool"],
                                      onChanged: (value) {
                                        setState(() {
                                          isCTCheckBool[0]["checkBool"] = value;
                                        });
                                        if (isCTCheckBool[0]["checkBool"] ==
                                            true) {
                                          isCTCheckBool[0]["yes"] = "Yes";
                                        } else {
                                          isCTCheckBool[0]["yes"] = "No";
                                        }
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                new FlatButton(
                  onPressed: () {
                    setState(() {
                      completeList.add({
                        "staffName": staffName,
                        "subNames": subName,
                        "isCT": isCTCheckBool[0]["yes"],
                        "mobile": mobileNU,
                      });
                    });
                    print(completeList);
                  },
                  child: new Icon(Icons.add),
                ),
                completeList.length == 0
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(child: Text("S.No")),
                              Expanded(child: Text("Phone")),
                              Expanded(child: Text("Staff")),
                              Expanded(child: Text("Subjs")),
                              Expanded(child: Text("isCT"))
                            ],
                          ),
                        ),
                      ),
                completeList.length == 0
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: ListView.builder(
                              itemCount: completeList.length,
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, i) {
                                int a = i + 1;
                                return Row(children: [
                                  Expanded(child: Text("$a")),
                                  Expanded(
                                      child:
                                          Text("${completeList[i]["mobile"]}")),
                                  Expanded(
                                      child: Text(
                                          "${completeList[i]["staffName"]}")),
                                  Expanded(
                                      child: Text(
                                          "${completeList[i]["subNames"]}")),
                                  Expanded(
                                      child: Text("${completeList[i]["isCT"]}"))
                                ]);
                              }),
                        ),
                      ),
                completeList.length == 0
                    ? SizedBox()
                    : FlatButton(
                        onPressed: () {
                          print("Submit");
                          print(completeList);
                          completeList.clear();
                          staffName = "Select";
                          subName.clear(); // = "Select" as List;
                          isCTCheckBool.clear();
                          mobileNU = 0;
                          setState(() {});
                        },
                        child: Text("SUBMIT"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

var staffSelect = new List();
var staffName = "Select";
var mobileNU = 0; // = new List();
var subjects = new List();
var selectSubjects = new List();
var subName = new List();
var mobile = new List();
var isCTCheckBool = new List();

var classIDs = new List();
var classSelect = "Class Select";
var sectionSelect = "Section Select";
var sectionIDs = new List();

var completeList = new List();

/* 
Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  
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
      ), */
