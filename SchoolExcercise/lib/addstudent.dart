import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:school/db/utility_basics.dart';
import 'package:school/main.dart';

import 'ScreenUtil.dart';
import 'package:http/http.dart' as http;

var utilitybasic = Utility_Basic();

class AddStudentDetails extends StatefulWidget {
  @override
  AddStudentDetailsReg createState() {
    return new AddStudentDetailsReg();
  }
}

class AddStudentDetailsReg extends State<AddStudentDetails> {
  TextEditingController studentNameC = new TextEditingController();
  TextEditingController mobileSTudentC = new TextEditingController();
  TextEditingController regNoStuC = new TextEditingController();
  TextEditingController dob = new TextEditingController();
  TextEditingController classSecC = new TextEditingController();
  var classSelection, subjectSelection, staffSelection = new List();
  var itemsClassSection = new List();
var classSectionID;



  @override
  void initState() {
    
    super.initState();
    searchInitial();

  }
  searchInitial() async {
    var url = 'http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php';

    var response = await http.post(url,
        body: jsonEncode({
          'action': 'get_class',
          "schoolid": 1// schoolID,
        }));

    print(response.body);
    classSelection = json.decode(response.body);
    print("countrySelection :: $classSelection");
    print(classSelection[0]["class"]);

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
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Container(
        color: appcolor,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Add Student",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(60)),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Student Name",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: studentNameC,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Mobile No",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: mobileSTudentC,
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Registration No",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: regNoStuC,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Class & Section:",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: new TextEditingController.fromValue(
                                    new TextEditingValue(
                                        text: classSecC.text,
                                        selection: new TextSelection.collapsed(
                                            offset: classSecC.text.length))),
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 18),
                                onChanged: (value) async {
                                  classSecC.text = value;
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
                                                classSecC.text =
                                                    "${itemsClassSection[i]["class"]}-${itemsClassSection[i]["section"]}";
                                                classSectionID = itemsClassSection[i]["id"];
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: ButtonTheme(
                              minWidth: ScreenUtil().setWidth(400),
                              height: ScreenUtil().setHeight(130),
                              child: RaisedButton(
                                onPressed: () async {},
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
                                        'action': 'add_student',
                                        'schoolid': 1,
                                        'email': "emailStudent",
                                        'name': studentNameC.text,
                                        'reg_number': regNoStuC.text,
                                        'mobile': mobileSTudentC.text,
                                        'address': "",
                                        'state': 1,
                                        'city': 1,
                                        'country': 1,
                                        'dob': "dob",
                                        "studentid": 0,
                                        "father_name": "Father",
                                        "mother_name": "Maother"
                                        
                                      }));

                                  print(
                                      'Response status: ${response.statusCode}');
                                  print('Response body: ${response.body}');
                                  var temp = json.decode(response.body);
                                  print('temp: $temp');
                                  print("status");
                                  if (temp[0]["status"] == "sucess") {
                                    utilitybasic
                                        .toastfun("Student Added successfully");
                                  } else {
                                    utilitybasic
                                        .toastfun("Dup[licate Student");
                                  }
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
