import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:school/main.dart';

var classSelect;
var sectionSelect;

class MapStudentWithClasses extends StatefulWidget {
  MapStudentWithClasses({Key key}) : super(key: key);

  @override
  _MapStudentWithClassesState createState() => _MapStudentWithClassesState();
}

class _MapStudentWithClassesState extends State<MapStudentWithClasses> {
  var submitTo = new List();
  var studentMaster = new List();
  var studentList = new List();
  var displayListItem = new List();

  var classIDs = new List();
  var sectionIDs = new List();
  var classIDGet = new List();

  var classSelect = "Select";
  var sectionSelect = "Select";
  var classIDConfirm;
  @override
  void initState() {
    super.initState();
    getClass();
  }

  getClass() async {
    var url = "http://13.127.33.107/upload/dhanraj/homework/api/staffapi.php";
    classIDs.add("Select");
    sectionIDs.add("Select");
    classIDGet.add("Select");
    Dio dio = new Dio();
    Response response;

    FormData formData = new FormData.fromMap({
      "action": "get_class_by_group",
      "schoolid": /* "1", // */ schoolID.toString(),
      "staffid":/*  "2", // */ staffID.toString(),
      "acyid": /* "1", // */ academicYear.toString(),
      "is_classteacher": /* "1", // */ isClassTeacher.toString(),
    });

    response = await dio.post(url, data: formData);
    print('Response body: ${response.data}');
    displayListItem = jsonDecode(response.data);
    print(displayListItem);

    for (var i = 0; i < displayListItem.length; i++) {
      classIDs.add("${displayListItem[i]["class"]}");
    }

    print(classIDs);
    setState(() {});
  }

  getSections(String classselect) async {
    for (var i = 0; i < displayListItem.length; i++) {
      if (classselect == "${displayListItem[i]["class"]}") {
        for (var a = 0; a < (displayListItem[i]["section"]).length; a++) {
          sectionIDs.add("${(displayListItem[i]["section"])[a]["section"]}");
          classIDGet.add("${(displayListItem[i]["section"])[a]["classid"]}");
        }
        /* sectionIDs.add("${displayListItem[i]["section"]["section"]}");
        classIDGet.add("${displayListItem[i]["section"]}"); */
      }
    }
    setState(() {});
    print("sectionIDs: $sectionIDs");
    print("classIDGet: $classIDGet");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map Student with class"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text("Academic Year : $academicLabel"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    classIDs == null
                        ? SizedBox()
                        : Expanded(
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
                                    });
                                    getSections(classSelect);
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
                    sectionIDs != null
                        ? Expanded(
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

                                    for (var i = 0;
                                        i < sectionIDs.length;
                                        i++) {
                                      if (sectionSelect == sectionIDs[i]) {
                                        classIDConfirm = classIDGet[i];
                                      }
                                    }
                                    print("classIDGet:: $classIDGet");
                                    get_class_by_group(classIDConfirm);
                                    setState(() {});
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
                          )
                        : SizedBox(),
                  ]),
            ),
            RaisedButton(
                child: Text("SELECT STUDENT"),
                onPressed: () async {
                  await selectStudentsFromMasrter();
                  Dialog errorDialog = Dialog(
                      child: Container(
                          child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      TextField(),
                      ListView.builder(
                          itemCount: studentMaster.length,
                          shrinkWrap: true,
                          itemBuilder: (context, i) {
                            return Card(
                                child: Text("${studentMaster[i]["name"]}"));
                          })
                    ]),
                  )));
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
                  submit = false;
                  setState(() {});
                }),
            studentList.length == 0
                ? Container(child: Text("Select Class & Section"))
                : ListView.builder(
                    itemCount: studentList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Expanded(
                          child:
                              Card(child: Text("${studentList[i]["name"]}")));
                    }),
            RaisedButton(
              child: Text("Submit"),
              onPressed: () async {
                var url =
                    "http://13.127.33.107/upload/dhanraj/homework/api/staffapi.php";
                Dio dio = new Dio();
                Response response;

                FormData formData = new FormData.fromMap({
                  "action": "mapp_student_class",
                  "schoolid": "",
                  "mapclassid": "",
                  "acyid": "",
                  "deletemapid": "",
                });
                response = await dio.post(url, data: formData);
                print('Response body: ${response.data}');
                submitTo = jsonDecode(response.data);
                print("submitTo");
                print(submitTo);
                setState(() {});
              },
            )
          ],
        ),
      )),
    );
  }

  selectStudentsFromMasrter() async {
    var url = "http://13.127.33.107/upload/dhanraj/homework/api/staffapi.php";
    Dio dio = new Dio();
    Response response;

    FormData formData = new FormData.fromMap({
      "action": "get_student_map_list",
      "schoolid": schoolID.toString(),
      "acyid":  academicYear.toString(),
      "classid": "$classIDConfirm",
    });
    response = await dio.post(url, data: formData);
    print('Response body: ${response.data}');
    studentMaster = jsonDecode(response.data);
    print("studentMaster");
    print(studentMaster);
    setState(() {});
  }

  get_class_by_group(String classID) async {
    var url = "http://13.127.33.107/upload/dhanraj/homework/api/staffapi.php";
    Dio dio = new Dio();
    Response response;

    FormData formData = new FormData.fromMap({
      "action": "get_class_by_group",
      "schoolid":/*  "4", // */schoolID.toString(),
      "staffid": /* "51", // */ staffID.toString(),
      "acyid": /* "9", // */ academicYear.toString(),
      "is_classteacher": /* "1", */ isClassTeacher.toString(),
    });
    response = await dio.post(url, data: formData);
    print('Response body: ${response.data}');
    studentList = jsonDecode(response.data);
    print("studentList");
    print(studentList);
    setState(() {
      studentList = jsonDecode(response.data);
    });
  }

  bool submit = false;
}

var studentList = new List();
var classIDs, sectionIDs = new List();

/* 

      "action" : "get_student_map_list",
        "schoolid" : school_id,
        "classid" : class_id,
        "acyid" : acy_id,
 */
