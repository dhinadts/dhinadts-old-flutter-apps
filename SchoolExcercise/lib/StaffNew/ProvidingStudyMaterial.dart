import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:school/StaffNew/ViewStudyMaterial.dart';
import 'package:school/main.dart';

class ProvidingStudyMaterial extends StatefulWidget {
  ProvidingStudyMaterial({Key key}) : super(key: key);

  @override
  _ProvidingStudyMaterialState createState() => _ProvidingStudyMaterialState();
}

class _ProvidingStudyMaterialState extends State<ProvidingStudyMaterial> {
  TextEditingController dateC = new TextEditingController();
  DateTime birthDate; // instance of DateTime
  String birthDateInString1 = "Select Date";

  var classIDConfirm;
  var subjectList = new List();
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
      appBar: AppBar(
        title: Text("ProvidingStudyMaterial"),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.remove_red_eye,
              ),
              onPressed: () async {
                // view
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewStudyMaterial()),
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
                            new DateFormat("yyyy\/MM\/dd").format(birthDate);
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
            subjectList == null
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Expanded(
                        flex: 1,
                        child: DropdownButton(
                          elevation: 0,
                          underline: Container(),
                          isExpanded: true,
                          isDense: true,
                          value: subjectListDefault,
                          onChanged: (newValue) {
                            setState(() {
                              subjectListDefault = newValue;
                            });
                            for (var i = 0; i < subjects.length; i++) {
                              if (subjectListDefault == subjects[i]) {
                                confirmSubjectID = subjectsID[i];
                              }
                            }
                            print("confirmSubjectID: $confirmSubjectID");
                          },
                          items: subjects.map((sections) {
                            return DropdownMenuItem(
                              child: new Text(sections),
                              value: sections,
                            );
                          }).toList(),
                        )),
                  ),
            TextFormField(
              controller: titleC,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              controller: descC,
            ),
            RaisedButton(
                child: Text("UPLOAD FILES"),
                onPressed: () async {
                  
                  files = await FilePicker.getMultiFile(
                    type: FileType.any,
                    // allowedExtensions: ['jpg', 'pdf', 'doc', 'docx', 'mp3',  'aac', 'avi', 'mpeg4' ],);
                  );
                  print(files);
                  setState(() {});
                  for (var i = 0; i < files.length; i++) {
                    filePaths.add(path.basename(files[i].path));
                    /*  print(path.basename(files[i].path));
                    print(files[i].path); */
                    /*     widgetList.add(
                      'await MultipartFile.fromFile("${files[i].path}", filename: "${filePaths[i]}")',
                    ); */
                    /* fileArrays.add(MultipartFile.fromFile("${files[i].path}",
                        filename: "${path.basename(files[i].path)}")); */
                    fileArrays.add(await MultipartFile.fromFile(
                        "${files[i].path}",
                        filename: "${path.basename(files[i].path)}"));
                  }
                  /*  print("filePaths $filePaths"); */
                  print("widgetList:: $fileArrays");
                  setState(() {});
                }),
            files.length == 0
                ? SizedBox()
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: filePaths.length,
                    itemBuilder: (context, i) {
                      return Expanded(
                        child: Card(
                          child: ListTile(
                            leading: Icon(Icons.image),
                            title: Text("${filePaths[i]}"),
                            subtitle: Text("$subjectListDefault"),
                            trailing: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () async {
                                  /* final dir =
                                      await getExternalStorageDirectory();
                                  final Directory output =
                                      await getTemporaryDirectory();
                                  print(output);
                                  print(dir); */
                                 /*  final Directory extDir =
                                      await getTemporaryDirectory();
                                  final String dirPath =
                                      '${extDir.path}\/file_picker\/';
                                  await new Directory(dirPath)
                                      .create(recursive: true);
                                  final dir = Directory(dirPath);
                                  dir.deleteSync(recursive: true); */
                                  
                                  /* fileArrays.remove(await MultipartFile.fromFile(
                                    "${files[i].path}",
                                    filename:
                                        "${path.basename(files[i].path)}"));
                                files.remove(files[i]); */
                                print("FILES[i]:: ");
                                print(files[i]);
                                
                                  setState(() {
                                files.remove(files[i]);
                                  });
                                  print("FILES:: ");
                                  print(files);
                                }),
                          ),
                        ),
                      );
                    }),
            RaisedButton(
                child: Text("Assign"),
                onPressed: () async {
                  print(
                      '$academicYear, $schoolID, $classIDConfirm, $staffID, $confirmSubjectID, ${titleC.text}, ${descC.text}, $widgetList  ');
                  var url =
                      "http://13.127.33.107/upload/dhanraj/homework/api/staffapi.php";
                  setState(() {});
                  Dio dio = new Dio();
                  Response response;
                  /* FormData formData = await formData1(); */
                  /* 
                  multipart.addFormField("action", "insert_study_material");
                multipart.addFormField("acyid", sp.getString(Study_Metrial_Activity.this, "staff_acyid"));
                multipart.addFormField("schoolid", sp.getString(Study_Metrial_Activity.this, "schoolid"));
                multipart.addFormField("classid", classID);
                multipart.addFormField("staffid", sp.getString(Study_Metrial_Activity.this, "staffid"));
                multipart.addFormField("subjectid", subjectID);
                multipart.addFormField("title", title_value);
                multipart.addFormField("description",description_value);
                multipart.addFormField("editid", "");
                multipart.addFormField("editurl", "");
                   */

                  FormData formData = new FormData.fromMap({
                    "action": "insert_study_material",
                    "acyid": academicYear.toString(),
                    "schoolid": schoolID.toString(),
                    "classid": classIDConfirm.toString(),
                    "staffid": staffID.toString(),
                    "subjectid": confirmSubjectID.toString(),
                    // "hwdate": "$birthDateInString1",
                    "title": titleC.text,
                    "description": descC.text,
                    "editid": "",
                    "editurl": "",
                    "images": fileArrays,
                    
                  });
                  response = await dio.post(url, data: formData);
                  print('Assign....   Response body: ${response.data}');
                  /*  subjectList1 = jsonDecode(response.data);
                  print("Files::::: $subjectList1"); */
                })
          ],
        ),
      )),
    );
  }

  filesArray() async {
    for (var i = 0; i < files.length; i++) {
      filePaths.add(path.basename(files[i].path));
      /*  print(path.basename(files[i].path));
                    print(files[i].path); */
      /*     widgetList.add(
                      'await MultipartFile.fromFile("${files[i].path}", filename: "${filePaths[i]}")',
                    ); */
      fileArrays.add(MultipartFile.fromFile(files[i].path,
          filename: path.basename(files[i].path)));
    }
    setState(() {});
  }

  getStudentList(String classID) async {
    var url = "http://13.127.33.107/upload/dhanraj/homework/api/staffapi.php";
    Dio dio = new Dio();
    Response response;
    subjects.add("Select");
    subjectsID.add("Select");
    FormData formData = new FormData.fromMap({
      "action": "get_subject",
      "schoolid": "$schoolID", // .toString(),
      "staffid": "$staffID", // .toString(),
      "acyid": "$academicYear", // .toString(),
      "classid": "$classIDConfirm"
    });
    response = await dio.post(url, data: formData);
    print('Response body: ${response.data}');
    subjectList = jsonDecode(response.data);
    print(subjectList);
    for (var i = 0; i < subjectList.length; i++) {
      subjects.add("${subjectList[i]["subject"]}");
      subjectsID.add("${subjectList[i]["subjectid"]}");
    }
    setState(() {});
  }

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
  Future<FormData> formData1() async {
    return FormData.fromMap({
      "action": "insert_study_material",
      "acyid": academicYear.toString(),
      "schoolid": schoolID.toString(),
      "classid": classIDConfirm.toString(),
      "staffid": staffID.toString(),
      "subjectid": confirmSubjectID.toString(),
      // "hwdate": "$todayDate",
      "title": titleC.text,
      "description": descC.text,
      "editid": "",
      "editurl": "",
      "images": [
        for (var i = 0; i < files.length; i++)
          await MultipartFile.fromFile(files[i].path, filename: filePaths[i]),
      ]
    });
  }
}
