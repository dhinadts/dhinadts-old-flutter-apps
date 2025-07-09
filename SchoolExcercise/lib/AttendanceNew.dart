import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school/main.dart';

class AttendanceNew extends StatefulWidget {
  AttendanceNew({Key key}) : super(key: key);

  @override
  _AttendanceNewState createState() => _AttendanceNewState();
}

enum AttendanceEnum { present, absent }

class _AttendanceNewState extends State<AttendanceNew> {
  TextEditingController dateC = new TextEditingController();
  DateTime birthDate; // instance of DateTime
  String birthDateInString1 = "Select Date";

  var classIDConfirm;
  var studentList = new List();
  var studentAttendaceList = new List();
  var displayListItem = new List();

  var classIDs = new List();
  var sectionIDs = new List();
  var classIDGet = new List();

  var classSelect = "Select";
  var sectionSelect = "Select";
  var todayDate;
  @override
  void initState() {
    super.initState();
    getClass();
    dateCheck();
  }

  @override
  void dispose() {
    super.dispose();
    files.clear();
    // getClass();
  }

  dateCheck() async {
    var now1 = DateTime.now();
    birthDateInString1 = DateFormat("dd\/MM\/yyyy").format(now1);
    setState(() {});
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
      "schoolid": schoolID.toString(),
      "staffid": staffID.toString(),
      "acyid": academicYear.toString(),
      "is_classteacher": isClassTeacher.toString(),
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
      appBar: AppBar(
        title: Text("Attendance New"),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.remove_red_eye,
              ),
              onPressed: () async {
                // view
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => null),
                  // ViewStaffDetails()),
                );
              })
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: dateC,
              keyboardType: TextInputType.datetime,
              style: TextStyle(fontSize: 20, height: 1.5),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: appcolor),
                ),
                hintText: birthDateInString1,
                contentPadding: EdgeInsets.all(8.0),
                suffix: Padding(
                  padding: EdgeInsets.only(top: 30.0),
                ),
                suffixIcon: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.calendar_today,
                      size: 25.0,
                    ),
                  ),
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    final datePick = await showDatePicker(
                        context: context,
                        initialDate: new DateTime.now(),
                        firstDate: new DateTime(1900),
                        lastDate: new DateTime(2100));
                    if (datePick != null && datePick != birthDate) {
                      setState(() {
                        birthDate = datePick;
                        birthDateInString1 =
                            new DateFormat("yyyy-MM-dd").format(birthDate);
                        dateC.text = birthDateInString1;
                        // "${birthDate.day}/${birthDate.month}/${birthDate.year}"; // 08/14/2019
                      });
                    }
                  },
                ),
              ),
            ), // date
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
                                    print("classIDGet:: $classIDConfirm");
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

            studentList.length == 0
                ? SizedBox()
                : ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: studentList.length,
                    itemBuilder: (context, i) {
                      return Expanded(
                        child: Card(
                          child: ListTile(
                              leading: Image.network(studentList[i]["profile"]),
                              title: Text("${studentList[i]["name"]}"),
                              subtitle: Text("${studentList[i]["reg_number"]}"),
                              /* trailing:  Column(
                              children: <Widget>[
                                Expanded(
                                  child: Radio(
                                    value: AttendanceEnum.present,
                                    groupValue: AttendanceEnum.present,
                                    onChanged: (AttendanceEnum present) {
                                      setState(() {
                                        studentAttendaceList[i]["atstatus"] =
                                            "1";
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Radio(
                                    value: AttendanceEnum.absent,
                                    groupValue: AttendanceEnum.absent,
                                    onChanged: (AttendanceEnum absent) {
                                      setState(() {
                                        studentAttendaceList[i]["atstatus"] =
                                            "2";
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ), */
                              trailing: Checkbox(
                                  value: studentAttendaceList[i]["checkBool"],
                                  onChanged: (value) {
                                    setState(() {
                                      studentAttendaceList[i]["checkBool"] =
                                          value;
                                    });
                                    if (value == true) {
                                      studentAttendaceList[i]["atstatus"] = "1";
                                      // studentList[i]["atstatus"] = "1";

                                    } else {
                                      studentAttendaceList[i]["atstatus"] = "2";
                                      // studentList[i]["atstatus"] = "2";

                                    }
                                  })),
                        ),
                      );
                    }),
            RaisedButton(
                child: Text("Submit Attendance"),
                onPressed: () async {
                  setState(() {});
                  for (var i = 0; i < studentList.length; i++) {
                    studentIDS.add(studentAttendaceList[i]["studentid"]);
                    studentStatus.add(studentAttendaceList[i]["atstatus"]);
                  }
                  print("studentIDS");
                  print(studentIDS);
                  print("studentStatus");
                  print(studentStatus);
                  utilitybasic.toastfun(
                      "studentIDS: $studentIDS, studentStatus: $studentStatus");
                  /*  var url =
                      "http://13.127.33.107/upload/dhanraj/homework/api/staffapi.php";
                  Dio dio = new Dio();
                  Response response;
                  subjects.add("Select");
                  subjectsID.add("Select");
                  FormData formData = new FormData.fromMap({
                    "action": "insert_attendance",
                    "schoolid": schoolID.toString(),
                    "classid": classIDConfirm.toString(),
                    "acyid": academicYear.toString(),
                    "staffid": staffID.toString(),
                    "adate": birthDateInString1,
                    "atstudentid": studentIDS,
                    "atstatus": studentStatus,
                  });
                  response = await dio.post(url, data: formData);
                  print('Response body: ${response.data}');
                  studentList = jsonDecode(response.data);
                  print(studentList); */

                  setState(() {});
                  studentIDS.clear();
                  studentStatus.clear();
                }),
          ],
        ),
      )),
    );
  }

  getStudentList(String classID) async {
    var url = "http://13.127.33.107/upload/dhanraj/homework/api/staffapi.php";
    Dio dio = new Dio();
    Response response;
    subjects.add("Select");
    subjectsID.add("Select");
    FormData formData = new FormData.fromMap({
      "action": "get_attendance_list",
      "schoolid": "$schoolID", // .toString(),
      "acyid": "$academicYear", // .toString(),
      "classid": "$classIDConfirm", // .toString(),
      "adate": "",
    });
    response = await dio.post(url, data: formData);
    print('Response body: ${response.data}');
    studentList = jsonDecode(response.data);
    print(studentList);
    for (var i = 0; i < studentList.length; i++) {
      studentAttendaceList.add({
        "studentid": "${studentList[i]["studentid"]}",
        "atstatus": "${studentList[i]["atstatus"]}",
        "checkBool": studentList[i]["atstatus"] == "1" ? true : false,
      });
    }

    setState(() {});
  }

  var studentStatus = new List();
  var studentIDS = new List();
  String subjectListDefault = "Select";
  var subjects = new List();
  var subjectsID = new List();
  var confirmSubjectID;
  TextEditingController titleC = new TextEditingController();
  TextEditingController descC = new TextEditingController();
  List<File> files = [];
  var filePaths = new List();
  var subjectList1 = new List();
  var widgetList = new List();
  List fileArrays = [];
}
