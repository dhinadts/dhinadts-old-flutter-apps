/* import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:school/db/utility_basics.dart';
import 'package:school/main.dart';

import 'ScreenUtil.dart';
import 'package:http/http.dart' as http;

var utilitybasic = Utility_Basic();

class AddClasssAndSections extends StatefulWidget {
  @override
  AddClasssAndSectionsReg createState() {
    return new AddClasssAndSectionsReg();
  }
}

class AddClasssAndSectionsReg extends State<AddClasssAndSections> {
  TextEditingController fromAcadYear = new TextEditingController();
  TextEditingController toAcadYear = new TextEditingController();
  TextEditingController classC = new TextEditingController();
  TextEditingController sectionsC = new TextEditingController();

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
                        child: Text(
                          "Class & Sections",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    /* Container(decoration: BoxDecoration()),
                    Padding(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "To :",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: toAcadYear,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "dd/yyyy",
                                ),
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
                                "Class :",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: classC,
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
                                "Sections: ",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: sectionsC,
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
                                  var response = await http.post(
                                      "http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php",
                                      body: jsonEncode({
                                        "action": "add_class_section",
                                        "schoolid": schoolID,
                                        "class": classC.text,
                                        "section": sectionsC.text
                                      }));

                                  print(
                                      'Response status: ${response.statusCode}');
                                  print('Response body: ${response.body}');
                                  var temp = json.decode(response.body);
                                  print('temp: $temp');
                                  print("status");
                                  utilitybasic.toastfun(
                                    "${temp[0]["status"]} ${temp[0]["dubvalue"]}");
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                
                                  children: <Widget>[
                                  Text("Total Classes & Sections",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20, color: Colors.white)),
                                  Text("$academicLabel",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20, color: Colors.white)),
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
}
 */