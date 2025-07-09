import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:school/db/utility_basics.dart';
import 'package:school/main.dart';

import 'ScreenUtil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_multiselect/flutter_multiselect.dart';

var utilitybasic = Utility_Basic();
var classSelection = new List();
var subjectSelection = new List();
var staffSelection = new List();
var itemsClassSection = new List();
var itemSubject = new List();
var itemStaffs1 = new List();
var itemStaffs2 = new List();
var itemStaffs3 = new List();
var itemStaffs4 = new List();
var itemStaffs5 = new List();

List dummyClassData = List();
List dummySubData = List();
List dummyStaffData = List();
var isClassTeacher = [false, false, false, false, false];
var isClassTID = [0, 0, 0, 0, 0];
var classSectionID;
var staffID1, staffID2, staffID3, staffID4, staffID5;

class MappingStaffsWIthClass extends StatefulWidget {
  @override
  MappingStaffsWIthClassReg createState() {
    return new MappingStaffsWIthClassReg();
  }
}

class MappingStaffsWIthClassReg extends State<MappingStaffsWIthClass> {
  TextEditingController classC = new TextEditingController();
  TextEditingController staffsC1 = new TextEditingController();
  TextEditingController staffsC2 = new TextEditingController();
  TextEditingController staffsC3 = new TextEditingController();
  TextEditingController staffsC4 = new TextEditingController();
  TextEditingController staffsC5 = new TextEditingController();
  var listtt = new List();

  @override
  void initState() {
    super.initState();

    searchInitial();
    searchStaffs();
    searchSubjects();
  }

  searchInitial() async {
    var url = 'http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php';

    var response = await http.post(url,
        body: jsonEncode({
          'action': 'get_class',
          "schoolid": schoolID,
        }));

    print(response.body);
    classSelection = json.decode(response.body);
    print("countrySelection :: $classSelection");
    print(classSelection[0]["class"]);

    /* var response2 = await http.post(url,
        body: jsonEncode({
          'action': 'get_staff',
          "schoolid": schoolID,
        })); */
  }

  searchSubjects() async {
    var url = 'http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php';
    var response1 = await http.post(url,
        body: jsonEncode({
          'action': 'get_subject',
          "schoolid": schoolID,
        }));
    print(response1.body);
    subjectSelection = json.decode(response1.body);
    print("subjectSelection :: $subjectSelection");
    print(subjectSelection[0]["subject"]);
    for (var i = 0; i < subjectSelection.length; i++) {
      itemSubject.add({
        "id": subjectSelection[i]["id"],
        "subject": subjectSelection[i]["subject"]
      });
    }

    setState(() {});
    print(itemSubject);
    print(itemSubject.length);
    print(itemSubject[10]["subject"]);
  }

  searchStaffs() async {
    var url = 'http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php';
    int lastid = 0;
    var response2 = await http.post(
      url,
      body: jsonEncode({
        "action": "staff_list",
        "schoolid": schoolID,
        "limit": lastid,
        "search": "",
      }),
    );
    print(response2.body);
    staffSelection = jsonDecode(response2.body);
    print("staffSelection :: $staffSelection");
    /*  if (!staffSelection[0]["status"].toString().contains("Failed")) {
      listtt.addAll(staffSelection);
    }
    print(listtt); */
  }

  Future<void> searchapi(String value) async {
    listtt.clear();
    var response = await http.post(
        "http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php",
        body: jsonEncode({
          'action': 'staff_list',
          'schoolid': schoolID,
          'limit': listtt.length,
          'search': "${staffsC1.text}",
        }));

    print("reeeees $response");
    var abcd = json.decode(response.body);
//      print("ABCD $abcd");
    print("FIRST:::: $abcd");
    if (!abcd[0]["status"].toString().contains("Failed")) {
      listtt.addAll(abcd);
    }

    setState(() {});
  }

  filterAll(String value) {
    for (var i = 0; i < classSelection.length; i++) {
      if (classSelection[i]["class"] == value) {
        itemsClassSection.add({
          "class": classSelection[i]["class"],
          "section": classSelection[i]["section"],
          "id": classSelection[i]["id"]
        });
      }
    }

    setState(() {});
    print(itemsClassSection);
    print(itemsClassSection.length);
    print(itemsClassSection[1]["section"]);
  }

  filterSubjects() {
    for (var i = 0; i < subjectSelection.length; i++) {
      itemSubject.add({
        "id": subjectSelection[i]["id"],
        "subject": subjectSelection[i]["subject"]
      });
    }

    setState(() {});
    print(itemSubject);
    print(itemSubject.length);
    print(itemSubject[10]["subject"]);
  }

  filterStaffs(String value, int x) {
    for (var i = 0; i < staffSelection.length; i++) {
      switch (x) {
        case 1:
          {
            if (staffSelection[i]['view_txt'].contains(value)) {
              itemStaffs1.add({
                "mobile": staffSelection[i]["view_txt"],
                "name": staffSelection[i]["view_txt"],
                "id": staffSelection[i]["staffid"],
              });
            }
          }
          break;
        case 2:
          {
            if (staffSelection[i]['view_txt'].contains(value)) {
              itemStaffs2.add({
                "mobile": staffSelection[i]["view_txt"],
                "name": staffSelection[i]["view_txt"],
                "id": staffSelection[i]["staffid"],
              });
            }
          }
          break;
        case 3:
          {
            if (staffSelection[i]['view_txt'].contains(value)) {
              itemStaffs3.add({
                "mobile": staffSelection[i]["view_txt"],
                "name": staffSelection[i]["view_txt"],
                "id": staffSelection[i]["staffid"],
              });
            }
          }
          break;
        case 4:
          {
            if (staffSelection[i]['view_txt'].contains(value)) {
              itemStaffs4.add({
                "mobile": staffSelection[i]["view_txt"],
                "name": staffSelection[i]["view_txt"],
                "id": staffSelection[i]["staffid"],
              });
            }
          }
          break;
        case 5:
          {
            if (staffSelection[i]['view_txt'].contains(value)) {
              itemStaffs5.add({
                "mobile": staffSelection[i]["view_txt"],
                "name": staffSelection[i]["view_txt"],
                "id": staffSelection[i]["staffid"],
              });
            }
          }
          break;
        default:
          {
            print("Invalid choice");
          }
          break;
      }
    }
    // }

    setState(() {});
    /* print(itemStaffs);
    print(itemStaffs.length);
    print(itemStaffs[10]["name"]); */
  }

  @override
  void dispose() {
    super.dispose();
    itemsClassSection.clear();
    itemSubject.clear();

    // query.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Mapping",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: ScreenUtil().setSp(60)),
        ),
      ),
      body: Container(
        color: appcolor,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              /* Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Add Class & Sections",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(60)),
                ),
              ), */
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Container(
                          color: Colors.lightBlue[200],
                          child: Text(
                            "Academic Year : May/20 - May/21",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
/* Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          
                          Expanded(
                            child: Text("123")

                          )])), */
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Class -Section:",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: new TextEditingController.fromValue(
                                    new TextEditingValue(
                                        text: classC.text,
                                        selection: new TextSelection.collapsed(
                                            offset: classC.text.length))),
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 18),
                                onChanged: (value) async {
                                  classC.text = value;
                                  itemsClassSection.clear();

                                  await filterAll(value);
                                  setState(() {});
                                },
                              ))
                        ],
                      ),
                    ),
                    itemsClassSection.length != 0
                        ? Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Section",
                                      style: TextStyle(fontSize: 20),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: itemsClassSection.length,
                                        itemBuilder: (context, i) {
                                          return GestureDetector(
                                              child: ListTile(
                                                title: Text(
                                                    "${itemsClassSection[i]["class"]}-${itemsClassSection[i]["section"]}"),
                                              ),
                                              onTap: () async {
                                                classC.text =
                                                    "${itemsClassSection[i]["class"]}-${itemsClassSection[i]["section"]}";
                                                classSectionID =
                                                    itemsClassSection[i]["id"];

                                                setState(() {
                                                  itemsClassSection.clear();
                                                });
                                              });
                                        }))
                              ],
                            ),
                          )
                        : SizedBox(),
                    Divider(),
                    Container(
                      color: appcolor,
                      height: 80.0,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              
                              decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,

                                /* border: Border.all(
                                  color: Colors.black,
                                  width: 8,
                                ), */
                                // borderRadius: BorderRadius.circular(12.0),
                                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0))),
                              
                              child: Text(
                                "S.No",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            Text(
                              "Staff",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Text(
                              "Subject",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Text(
                              "IsCT",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ]),
                    ),
                    Divider(),
                    Padding(padding: const EdgeInsets.all(15.0),
                    child: Card(
                                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                        children: <Widget>[
                        Expanded(child: Text("1")),
                        Expanded(child: MultiSelect()),
                        Expanded(child: MultiSelect()),
                        Expanded(child: Checkbox(value: false, onChanged: null))
                      ],),
                    )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: IntrinsicHeight(
                        child: Container(
                          height: 100.0,
                          child: Row(children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: new TextEditingController.fromValue(
                                    new TextEditingValue(
                                        text: staffsC1.text,
                                        selection: new TextSelection.collapsed(
                                            offset: staffsC1.text.length))),
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                    hintText: "Enter Phone No:"),
                                onChanged: (value) async {
                                  staffsC1.text = value;
                                  itemStaffs1.clear();

                                  await filterStaffs(value, 1);
                                  setState(() {});
                                },
                              ),
                            ),
                            itemStaffs1.length != 0
                                ? Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: itemStaffs1.length,
                                        itemBuilder: (context, i) {
                                          return GestureDetector(
                                              child: ListTile(
                                                title: Text(
                                                    "${itemStaffs1[i]["name"]}"),
                                              ),
                                              onTap: () async {
                                                staffsC1.text =
                                                    "${itemStaffs1[i]["name"]}";
                                                staffID1 = itemStaffs1[i]["id"];
                                                setState(() {
                                                  itemStaffs1.clear();
                                                });
                                              });
                                        }))
                                : Divider(),
                            Expanded(
                              child: MultiSelect(
                                autovalidate: false,
                                titleText: "subject",
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select one or more option(s)';
                                  }
                                },
                                errorText:
                                    'Please select one or more option(s)',
                                dataSource: itemSubject,
                                textField: 'subject',
                                valueField: 'id',
                                filterable: true,
                                required: true,
                                value: null,
                                onSaved: (value) {},
                                change: (values) {
                                  selectedValues = values;
                                  print(selectedValues);
                                },
                              ),
                            ),
                            Expanded(
                              child: Checkbox(
                                  value: isClassTeacher[0],
                                  onChanged: (value) {
                                    if (value == true) {
                                      setState(() {
                                        isClassTeacher[0] = true;
                                        isClassTeacher[1] = false;
                                        isClassTeacher[2] = false;
                                        isClassTeacher[3] = false;
                                        isClassTeacher[4] = false;
                                        isClassTID[0] = 1;
                                        isClassTID[1] = 0;
                                        isClassTID[2] = 0;
                                        isClassTID[3] = 0;
                                        isClassTID[4] = 0;
                                      });
                                    } else {
                                      setState(() {
                                        isClassTeacher[0] = false;
                                        isClassTID[0] = 0;
                                      });
                                    }
                                  }),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: new TextEditingController.fromValue(
                                new TextEditingValue(
                                    text: staffsC2.text,
                                    selection: new TextSelection.collapsed(
                                        offset: staffsC2.text.length))),
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 18),
                            onChanged: (value) async {
                              staffsC2.text = value;
                              itemStaffs2.clear();

                              await filterStaffs(value, 2);
                              setState(() {});
                            },
                          ),
                        ),
                        itemStaffs2.length != 0
                            ? Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: itemStaffs2.length,
                                    itemBuilder: (context, i) {
                                      return GestureDetector(
                                          child: ListTile(
                                            title: Text(
                                                "${itemStaffs2[i]["name"]}"),
                                          ),
                                          onTap: () async {
                                            staffsC2.text =
                                                "${itemStaffs2[i]["name"]}";
                                            staffID2 = itemStaffs2[i]["id"];
                                            setState(() {
                                              itemStaffs2.clear();
                                            });
                                          });
                                    }))
                            : Divider(),
                        Expanded(
                          child: MultiSelect(
                            autovalidate: false,
                            titleText: "subject",
                            validator: (value) {
                              if (value == null) {
                                return 'Please select one or more option(s)';
                              }
                            },
                            errorText: 'Please select one or more option(s)',
                            dataSource: itemSubject,
                            textField: 'subject',
                            valueField: 'id',
                            filterable: true,
                            required: true,
                            value: null,
                            onSaved: (value) {},
                            change: (values) {
                              selectedValues1 = values;
                              print(selectedValues1);
                            },
                          ),
                        ),
                        Expanded(
                          child: Checkbox(
                              value: isClassTeacher[1],
                              onChanged: (value) {
                                if (value == true) {
                                  setState(() {
                                    isClassTeacher[0] = false;
                                    isClassTeacher[1] = true;
                                    isClassTeacher[2] = false;
                                    isClassTeacher[3] = false;
                                    isClassTeacher[4] = false;

                                    isClassTID[0] = 0;
                                    isClassTID[1] = 1;
                                    isClassTID[2] = 0;
                                    isClassTID[3] = 0;
                                    isClassTID[4] = 0;
                                  });
                                } else {
                                  setState(() {
                                    isClassTeacher[1] = false;
                                    isClassTID[1] = 0;
                                  });
                                }
                              }),
                        ),
                      ]),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: new TextEditingController.fromValue(
                                new TextEditingValue(
                                    text: staffsC3.text,
                                    selection: new TextSelection.collapsed(
                                        offset: staffsC3.text.length))),
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 18),
                            onChanged: (value) async {
                              staffsC3.text = value;
                              itemStaffs3.clear();

                              await filterStaffs(value, 3);
                              setState(() {});
                            },
                          ),
                        ),
                        itemStaffs3.length != 0
                            ? Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: itemStaffs3.length,
                                    itemBuilder: (context, i) {
                                      return GestureDetector(
                                          child: ListTile(
                                            title: Text(
                                                "${itemStaffs3[i]["name"]}"),
                                          ),
                                          onTap: () async {
                                            staffsC3.text =
                                                "${itemStaffs3[i]["name"]}";
                                            staffID3 = itemStaffs3[i]["id"];
                                            setState(() {
                                              itemStaffs3.clear();
                                            });
                                          });
                                    }))
                            : Divider(),
                        Expanded(
                          child: MultiSelect(
                            autovalidate: false,
                            titleText: "subject",
                            validator: (value) {
                              if (value == null) {
                                return 'Please select one or more option(s)';
                              }
                            },
                            errorText: 'Please select one or more option(s)',
                            dataSource: itemSubject,
                            textField: 'subject',
                            valueField: 'id',
                            filterable: true,
                            required: true,
                            value: null,
                            onSaved: (value) {},
                            change: (values) {
                              selectedValues2 = values;
                              print(selectedValues2);
                            },
                          ),
                        ),
                        Expanded(
                          child: Checkbox(
                              value: isClassTeacher[2],
                              onChanged: (value) {
                                if (value == true) {
                                  setState(() {
                                    isClassTeacher[0] = false;
                                    isClassTeacher[1] = false;
                                    isClassTeacher[2] = true;
                                    isClassTeacher[3] = false;
                                    isClassTeacher[4] = false;

                                    isClassTID[0] = 0;
                                    isClassTID[1] = 0;
                                    isClassTID[2] = 1;
                                    isClassTID[3] = 0;
                                    isClassTID[4] = 0;
                                  });
                                } else {
                                  setState(() {
                                    isClassTeacher[2] = false;
                                    isClassTID[2] = 0;
                                  });
                                }
                              }),
                        ),
                      ]),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(children: <Widget>[
                        Expanded(
                          child: Container(
                            //height: 100.0,
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                border:
                                    new Border.all(style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(0)),
                            child: TextField(
                              controller: new TextEditingController.fromValue(
                                  new TextEditingValue(
                                      text: staffsC4.text,
                                      selection: new TextSelection.collapsed(
                                          offset: staffsC4.text.length))),
                              keyboardType: TextInputType.text,
                              style: TextStyle(fontSize: 18),
                              onChanged: (value) async {
                                staffsC4.text = value;
                                itemStaffs4.clear();

                                await filterStaffs(value, 4);
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        itemStaffs4.length != 0
                            ? Expanded(
                                child: Container(
                                    height: itemStaffs4.length == 1 ? 100 : 200,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: itemStaffs4.length,
                                        itemBuilder: (context, i) {
                                          return SingleChildScrollView(
                                              child: GestureDetector(
                                                  child: ListTile(
                                                    title: Text(
                                                        "${itemStaffs4[i]["name"]}"),
                                                  ),
                                                  onTap: () async {
                                                    staffsC4.text =
                                                        "${itemStaffs4[i]["name"]}";
                                                    staffID4 =
                                                        itemStaffs4[i]["id"];
                                                    setState(() {
                                                      itemStaffs4.clear();
                                                    });
                                                  }));
                                        })))
                            : Divider(),
                        Expanded(
                          child: MultiSelect(
                            autovalidate: false,
                            titleText: "subject",
                            validator: (value) {
                              if (value == null) {
                                return 'Please select one or more option(s)';
                              }
                            },
                            errorText: 'Please select one or more option(s)',
                            dataSource: itemSubject,
                            textField: 'subject',
                            valueField: 'id',
                            filterable: true,
                            required: true,
                            value: null,
                            onSaved: (value) {},
                            change: (values) {
                              selectedValues3 = values;
                              print(selectedValues3);
                            },
                          ),
                        ),
                        Expanded(
                          child: Checkbox(
                              value: isClassTeacher[3],
                              onChanged: (value) {
                                if (value == true) {
                                  setState(() {
                                    isClassTeacher[0] = false;
                                    isClassTeacher[1] = false;
                                    isClassTeacher[2] = false;
                                    isClassTeacher[3] = true;
                                    isClassTeacher[4] = false;

                                    isClassTID[0] = 0;
                                    isClassTID[1] = 0;
                                    isClassTID[2] = 0;
                                    isClassTID[3] = 1;
                                    isClassTID[4] = 0;
                                  });
                                } else {
                                  setState(() {
                                    isClassTeacher[3] = false;
                                    isClassTID[3] = 0;
                                  });
                                }
                              }),
                        ),
                      ]),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: new TextEditingController.fromValue(
                                new TextEditingValue(
                                    text: staffsC5.text,
                                    selection: new TextSelection.collapsed(
                                        offset: staffsC5.text.length))),
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 18),
                            onChanged: (value) async {
                              staffsC5.text = value;
                              itemStaffs5.clear();

                              await filterStaffs(value, 5);
                              setState(() {});
                            },
                          ),
                        ),
                        itemStaffs5.length != 0
                            ? Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: itemStaffs5.length,
                                    itemBuilder: (context, i) {
                                      return GestureDetector(
                                          child: ListTile(
                                            title: Text(
                                                "${itemStaffs5[i]["name"]}"),
                                          ),
                                          onTap: () async {
                                            staffsC5.text =
                                                "${itemStaffs5[i]["name"]}";
                                            staffID5 = itemStaffs5[i]["id"];
                                            setState(() {
                                              itemStaffs5.clear();
                                            });
                                          });
                                    }))
                            : Divider(),
                        Expanded(
                          child: MultiSelect(
                            autovalidate: false,
                            titleText: "subject",
                            validator: (value) {
                              if (value == null) {
                                return 'Please select one or more option(s)';
                              }
                            },
                            errorText: 'Please select one or more option(s)',
                            dataSource: itemSubject,
                            textField: 'subject',
                            valueField: 'id',
                            filterable: true,
                            required: true,
                            value: null,
                            onSaved: (value) {},
                            change: (values) {
                              selectedValues4 = values;
                              print(selectedValues4);
                            },
                          ),
                        ),
                        Expanded(
                          child: Checkbox(
                              value: isClassTeacher[4],
                              onChanged: (value) {
                                if (value == true) {
                                  setState(() {
                                    isClassTeacher[0] = false;
                                    isClassTeacher[1] = false;
                                    isClassTeacher[2] = false;
                                    isClassTeacher[3] = false;
                                    isClassTeacher[4] = true;

                                    isClassTID[0] = 0;
                                    isClassTID[1] = 0;
                                    isClassTID[2] = 0;
                                    isClassTID[3] = 0;
                                    isClassTID[4] = 1;
                                  });
                                } else {
                                  setState(() {
                                    isClassTeacher[4] = false;
                                    isClassTID[4] = 0;
                                  });
                                }
                              }),
                        ),
                      ]),
                    ),
                    Divider(),

                    /* Row(children: <Widget>[],),
                        Row(children :[]),
                        Row(children :[]),
                        Row(children :[]),
 */
                    /*       TextField(
                                  controller:
                                      new TextEditingController.fromValue(
                                          new TextEditingValue(
                                              text: staffsC2.text,
                                              selection:
                                                  new TextSelection.collapsed(
                                                      offset: staffsC2
                                                          .text.length))),
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(fontSize: 18),
                                  onChanged: (value) async {
                                    staffsC2.text = value;
                                    itemStaffs2.clear();

                                    await filterStaffs(value, 2);
                                    setState(() {});
                                  },
                                ),
                                itemStaffs2.length != 0
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: itemStaffs2.length,
                                        itemBuilder: (context, i) {
                                          return GestureDetector(
                                              child: ListTile(
                                                title: Text(
                                                    "${itemStaffs2[i]["name"]}"),
                                              ),
                                              onTap: () async {
                                                staffsC2.text =
                                                    "${itemStaffs2[i]["name"]}";
                                                staffID2 = itemStaffs2[i]["id"];
                                                setState(() {
                                                  itemStaffs2.clear();
                                                });
                                              });
                                        })
                                    : Divider(),
                                TextField(
                                  controller:
                                      new TextEditingController.fromValue(
                                          new TextEditingValue(
                                              text: staffsC3.text,
                                              selection:
                                                  new TextSelection.collapsed(
                                                      offset: staffsC3
                                                          .text.length))),
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(fontSize: 18),
                                  onChanged: (value) async {
                                    staffsC3.text = value;
                                    itemStaffs3.clear();

                                    await filterStaffs(value, 3);
                                    setState(() {});
                                  },
                                ),
                                itemStaffs3.length != 0
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: itemStaffs3.length,
                                        itemBuilder: (context, i) {
                                          return GestureDetector(
                                              child: ListTile(
                                                title: Text(
                                                    "${itemStaffs3[i]["name"]}"),
                                              ),
                                              onTap: () async {
                                                staffsC3.text =
                                                    "${itemStaffs3[i]["name"]}";
                                                staffID3 = itemStaffs3[i]["id"];
                                                setState(() {
                                                  itemStaffs3.clear();
                                                });
                                              });
                                        })
                                    : Divider(),
                                TextField(
                                  controller:
                                      new TextEditingController.fromValue(
                                          new TextEditingValue(
                                              text: staffsC4.text,
                                              selection:
                                                  new TextSelection.collapsed(
                                                      offset: staffsC4
                                                          .text.length))),
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(fontSize: 18),
                                  onChanged: (value) async {
                                    staffsC4.text = value;
                                    itemStaffs4.clear();

                                    await filterStaffs(value, 4);
                                    setState(() {});
                                  },
                                ),
                                itemStaffs4.length != 0
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: itemStaffs4.length,
                                        itemBuilder: (context, i) {
                                          return GestureDetector(
                                              child: ListTile(
                                                title: Text(
                                                    "${itemStaffs4[i]["name"]}"),
                                              ),
                                              onTap: () async {
                                                staffsC4.text =
                                                    "${itemStaffs4[i]["name"]}";
                                                staffID4 = itemStaffs4[i]["id"];
                                                setState(() {
                                                  itemStaffs4.clear();
                                                });
                                              });
                                        })
                                    : Divider(),
                                TextField(
                                  controller:
                                      new TextEditingController.fromValue(
                                          new TextEditingValue(
                                              text: staffsC5.text,
                                              selection:
                                                  new TextSelection.collapsed(
                                                      offset: staffsC5
                                                          .text.length))),
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(fontSize: 18),
                                  onChanged: (value) async {
                                    staffsC5.text = value;
                                    itemStaffs5.clear();

                                    await filterStaffs(value, 5);
                                    setState(() {});
                                  },
                                ),
                                itemStaffs5.length != 0
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: itemStaffs5.length,
                                        itemBuilder: (context, i) {
                                          return GestureDetector(
                                              child: ListTile(
                                                title: Text(
                                                    "${itemStaffs5[i]["name"]}"),
                                              ),
                                              onTap: () async {
                                                staffsC5.text =
                                                    "${itemStaffs5[i]["name"]}";
                                                staffID5 = itemStaffs5[i]["id"];
                                                setState(() {
                                                  itemStaffs5.clear();
                                                });
                                              });
                                        })
                                    : Divider(),
                        ]
                      ), Row(
                        children: <Widget>[
                          Text("Subject"),
                          
                        ]
                      ), Row(
                        children: <Widget>[
                          Text("Subject"),
                        ]
                      ),
                    ]),
                    
                    */
                    Table(
                        border:
                            TableBorder.all(width: 1.0, color: Colors.black),
                        children: [
                          TableRow(children: [
                            TableCell(
                                child: Column(
                              children: <Widget>[
                                Text("Staff"),
                                Divider(),
                                TextField(
                                  controller:
                                      new TextEditingController.fromValue(
                                          new TextEditingValue(
                                              text: staffsC1.text,
                                              selection:
                                                  new TextSelection.collapsed(
                                                      offset: staffsC1
                                                          .text.length))),
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(fontSize: 18),
                                  onChanged: (value) async {
                                    staffsC1.text = value;
                                    itemStaffs1.clear();

                                    await filterStaffs(value, 1);
                                    setState(() {});
                                  },
                                ),
                                itemStaffs1.length != 0
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: itemStaffs1.length,
                                        itemBuilder: (context, i) {
                                          return GestureDetector(
                                              child: ListTile(
                                                title: Text(
                                                    "${itemStaffs1[i]["name"]}"),
                                              ),
                                              onTap: () async {
                                                staffsC1.text =
                                                    "${itemStaffs1[i]["name"]}";
                                                staffID1 = itemStaffs1[i]["id"];
                                                setState(() {
                                                  itemStaffs1.clear();
                                                });
                                              });
                                        })
                                    : Divider(),
                                TextField(
                                  controller:
                                      new TextEditingController.fromValue(
                                          new TextEditingValue(
                                              text: staffsC2.text,
                                              selection:
                                                  new TextSelection.collapsed(
                                                      offset: staffsC2
                                                          .text.length))),
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(fontSize: 18),
                                  onChanged: (value) async {
                                    staffsC2.text = value;
                                    itemStaffs2.clear();

                                    await filterStaffs(value, 2);
                                    setState(() {});
                                  },
                                ),
                                itemStaffs2.length != 0
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: itemStaffs2.length,
                                        itemBuilder: (context, i) {
                                          return GestureDetector(
                                              child: ListTile(
                                                title: Text(
                                                    "${itemStaffs2[i]["name"]}"),
                                              ),
                                              onTap: () async {
                                                staffsC2.text =
                                                    "${itemStaffs2[i]["name"]}";
                                                staffID2 = itemStaffs2[i]["id"];
                                                setState(() {
                                                  itemStaffs2.clear();
                                                });
                                              });
                                        })
                                    : Divider(),
                                TextField(
                                  controller:
                                      new TextEditingController.fromValue(
                                          new TextEditingValue(
                                              text: staffsC3.text,
                                              selection:
                                                  new TextSelection.collapsed(
                                                      offset: staffsC3
                                                          .text.length))),
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(fontSize: 18),
                                  onChanged: (value) async {
                                    staffsC3.text = value;
                                    itemStaffs3.clear();

                                    await filterStaffs(value, 3);
                                    setState(() {});
                                  },
                                ),
                                itemStaffs3.length != 0
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: itemStaffs3.length,
                                        itemBuilder: (context, i) {
                                          return GestureDetector(
                                              child: ListTile(
                                                title: Text(
                                                    "${itemStaffs3[i]["name"]}"),
                                              ),
                                              onTap: () async {
                                                staffsC3.text =
                                                    "${itemStaffs3[i]["name"]}";
                                                staffID3 = itemStaffs3[i]["id"];
                                                setState(() {
                                                  itemStaffs3.clear();
                                                });
                                              });
                                        })
                                    : Divider(),
                                TextField(
                                  controller:
                                      new TextEditingController.fromValue(
                                          new TextEditingValue(
                                              text: staffsC4.text,
                                              selection:
                                                  new TextSelection.collapsed(
                                                      offset: staffsC4
                                                          .text.length))),
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(fontSize: 18),
                                  onChanged: (value) async {
                                    staffsC4.text = value;
                                    itemStaffs4.clear();

                                    await filterStaffs(value, 4);
                                    setState(() {});
                                  },
                                ),
                                itemStaffs4.length != 0
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: itemStaffs4.length,
                                        itemBuilder: (context, i) {
                                          return GestureDetector(
                                              child: ListTile(
                                                title: Text(
                                                    "${itemStaffs4[i]["name"]}"),
                                              ),
                                              onTap: () async {
                                                staffsC4.text =
                                                    "${itemStaffs4[i]["name"]}";
                                                staffID4 = itemStaffs4[i]["id"];
                                                setState(() {
                                                  itemStaffs4.clear();
                                                });
                                              });
                                        })
                                    : Divider(),
                                TextField(
                                  controller:
                                      new TextEditingController.fromValue(
                                          new TextEditingValue(
                                              text: staffsC5.text,
                                              selection:
                                                  new TextSelection.collapsed(
                                                      offset: staffsC5
                                                          .text.length))),
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(fontSize: 18),
                                  onChanged: (value) async {
                                    staffsC5.text = value;
                                    itemStaffs5.clear();

                                    await filterStaffs(value, 5);
                                    setState(() {});
                                  },
                                ),
                                itemStaffs5.length != 0
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: itemStaffs5.length,
                                        itemBuilder: (context, i) {
                                          return GestureDetector(
                                              child: ListTile(
                                                title: Text(
                                                    "${itemStaffs5[i]["name"]}"),
                                              ),
                                              onTap: () async {
                                                staffsC5.text =
                                                    "${itemStaffs5[i]["name"]}";
                                                staffID5 = itemStaffs5[i]["id"];
                                                setState(() {
                                                  itemStaffs5.clear();
                                                });
                                              });
                                        })
                                    : Divider(),
                              ],
                            )),
                            TableCell(
                              child: Column(
                                children: <Widget>[
                                  Text("subject"),
                                  Divider(),
                                  // func(),
                                  MultiSelect(
                                    autovalidate: false,
                                    titleText: "subject",
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select one or more option(s)';
                                      }
                                    },
                                    errorText:
                                        'Please select one or more option(s)',
                                    dataSource: itemSubject,
                                    textField: 'subject',
                                    valueField: 'id',
                                    filterable: true,
                                    required: true,
                                    value: null,
                                    onSaved: (value) {},
                                    change: (values) {
                                      selectedValues = values;
                                      print(selectedValues);
                                    },
                                  ),

                                  Divider(),
                                  // func(),
                                  MultiSelect(
                                    autovalidate: false,
                                    titleText: "subject",
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select one or more option(s)';
                                      }
                                    },
                                    errorText:
                                        'Please select one or more option(s)',
                                    dataSource: itemSubject,
                                    textField: 'subject',
                                    valueField: 'id',
                                    filterable: true,
                                    required: true,
                                    value: null,
                                    onSaved: (value) {},
                                    change: (values) {
                                      selectedValues1 = values;
                                      print(selectedValues1);
                                    },
                                  ),
                                  Divider(),
                                  // func(),
                                  MultiSelect(
                                    autovalidate: false,
                                    titleText: "subject",
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select one or more option(s)';
                                      }
                                    },
                                    errorText:
                                        'Please select one or more option(s)',
                                    dataSource: itemSubject,
                                    textField: 'subject',
                                    valueField: 'id',
                                    filterable: true,
                                    required: true,
                                    value: null,
                                    onSaved: (value) {},
                                    change: (values) {
                                      selectedValues2 = values;
                                      print(selectedValues2);
                                    },
                                  ),
                                  Divider(),
                                  // func(),
                                  MultiSelect(
                                    autovalidate: false,
                                    titleText: "subject",
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select one or more option(s)';
                                      }
                                    },
                                    errorText:
                                        'Please select one or more option(s)',
                                    dataSource: itemSubject,
                                    textField: 'subject',
                                    valueField: 'id',
                                    filterable: true,
                                    required: true,
                                    value: null,
                                    onSaved: (value) {},
                                    change: (values) {
                                      selectedValues3 = values;
                                      print(selectedValues3);
                                    },
                                  ),
                                  Divider(),
                                  // func(),
                                  MultiSelect(
                                    autovalidate: false,
                                    titleText: "subject",
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select one or more option(s)';
                                      }
                                    },
                                    errorText:
                                        'Please select one or more option(s)',
                                    dataSource: itemSubject,
                                    textField: 'subject',
                                    valueField: 'id',
                                    filterable: true,
                                    required: true,
                                    value: null,
                                    onSaved: (value) {},
                                    change: (values) {
                                      selectedValues4 = values;
                                      print(selectedValues4);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            TableCell(
                              child: Column(
                                children: <Widget>[
                                  Text("IsClassT"),
                                  Divider(),
                                  Checkbox(
                                      value: isClassTeacher[0],
                                      onChanged: (value) {
                                        if (value == true) {
                                          setState(() {
                                            isClassTeacher[0] = true;
                                            isClassTID[0] = 1;
                                          });
                                        } else {
                                          setState(() {
                                            isClassTeacher[0] = false;
                                            isClassTID[0] = 0;
                                          });
                                        }
                                      }),
                                  Divider(),
                                  Checkbox(
                                      value: isClassTeacher[1],
                                      onChanged: (value) {
                                        if (value == true) {
                                          setState(() {
                                            isClassTeacher[1] = true;
                                            isClassTID[1] = 1;
                                          });
                                        } else {
                                          setState(() {
                                            isClassTeacher[1] = false;
                                            isClassTID[1] = 0;
                                          });
                                        }
                                      }),
                                  Divider(),
                                  Checkbox(
                                      value: isClassTeacher[2],
                                      onChanged: (value) {
                                        if (value == true) {
                                          setState(() {
                                            isClassTeacher[2] = true;
                                            isClassTID[2] = 1;
                                          });
                                        } else {
                                          setState(() {
                                            isClassTeacher[2] = false;
                                            isClassTID[2] = 0;
                                          });
                                        }
                                      }),
                                  Divider(),
                                  Checkbox(
                                      value: isClassTeacher[3],
                                      onChanged: (value) {
                                        if (value == true) {
                                          setState(() {
                                            isClassTeacher[3] = true;
                                            isClassTID[3] = 1;
                                          });
                                        } else {
                                          setState(() {
                                            isClassTeacher[3] = false;
                                            isClassTID[3] = 0;
                                          });
                                        }
                                      }),
                                  Divider(),
                                  Checkbox(
                                      value: isClassTeacher[4],
                                      onChanged: (value) {
                                        if (value == true) {
                                          setState(() {
                                            isClassTeacher[4] = true;
                                            isClassTID[4] = 1;
                                          });
                                        } else {
                                          setState(() {
                                            isClassTeacher[4] = false;
                                            isClassTID[4] = 0;
                                          });
                                        }
                                      }),
                                ],
                              ),
                            ),
                          ]),
                        ]),
                    RaisedButton(
                        onPressed: () {
                          count++;
                          print(
                              "$staffID1, $staffID2, $staffID3, $staffID4, $staffID5");
                          print(
                              "$selectedValues, $selectedValues1, $selectedValues2, $selectedValues3, $selectedValues4");
                          print(isClassTID);
                          print(academicYear);
                        },
                        child: Text("ADD")),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: ButtonTheme(
                              minWidth: ScreenUtil().setWidth(400),
                              height: ScreenUtil().setHeight(130),
                              child: RaisedButton(
                                onPressed: () async {
                                  classC.clear();
                                  staffsC1.clear();
                                  staffsC2.clear();
                                  staffsC3.clear();
                                  staffsC4.clear();
                                  staffsC5.clear();
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                color: appcolor,
                                child: Text(
                                  "  CANCEL  ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(50)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: ButtonTheme(
                              minWidth: ScreenUtil().setWidth(400),
                              height: ScreenUtil().setHeight(130),
                              child: RaisedButton(
                                onPressed: () async {
                                  var response = await http.post(
                                      "http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php",
                                      body: jsonEncode({
                                        "action": "mapp_staff_subject",
                                        "schoolid": schoolID,
                                        "mapclassid": classSectionID,
                                        "acyid": await prefs
                                            .getString("AcademicYear"),
                                        "mapstaffid": [
                                          staffID1,
                                          staffID2,
                                          staffID3,
                                          staffID4,
                                          staffID5
                                        ],
                                        "mapsubjectid": [
                                          selectedValues,
                                          selectedValues1,
                                          selectedValues2,
                                          selectedValues3,
                                          selectedValues4
                                        ],
                                        "mapis_classteacher": [
                                          isClassTID[0],
                                          isClassTID[1],
                                          isClassTID[2],
                                          isClassTID[3],
                                          isClassTID[4]
                                        ],
                                      }));

                                  print(
                                      'Response status: ${response.statusCode}');
                                  print('Response body: ${response.body}');
                                  var temp = json.decode(response.body);
                                  print('temp: $temp');
                                  print(academicYear);
                                  print("status");
                                  utilitybasic.toastfun(temp[0]["status"]);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                color: appcolor,
                                child: Text(
                                  "  SAVE  ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(50)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ButtonTheme(
                        minWidth: ScreenUtil().setWidth(400),
                        height: ScreenUtil().setHeight(130),
                        child: RaisedButton(
                          onPressed: () async {
                            Dialog errorDialog = Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0 *
                                          MediaQuery.of(context)
                                              .devicePixelRatio))),
                              child: Container(
                                height: 150.0,
                                color: appcolor,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text("Added Staffs With Classes",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white)),
                                      Text("$academicLabel",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white)),
                                    ]),
                              ),
                            );
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) => errorDialog,
                              barrierDismissible: false,
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          color: appcolor,
                          child: Text(
                            "  View  ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(50)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var selectedValues = new List();
  var selectedValues1 = new List();
  var selectedValues2 = new List();
  var selectedValues3 = new List();
  var selectedValues4 = new List();

  MultiSelect func() {
    return MultiSelect(
      autovalidate: false,
      titleText: "subject",
      validator: (value) {
        if (value == null) {
          return 'Please select one or more option(s)';
        }
      },
      errorText: 'Please select one or more option(s)',
      dataSource: itemSubject,
      textField: 'subject',
      valueField: 'id',
      filterable: true,
      required: true,
      value: null,
      onSaved: (value) {},
      change: (values) {
        selectedValues = values;
        print(selectedValues);
      },
    );
  }
}

int count = 0;

Padding foo() {
  return Padding(
    padding: EdgeInsets.all(10.0),
    child: Row(
      children: <Widget>[Text("Staff1"), Text("Sub1"), Text("IscT11")],
    ),
  );
}
