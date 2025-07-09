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
var listView = new List();

class TotalSubjects extends StatefulWidget {
  @override
  TotalSubjectsReg createState() {
    return new TotalSubjectsReg();
  }
}

class TotalSubjectsReg extends State<TotalSubjects> {
  int _count = 0;
  int count = 0;
  int countSub = 1;
  int countEnter = 0;
  TextEditingController totalSubjects = new TextEditingController();
  TextEditingController sub1C = new TextEditingController();
  TextEditingController sub2C = new TextEditingController();
  TextEditingController sub3C = new TextEditingController();
  TextEditingController sub4C = new TextEditingController();
  TextEditingController sub5C = new TextEditingController();

  listingSubjects() async {
    var response = await http.post(
        "http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php",
        body: jsonEncode({
          'action': 'add_subject',
          'schoolid': schoolID,
          'subjects': "",
          'editid': 0,
        }));
    listView = json.decode(response.body);
    print("listView:: $listView");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // listingSubjects();
  }

  @override
  Widget build(BuildContext context) {
    /* List<Widget> _subjects =
        new List.generate(_count, (int i) => new ContactRow()); */
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            "Total Subjects",
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
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Subject",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 20),
                            ))),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            border: new Border.all(
                                style: BorderStyle.solid,
                                color: Colors.black45),
                            borderRadius: BorderRadius.circular(5)),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: TextField(
                              controller: sub1C,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(8.0),
                                  hintText: "Enter Subject"),
                              style: TextStyle(fontSize: 20, height: 1.5),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
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
                                  sub1C.clear();
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
                                  String action = "add_subject";
                                  FormData formData = new FormData.fromMap({
                                    'action':action,
                                    'schoolid': 2,
                                    'subjects': sub1C.text,
                                    'editid': '0',
                                    'selected_subject': '',
                                    'edited_subject': ''
                                  });
                                  Response response;
                                  Dio dio = new Dio();
                                  response = await dio.post(
                                      "http://13.127.33.107//upload/dhanraj/homework/api/android.php",
                                      data: formData);
                                  /* var response = await http.post(
                                      "http://13.127.33.107//upload/dhanraj/homework/api/android.php",
                                      body: jsonEncode({
                                        'action': 'add_subject',
                                        'schoolid': schoolID,
                                        'subjects': sub1C.text,
                                        'editid': '0',
                                        'selected_subject': "",
                                        'edited_subject': ""
                                      }));
 */
                                  print(
                                      'Response status: ${response.statusCode}');
                                  print('Response body: ${response.data}');
                                  var temp = json.decode(response.data);
                                  print('temp: $temp');
                                  
                                  sub1C.clear();

                                  listView = json.decode(response.data);
                                  utilitybasic
                                  .toastfun(listView[0]["status"]);
                                  print("listView:: $listView");
                                  setState(() {});
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
              listView.length != 0
                  ? Container(
                      height: 350.0,
                      child: ListView.builder(
                          itemCount: listView.length,
                          padding: new EdgeInsets.symmetric(vertical: 8.0),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (BuildContext context, int i) {
                            var _count = i + 1; // listView.length - i;
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(15.0)),
                              elevation: 20.0,
                              margin: EdgeInsets.only(
                                  top: 5.0, left: 5.0, right: 5.0, bottom: 5.0),
                              child: new ListTile(
                                  title: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("$_count"),
                                  ),
                                  new Expanded(
                                      child: new Text(
                                    "${listView[i]["name"]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor: Colors.black),
                                    child: FlatButton(
                                        onPressed: () async {
                                          sub1C.text = listView[i]["name"];
                                        },
                                        child: Text("Edit")),
                                  ),
                                ],
                              )),
                            );
                          }))
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void _addNewContactRow() {
    setState(() {
      _count = _count + 1;
      a = "subj" + "$_count";
      print(a);
    });
  }
}

var a;
TextEditingController an = new TextEditingController();

class ContactRow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ContactRow();
}

class _ContactRow extends State<ContactRow> {
  @override
  Widget build(BuildContext context) {
    return new Container(
        width: 200.0,
        padding: new EdgeInsets.all(5.0),
        child: new Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '$a',
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
                    // controller: sub5C,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8.0),
                        hintText: "Enter $a"),
                    style: TextStyle(fontSize: 20, height: 1.5),
                  )),
            ),
          ),
        ]));
  }

  @override
  void initState() {
    super.initState();
  }
}

/* 
      
 */
