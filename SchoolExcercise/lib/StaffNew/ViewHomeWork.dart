import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school/main.dart';

class ViewHomeWork extends StatefulWidget {
  ViewHomeWork({Key key}) : super(key: key);

  @override
  _ViewHomeWorkState createState() => _ViewHomeWorkState();
}

class _ViewHomeWorkState extends State<ViewHomeWork> {
  TextEditingController dateC = new TextEditingController();
  var classIDConfirm;
  var subjectList = new List();
  var displayListItem = new List();

  var classIDs = new List();
  var sectionIDs = new List();
  var classIDGet = new List();

  var classSelect = "Select";
  var sectionSelect = "Select";
  var todayDate;
  var birthDateInString1 = "Select Date";

  @override
  void initState() {
    super.initState();
    getClass();
    dateCheck();
  }

  dateCheck() async {
    var now1 = DateTime.now();
    todayDate = DateFormat("dd\/MM\/yyyy").format(now1);
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
      appBar: AppBar(title: Text("View HomeWork")),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
        Text("Academic Year $academicYear"),

         Padding(
          padding: const EdgeInsets.all(8.0),
          child: Expanded(
                      child: TextField(
              controller: dateC,
              decoration: InputDecoration(
                labelText: birthDateInString1,
                 suffixIcon: IconButton(
                        icon: Icon(Icons.date_range),
                        onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            DateTime birthDate; // instance of DateTime
                            final datePick = await showDatePicker(
                                context: context,
                                initialDate: new DateTime.now(),
                                firstDate: new DateTime(1900),
                                lastDate: new DateTime(2100));
                            if (datePick != null && datePick != birthDate) {
                              setState(() {
                                birthDate = datePick;
                                birthDateInString1 =
                                   new DateFormat("yyyy\/MM\/dd").format(birthDate);
                                todayDate = birthDateInString1;
                                // "${birthDate.day}/${birthDate.month}/${birthDate.year}"; // 08/14/2019
                              });
                            }
                            setState(() {});
                        }),
              ),
            ),
          ),
        ), 
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

                                for (var i = 0; i < sectionIDs.length; i++) {
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
        subjectList == null
            ? SizedBox()
            : ListView.builder(
                itemCount: subjectList.length,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  var z = subjectList[i]["file_urls"].split(",");
                  print("zzzzzzzzz $z");
                  return Expanded(
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                      Text("${subjectList[i]["subjectname"]}", textAlign: TextAlign.left, style: TextStyle()),
                      Text("${subjectList[i]["title"]}"),
                      Text("${subjectList[i]["description"]}"),
                      for(var a = 0; a < z.length; a++)
                      Column(children : [Text("${z[a]}"),Divider()]),
                      
                      
                      ],),
                      
                    ),
                  );
                }),
      ]))),
    );
  }

 getStudentList(String classID) async {
    var url = "http://13.127.33.107/upload/dhanraj/homework/api/staffapi.php";
    Dio dio = new Dio();
    Response response;
    
    FormData formData = new FormData.fromMap({
      "action": "view_homework",
      "schoolid": "$schoolID", // .toString(),
      "hwdate" : "$todayDate", // .toString(),
      "acyid": "$academicYear", // .toString(),
      "classid": "$classIDConfirm"
      
        
    });
    response = await dio.post(url, data: formData);
    print('Response body: ${response.data}');
    subjectList = jsonDecode(response.data);
    print(subjectList);
    for (var i = 0; i < subjectList.length; i++) {

    }
    setState(() {});
  }
}
