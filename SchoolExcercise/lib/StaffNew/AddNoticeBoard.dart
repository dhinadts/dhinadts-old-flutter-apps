import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school/StaffNew/ViewNoticeBoard.dart';
import 'package:school/assignhomework.dart';
import 'package:school/main.dart';

class AddNoticeBoard extends StatefulWidget {
  AddNoticeBoard({Key key}) : super(key: key);

  @override
  _AddNoticeBoardState createState() => _AddNoticeBoardState();
}

class _AddNoticeBoardState extends State<AddNoticeBoard> {
  TextEditingController titleC = new TextEditingController();
  TextEditingController descC = new TextEditingController();

  bool image1 = false;
  bool image2 = false;
  bool image3 = false;
  bool image4 = false;
  bool image5 = false;

  String image1Src, image2Src, image3Src, image4Src, image5Src;
  File image1File, image2File, image3File, image4File, image5File;
  var todayDate;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add NoticeBoard"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => /* AssignHomework */ViewNoticeBoard()),
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
              controller: titleC,
              maxLines: 2,
              decoration: InputDecoration(labelText: "Title"),
            ), // date
            TextFormField(
              decoration: InputDecoration(labelText: "Description"),
              controller: descC,
              maxLines: 5,
            ),

            RaisedButton(child: Text("Upload Files"), onPressed: () async {}),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                verticalDirection: VerticalDirection.up,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        image1File = await FilePicker.getFile();
                        setState(() {
                          image1 = true;
                          image1Src = image1File.path;
                        });
                      },
                      child: Container(
                        height: 80.0,
                        width: 80.0,
                        decoration: new BoxDecoration(
                          image: image1 == true
                              ? new DecorationImage(
                                  image: new AssetImage(image1Src),
                                  fit: BoxFit.cover,
                                )
                              : new DecorationImage(
                                  image: new AssetImage("assets/addfile.png"),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        child: Stack(children: [
                          Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: IconButton(
                                    icon: Icon(Icons.close,
                                        color: Colors.orangeAccent),
                                    onPressed: () {
                                      setState(() {
                                        image1Src = "assets/addfile.png";
                                      });
                                    }),
                              )),
                        ]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        image2File = await FilePicker.getFile();
                        setState(() {
                          image2 = true;
                          image2Src = image2File.path;
                        });
                      },
                      child: Container(
                        height: 80.0,
                        width: 80.0,
                        decoration: new BoxDecoration(
                          image: image2 == true
                              ? new DecorationImage(
                                  image: new AssetImage(image2Src),
                                  fit: BoxFit.cover,
                                )
                              : new DecorationImage(
                                  image: new AssetImage("assets/addfile.png"),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        child: Stack(children: [
                          Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: IconButton(
                                    icon: Icon(Icons.close,
                                        color: Colors.orangeAccent),
                                    onPressed: () {
                                      setState(() {
                                        image2Src = "assets/addfile.png";
                                      });
                                    }),
                              )),
                        ]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        image3File = await FilePicker.getFile();
                        setState(() {
                          image3 = true;
                          image3Src = image3File.path;
                        });
                      },
                      child: Container(
                        height: 80.0,
                        width: 80.0,
                        decoration: new BoxDecoration(
                          image: image3 == true
                              ? new DecorationImage(
                                  image: new AssetImage(image3Src),
                                  fit: BoxFit.cover,
                                )
                              : new DecorationImage(
                                  image: new AssetImage("assets/addfile.png"),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        child: Stack(children: [
                          Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: IconButton(
                                    icon: Icon(Icons.close,
                                        color: Colors.orangeAccent),
                                    onPressed: () {
                                      setState(() {
                                        image3Src = "assets/addfile.png";
                                      });
                                    }),
                              )),
                        ]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        image4File = await FilePicker.getFile();
                        setState(() {
                          image4 = true;
                          image4Src = image4File.path;
                        });
                      },
                      child: Container(
                        height: 80.0,
                        width: 80.0,
                        decoration: new BoxDecoration(
                          image: image4 == true
                              ? new DecorationImage(
                                  image: new AssetImage(image4Src),
                                  fit: BoxFit.cover,
                                )
                              : new DecorationImage(
                                  image: new AssetImage("assets/addfile.png"),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        child: Stack(children: [
                          Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: IconButton(
                                    icon: Icon(Icons.close,
                                        color: Colors.orangeAccent),
                                    onPressed: () {
                                      setState(() {
                                        image4Src = "assets/addfile.png";
                                      });
                                    }),
                              )),
                        ]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        image5File = await FilePicker.getFile();
                        setState(() {
                          image5 = true;
                          image5Src = image5File.path;
                        });
                      },
                      child: Container(
                        height: 80.0,
                        width: 80.0,
                        decoration: new BoxDecoration(
                          image: image5 == true
                              ? new DecorationImage(
                                  image: new AssetImage(image5Src),
                                  fit: BoxFit.cover,
                                )
                              : new DecorationImage(
                                  image: new AssetImage("assets/addfile.png"),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        child: Stack(children: [
                          Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: IconButton(
                                    icon: Icon(Icons.close,
                                        color: Colors.orangeAccent),
                                    onPressed: () {
                                      setState(() {
                                        image5Src = "assets/addfile.png";
                                      });
                                    }),
                              )),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  startDate == ""
                      ? Expanded(
                          flex: 1,
                          child: GestureDetector(
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
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
                                        new DateFormat("yyyy\/MM\/dd")
                                            .format(birthDate);
                                    startDate = birthDateInString1;
                                    // "${birthDate.day}/${birthDate.month}/${birthDate.year}"; // 08/14/2019
                                  });
                                }
                                setState(() {});
                              },
                              child: Text("START DATE",
                                  textAlign: TextAlign.center,
                                  style: TextStyle())))
                      : Expanded(
                          flex: 1,
                          child: Text("$startDate",
                              textAlign: TextAlign.center, style: TextStyle())),
                  endDate == ""
                      ? Expanded(
                          flex: 1,
                          child: GestureDetector(
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
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
                                        new DateFormat("yyyy\/MM\/dd")
                                            .format(birthDate);
                                    endDate = birthDateInString1;
                                    // "${birthDate.day}/${birthDate.month}/${birthDate.year}"; // 08/14/2019
                                  });
                                }
                                setState(() {});
                              },
                              child: Text("END DATE",
                                  textAlign: TextAlign.center,
                                  style: TextStyle())))
                      : Expanded(
                          flex: 1,
                          child: Text("$endDate",
                              textAlign: TextAlign.center, style: TextStyle())),
                ],
              ),
            ),
            RaisedButton(
                child: Text("SELECT CLASS & SECTION"),
                onPressed: () async {
                  print("SELECT CLASS AND SECTIONS");
                }),
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
                                borderRadius: BorderRadius.circular(0.0),
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
                                borderRadius: BorderRadius.circular(0.0),
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
                                    // getStudentList(classIDConfirm);
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
                child: Text("SAVE"),
                onPressed: () async {
                  print(
                      "Attached Files:: $image1File, $image2File, $image3File, $image4File, $image5File");
                  functionAddIMages(image1File);
                  functionAddIMages(image2File);
                  functionAddIMages(image3File);
                  functionAddIMages(image4File);
                  functionAddIMages(image5File);
                  String url =
                      "http://13.127.33.107/upload/dhanraj/homework/api/android.php";
                  setState(() {});
                  Dio dio = new Dio();
                  Response response;
                  /* FormData formData = await formData1(); */

                  FormData formData = new FormData.fromMap({
                    "action": "insert_notice_board",
                    "schoolid": schoolID.toString(),
                    "acyid": academicYear.toString(),
                    "staffid": staffID.toString(),
                    "type": "2",
                    "title": titleC.text,
                    "description": descC.text,
                    "nbclassid": "$classIDConfirm",
                    "startdate": startDate.toString(),
                    "enddate": endDate.toString(),
                    "editurl": "",
                    "editid": "",
                    "images": fileArrays,
                  });
                  response = await dio.post(url, data: formData);
                  print(
                      'Adding Notice Board:....   Response body: ${response.data}');
                  functionClear();
                }),
          ],
        ),
      )),
    );
  }

  List fileArrays = [];
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

  functionAddIMages(File file) async {
    if (file == null) {
    } else {
      fileArrays.add(await MultipartFile.fromFile("${file.path}",
          filename: "${path.basename(file.path)}"));
    }
    print(fileArrays);
  }

  functionClear() async {
    fileArrays.clear();
    subjectList.clear();
    displayListItem.clear();
    classIDs.clear();
    sectionIDs.clear();
    classIDGet.clear();
    startDate = "";
    endDate = "";
    setState(() {
      
    });
  }
}

String startDate = "";
String endDate = "";
var classIDConfirm;
var subjectList = new List();
var displayListItem = new List();

var classIDs = new List();
var sectionIDs = new List();
var classIDGet = new List();

var classSelect = "Select";
var sectionSelect = "Select";

var birthDateInString1 = "Select Date";
