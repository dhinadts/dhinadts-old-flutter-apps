import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:school/db/utility_basics.dart';
import 'package:school/main.dart';

import 'ScreenUtil.dart';
import 'package:http/http.dart' as http;

var utilitybasic = Utility_Basic();
var createdClasses = new List();
var defaultClass = "Select";

class AddClasssAndSections1 extends StatefulWidget {
  @override
  AddClasssAndSections1Reg createState() {
    return new AddClasssAndSections1Reg();
  }
}

class AddClasssAndSections1Reg extends State<AddClasssAndSections1> {
  TextEditingController classC = new TextEditingController();
  TextEditingController sectionsC = new TextEditingController();

  @override
  void initState() {
    super.initState();
    createdClass();
  }

  @override
  void dispose() {
    createdClasses.clear();
    super.dispose();
  }

  createdClass() async {
    var url = "http://13.127.33.107/upload/dhanraj/homework/api/android.php";
    FormData formData = new FormData.fromMap({
      'action': 'create_custom_class',
      'schoolid': 2,
      'cus_class': '',
      'editid': ''
    });
    Response response;
    Dio dio = new Dio();
    response = await dio.post(url, data: formData);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
    var temp = json.decode(response.data);
    // createdClasses.add("Select");
    for (var i = 0; i < temp.length; i++) {
      createdClasses.add(temp[i]["class"]);
    }
    setState(() {});
    print(createdClasses);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Add Class & Sections",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: ScreenUtil().setSp(50)),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Class",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20),
                      ))),
              createdClasses.length != 0
                  ? Padding(
                      padding: EdgeInsets.all(
                        8.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 50.0,
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: new Border.all(
                                  style: BorderStyle.solid,
                                  color: Colors.black45),
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                underline: Container(),
                                elevation: 0,
                                isExpanded: true,
                                isDense: true,
                                value: defaultClass == "Select"
                                    ? createdClasses[0]
                                    : defaultClass,
                                onChanged: (newValue) {
                                  setState(() {
                                    defaultClass = newValue;
                                  });
                                },
                                items: createdClasses.map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Section",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20),
                      ))),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      border: new Border.all(
                          style: BorderStyle.solid, color: Colors.black45),
                      borderRadius: BorderRadius.circular(5)),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: TextField(
                        controller: sectionsC,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(8.0),
                            hintText: "Enter Section"),
                        style: TextStyle(fontSize: 20, height: 1.5),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 0, bottom: 10.0),
                child: Text(
                    "Enter sections like \"A,B,C\" or \"RED,BLUE,ORANGE\" without spacing and with comma separation"),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ButtonTheme(
                        minWidth: ScreenUtil().setWidth(300),
                        height: ScreenUtil().setHeight(110),
                        child: RaisedButton(
                          onPressed: () async {
                            var response = await http.post(
                                "http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php",
                                body: jsonEncode({
                                  "action": "add_class_section",
                                  "schoolid": 2, //schoolID,
                                  "class": defaultClass,
                                  'section': sectionsC.text,
                                  "editid": '0',
                                }));

                            print('Response status: ${response.statusCode}');
                            print('Response body: ${response.body}');
                            var temp = json.decode(response.body);
                            print('temp: $temp');
                            print("status");
                            utilitybasic.toastfun(
                                temp[0]["status"] /* + temp[0]["dubvalue"] */);
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
                                fontSize: ScreenUtil().setSp(40)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ButtonTheme(
                        minWidth: ScreenUtil().setWidth(300),
                        height: ScreenUtil().setHeight(110),
                        child: RaisedButton(
                          onPressed: () async {
                            var response = await http.post(
                                "http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php",
                                body: jsonEncode({
                                  "action": "get_class",
                                  "schoolid": 2, //schoolID,
                                  
                                }));

                            print('Response status: ${response.statusCode}');
                            print('Response body: ${response.body}');
                            var temp = json.decode(response.body);
                            print('temp: $temp');

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
                                      Text("Total Classes & Sections",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white)),
                                      Text("$temp",
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
                                fontSize: ScreenUtil().setSp(40)),
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
}
