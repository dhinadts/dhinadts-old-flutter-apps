import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:school/db/utility_basics.dart';
import 'package:school/main.dart';

import 'ScreenUtil.dart';
import 'package:http/http.dart' as http;

int selectedRadio;

enum attendance { present, absent }

var utilitybasic = Utility_Basic();
var attendanceSelect = new List();

class Attendance extends StatefulWidget {
  @override
  AttendanceReg createState() {
    return new AttendanceReg();
  }
}

class AttendanceReg extends State<Attendance> {
  TextEditingController fromAcadYear = new TextEditingController();
  TextEditingController toAcadYear = new TextEditingController();
  TextEditingController classC = new TextEditingController();
  TextEditingController sectionsC = new TextEditingController();
  attendance attendanceGroup;
  var attendanceGroupValue = new List();
  var classSelection = new List();
  var itemsClassSection = new List();
  var classSectionID;
  var classStudents = new List();
  var checkBoxArray = new List();
  var todayDate;
  var gotAttendance = new List();
  var gotStudentIDs = new List();

  /* setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  } */

  @override
  void initState() {
    super.initState();
    // attendanceList();
    dateCheck();
  }

  dateCheck() async {
    var now1 = DateTime.now();
    todayDate = DateFormat("dd\/MM\/yyyy").format(now1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            "Attendance",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: ScreenUtil().setSp(60)),
          ),
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
                  "Attendance",
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
                    Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(10.0), // (10.0),
                          padding: const EdgeInsets.all(10.0),
                          height: 50,
                          width: 150,
                          child: Align(
                              alignment: Alignment.center,
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
                                  // await filterAll(value);
                                  setState(() {});
                                },
                              )),
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: new Border.all(style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10.0), // (10.0),
                          padding: const EdgeInsets.all(10.0),
                          height: 50,
                          width: 150,
                          child: Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                                child: Text("send Class ID"),
                                onTap: () async {
                                  print("object");
                                }),
                          ),
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: new Border.all(style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ],
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
                                      "",
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
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            border: new Border.all(style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "Date :",
                                    style: TextStyle(fontSize: 20),
                                  )),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text("$todayDate"),
                            )
                          ],
                        ),
                      ),
                    ),

                    /* Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "From :",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: fromAcadYear,
                                decoration: InputDecoration(
                                  hintText: "dd/yyyy",
                                ),
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ), */
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Image",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Student Details",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(children: <Widget>[
                              Text(
                                "Attendance",
                                style: TextStyle(fontSize: 20),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text(
                              "",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                                icon: Icon(Icons.help),
                                onPressed: () {
                                  utilitybasic.toastfun(
                                      "Checked is Present and Unchecked is absent");
                                }),
                          ),
                        ],
                      ),
                    ),
                    classStudents.length != 0
                        ? Container(
                            height: 250.0,
                            child: SingleChildScrollView(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: classStudents.length,
                                  itemBuilder: (context, i) {
                                    return Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    15.0)),
                                        elevation: 20.0,
                                        margin: EdgeInsets.only(
                                            top: 5.0,
                                            left: 5.0,
                                            right: 5.0,
                                            bottom: 5.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.network(
                                                    "${classStudents[i]['profile']}",
                                                    height: ScreenUtil()
                                                        .setHeight(200),
                                                    width: ScreenUtil()
                                                        .setWidth(200),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "${classStudents[i]['view_txt']}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Theme(
                                                      data: ThemeData(
                                                          unselectedWidgetColor:
                                                              Colors.black),
                                                      child: Checkbox(
                                                          value:
                                                              checkBoxArray[i]
                                                                  ["checkBool"],
                                                          onChanged: (value) {
                                                            if (value == true) {
                                                              checkBoxArray[i][
                                                                      "checkID"] =
                                                                  classStudents[
                                                                          i][
                                                                      'studentid'];
                                                              setState(() {
                                                                checkBoxArray[i]
                                                                        [
                                                                        "checkBool"] =
                                                                    true;
                                                                checkBoxArray[i]
                                                                    [
                                                                    "checkValue"] = 1;
                                                                // checkBoxArray[i]["checkID"] = classStudents[i]['studentid'];

                                                                /* gotStudentIDs.add(
                                                            classStudents[i]
                                                                ['studentid']);
                                                        gotAttendance.add(
                                                            checkBoxArray[i]
                                                                ["checkValue"]); */
                                                              });
                                                            } else {
                                                              setState(() {
                                                                checkBoxArray[i]
                                                                        [
                                                                        "checkBool"] =
                                                                    false;
                                                                checkBoxArray[i]
                                                                    [
                                                                    "checkValue"] = 2;

                                                                /* gotStudentIDs.add(
                                                            classStudents[i]
                                                                ['studentid']);
                                                        gotAttendance.add(
                                                            checkBoxArray[i]
                                                                ["checkValue"]); */
                                                              });
                                                            }
                                                          }))),
                                            ],
                                          ),
                                        ));
                                  }),
                            ))
                        : SizedBox(),
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
                                  fromAcadYear.clear();
                                  toAcadYear.clear();
                                  classC.clear();
                                  sectionsC.clear();
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
                                  var list1 = new List();
                                  var list2 = new List();
                                  for (var i = 0;
                                      i < classStudents.length;
                                      i++) {
                                    list1.add(classStudents[i]['studentid']);
                                    list2.add(checkBoxArray[i]["checkValue"]);
                                  }
                                  print(list1);
                                  print(list2);

                                  var response = await http.post(
                                      "http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php",
                                      body: jsonEncode({
                                        "action": "insert_attendance",
                                        "classid": classSectionID,
                                        "acyid": academicYear,
                                        "schoolid": schoolID,
                                        "atstudentid": list1,
                                        "atstatus": list2
                                      }));

                                  print(
                                      'Response status: ${response.statusCode}');
                                  print('Response body: ${response.body}');
                                  var temp = json.decode(response.body);
                                  print('temp: $temp');
                                  print("status");
                                  if (temp[0]["status"] == "sucess") {
                                    utilitybasic.toastfun(
                                        "Attendance submitted/Updated successfully");
                                  } else {
                                    utilitybasic.toastfun("Dup[licate Student");
                                  }
                                  /* print(checkBoxArray);
                                  print(gotAttendance);
                                  print(gotStudentIDs); */
                                  // print(checkBoxArray["checkID"]);
                                  /* gotAttendance.clear();
                                  gotStudentIDs.clear();
                                  checkBoxArray.clear(); */
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  

}
