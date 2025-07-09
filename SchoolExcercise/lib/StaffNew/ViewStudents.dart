import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ViewStudents extends StatefulWidget {
  ViewStudents({Key key}) : super(key: key);

  @override
  _ViewStudentsState createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {
  var studentList = new List();
  var displayListItem = new List();

  var classIDs = new List();
  var sectionIDs = new List();
  var classIDGet = new List();

  var classSelect = "Select";
  var sectionSelect = "Select";

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
      "staffid": /* "2", //  */ staffID.toString(),
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
        for (var a = 0; a < displayListItem[i]["section"].length; a++) {
          sectionIDs.add("${displayListItem[i]["section"][a]["section"]}");
          classIDGet.add("${displayListItem[i]["section"][a]["classid"]}");
        }
        /* sectionIDs.add("${displayListItem[i]["section"]["section"]}");
        classIDGet.add("${displayListItem[i]["section"]}"); */
      }
    }
    setState(() {});
    print(sectionIDs);
    print(classIDGet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("View Students ")),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
          children: <Widget>[
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
                                    getStudentList(classIDConfirm);
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
            studentList == null
                ? Center(
                    child: Text("Choose Class & Section"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: studentList.length,
                    itemBuilder: (context, i) {
                      return Expanded(
                        child: Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "Reg no: ${studentList[i]["reg_number"]}"),
                                    Text("Name  : ${studentList[i]["name"]}"),
                                    Text("Mobile: ${studentList[i]["mobile"]}"),
                                  ]),
                              RaisedButton(
                                  child: Text("Message"),
                                  onPressed: () async {
                                    Dialog errorDialog = Dialog(
                                        child: Container(
                                            child: SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          Text("Message"),
                                          Text(
                                              "Name: ${studentList[i]["name"]}"),
                                          Text(
                                              "Class : $classSelect - $sectionSelect"),
                                          TextFormField(
                                            controller: messageToStuC,
                                            maxLines: 5,
                                            decoration: InputDecoration(
                                              labelText: "Enter Your Message",
                                            ),
                                          ),
                                          RaisedButton(
                                              child: Text("SEND"),
                                              onPressed: () async {

                                                var url =
                                                    "http://13.127.33.107/upload/dhanraj/homework/api/staffapi.php";
                                                Dio dio = new Dio();
                                                Response response;

                                                FormData formData =
                                                    new FormData.fromMap({
                                                  "action": "send_msg",
                                                  "schoolid": /* "1", // */ schoolID
                                                      .toString(),
                                                  "staffid": /* "2", // */ staffID
                                                      .toString(),
                                                  "acyid": /* "1", // */ academicYear
                                                      .toString(),
                                                  "classid": "$classIDConfirm",
                                                  "studentid":
                                                      "${studentList[i]['studentid']}",
                                                  "message": messageToStuC.text,
                                                });
                                                response = await dio.post(url,
                                                    data: formData);
                                                print(
                                                    'Response body: ${response.data}');
                                                utilitybasic.toastfun('"${messageToStuC.text} sent to "${studentList[i]['name']}"');
                                                setState(() {});
                                                /* 
                                                 map.put("action", "send_msg");
        map.put("schoolid", sharedPreference.getString(ViewClass_studentActivity.this, "schoolid"));
        map.put("staffid", sharedPreference.getString(ViewClass_studentActivity.this, "staffid"));
        map.put("acyid", sharedPreference.getString(ViewClass_studentActivity.this, "staff_acyid"));
        map.put("classid", classIdStr);
        map.put("studentid", studentID);
        map.put("message", message);
         */
                                              })
                                        ],
                                      ),
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
                                  }),
                            ],
                          ), // Text("${studentList[i]["name"]}"),
                        ),
                      );
                    })
          ],
        ))));
  }

  getStudentList(String classID) async {
    var url = "http://13.127.33.107/upload/dhanraj/homework/api/staffapi.php";
    Dio dio = new Dio();
    Response response;

    FormData formData = new FormData.fromMap({
      "action": "get_class_vise_student",
      "schoolid": /* "1", // */ schoolID.toString(),
      "staffid": /* "2", // */ staffID.toString(),
      "acyid": /* "1", // */ academicYear.toString(),
      "classid": "$classIDConfirm",
    });
    response = await dio.post(url, data: formData);
    print('Response body: ${response.data}');
    studentList = jsonDecode(response.data);
    print(studentList);
    setState(() {});
  }
}

var classIDConfirm;
TextEditingController messageToStuC = new TextEditingController();
