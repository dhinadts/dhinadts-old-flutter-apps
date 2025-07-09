import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school/ScreenUtil.dart';
import 'package:school/db/utility_basics.dart';
import 'package:school/main.dart';





TextEditingController fromAcadYear = new TextEditingController();
TextEditingController toAcadYear = new TextEditingController();

class AcademicYearNew extends StatefulWidget {
  AcademicYearNew({Key key}) : super(key: key);

  @override
  _AcademicYearNewState createState() => _AcademicYearNewState();
}

class _AcademicYearNewState extends State<AcademicYearNew> {
  TextEditingController classC = new TextEditingController();
  TextEditingController sectionsC = new TextEditingController();
  DateTime birthDate; // instance of DateTime
  var birthDateInString = 'dd/mm/yy';
  var birthDateInString1 = 'dd/mm/yy';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add Academic Year")),
        body: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Academic Year", style: TextStyle(fontSize: 20))),
            Divider(),
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("FROM"),
                    )),
                Expanded(
                  flex: 2,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: fromAcadYear,
                        keyboardType: TextInputType.datetime,
                        style: TextStyle(fontSize: 20, height: 1.5),
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: appcolor),
                          ),
                          hintText: birthDateInString,
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

                                  // put it here
                                  birthDateInString = new DateFormat("MM\/yyyy")
                                      .format(birthDate);
                                  fromAcadYear.text = birthDateInString;
                                  // "${birthDate.day}/${birthDate.month}/${birthDate.year}"; // 08/14/2019
                                });
                              }
                            },
                          ),
                        ),
                      )),
                ),
              ],
            ),
            Divider(),
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("TO"),
                    )),
                Expanded(
                  flex: 2,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: toAcadYear,
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
                                      new DateFormat("MM\/yyyy")
                                          .format(birthDate);
                                  toAcadYear.text = birthDateInString1;
                                  // "${birthDate.day}/${birthDate.month}/${birthDate.year}"; // 08/14/2019
                                });
                              }
                            },
                          ),
                        ),
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ButtonTheme(
                minWidth: ScreenUtil().setWidth(400),
                height: ScreenUtil().setHeight(130),
                child: RaisedButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      child: new AlertDialog(
                        title: new Text(
                            'Do you want to activate this academic year?'),
                        // content: new Text('We hate to see you leave...'),
                        actions: <Widget>[
                          new FlatButton(
                            onPressed: () async {
                              setState(() {
                                isActivatdAcademic = false;
                              });
                              activeOrInactive = "1";
                              var url =
                                  "http://13.127.33.107/upload/dhanraj/homework/api/android.php";

                              FormData formData = new FormData.fromMap({
                                "action": "add_academic_year",
                                "schoolid": 2, // schoolID,,
                                "afrom": "${fromAcadYear.text}",
                                "ato": "${toAcadYear.text}",
                                "is_active": "1",
                                "editid": "0"
                              });
                              Response response;
                              Dio dio = new Dio();

                              response = await dio.post(url, data: formData);
                              print('Response status: ${response.statusCode}');
                              print('Response body: ${response.data}');
                              academicResponse = json.decode(response.data);
                              print(academicResponse);
                              utilitybasic
                                  .toastfun(academicResponse[0]["status"]);
                            },
                            child: new Text('No'),
                          ),
                          new FlatButton(
                            onPressed: () async {
                              setState(() {
                                activeOrInactive = "0";
                                isActivatdAcademic = true;
                              });
                              var url =
                                  "http://13.127.33.107/upload/dhanraj/homework/api/android.php";

                              FormData formData = new FormData.fromMap({
                                "action": "add_academic_year",
                                "schoolid": 2, // schoolID,
                                "afrom": "${fromAcadYear.text}",
                                "ato": "${toAcadYear.text}",
                                "is_active": "0",
                                "editid": "0"
                              });
                              Response response;
                              Dio dio = new Dio();
                              response = await dio.post(url, data: formData);
                              print('Response status: ${response.statusCode}');
                              print('Response body: ${response.data}');
                              academicResponse = json.decode(response.data);
                              print(academicResponse);
                              utilitybasic
                                  .toastfun(academicResponse[0]["status"]);
                            },
                            child: new Text('Yes'),
                          ),
                        ],
                      ),
                    );
                    print(fromAcadYear.text);
                    print(toAcadYear.text);
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  child: academicResponse != null
                      ?  Row(
                              children: <Widget>[
                                Text(
                                    "${academicResponse[0]["afrom"]} - ${academicResponse[0]["ato"]}"),
                                isActivatdAcademic == true
                                    ? Text("$yesAct",
                                        style: TextStyle(color: Colors.red))
                                    : Text("$noAct",
                                        style: TextStyle(color: Colors.red)),
                                Switch(
                                  value: isActivatdAcademic,
                                  onChanged: (value) async {
                                    setState(() {
                                      isActivatdAcademic = value;
                                    });
                                    if (isActivatdAcademic == true) {
                                      activeOrInactive = "0";
                                      var url =
                                          "http://13.127.33.107/upload/dhanraj/homework/api/android.php";

                                      FormData formData = new FormData.fromMap({
                                        "action": "add_academic_year",
                                        "schoolid": 2, // schoolID,
                                        "afrom": academicResponse[0]["afrom"],
                                        "ato": academicResponse[0]["ato"],
                                        "is_active": "0",
                                        "editid": "0"
                                      });
                                      Response response;
                                      Dio dio = new Dio();
                                      response =
                                          await dio.post(url, data: formData);
                                      print(
                                          'Response status: ${response.statusCode}');
                                      print('Response body: ${response.data}');

                                      setState(() {
                                        academicResponse =
                                            json.decode(response.data);
                                        isActivatdAcademic = value;
                                        print(isActivatdAcademic);
                                      });
                                      print(academicResponse[0]["is_active"]);
                                    } else {
                                     
                                      activeOrInactive = "1";
                                      var url =
                                          "http://13.127.33.107/upload/dhanraj/homework/api/android.php";

                                      FormData formData = new FormData.fromMap({
                                        "action": "add_academic_year",
                                        "schoolid": 2, // schoolID,
                                        "afrom": academicResponse[0]["afrom"],
                                        "ato": academicResponse[0]["ato"],
                                        "is_active": "1",
                                        "editid": "0"
                                      });
                                      Response response;
                                      Dio dio = new Dio();
                                      response =
                                          await dio.post(url, data: formData);
                                      print(
                                          'Response status: ${response.statusCode}');
                                      print('Response body: ${response.data}');

                                      setState(() {
                                        academicResponse =
                                            json.decode(response.data);
                                        isActivatdAcademic = value;
                                        print(isActivatdAcademic);
                                      });
                                      print(academicResponse[0]["is_active"]);
                                    }
                                  },
                                  activeTrackColor: Colors.lightBlueAccent,
                                  activeColor: Colors.lightBlueAccent,
                                ),
                                RaisedButton(
                                    child: Text("EDIT"), onPressed: () {})
                              ],
                            )
                          : /* Row(
                              children: <Widget>[
                                Text(
                                    "${academicResponse[0]["afrom"]} - ${academicResponse[0]["ato"]}"),
                                Text("$noAct",
                                    style: TextStyle(color: Colors.red)),
                                Switch(
                                  value: isActivatdAcademic,
                                  onChanged: (value) async {
                                    if (value == true) {
                                      setState(() {
                                        isActivatdAcademic = value;
                                      });
                                      activeOrInactive = "0";
                                      var url =
                                          "http://13.127.33.107/upload/dhanraj/homework/api/android.php";
                                      FormData formData = new FormData.fromMap({
                                        "action": "add_academic_year",
                                        "schoolid": 2, // schoolID,
                                        "afrom": academicResponse[0]["afrom"],
                                        "ato": academicResponse[0]["ato"],
                                        "is_active": "0",
                                        "editid": "0"
                                      });
                                      Response response;
                                      Dio dio = new Dio();
                                      response =
                                          await dio.post(url, data: formData);
                                      print(
                                          'Response status: ${response.statusCode}');
                                      print('Response body: ${response.data}');
                                      setState(() {
                                        academicResponse =
                                            json.decode(response.data);
                                        isActivatdAcademic = value;
                                        print(isActivatdAcademic);
                                      });
                                      print(academicResponse[0]["is_active"]);
                                    } else {
                                      setState(() {
                                        isActivatdAcademic = value;
                                      });
                                      activeOrInactive = "1";
                                      var url =
                                          "http://13.127.33.107/upload/dhanraj/homework/api/android.php";
                                      FormData formData = new FormData.fromMap({
                                        "action": "add_academic_year",
                                        "schoolid": 2, // schoolID,
                                        "afrom": academicResponse[0]["afrom"],
                                        "ato": academicResponse[0]["ato"],
                                        "is_active": "1",
                                        "editid": "0"
                                      });
                                      Response response;
                                      Dio dio = new Dio();
                                      response =
                                          await dio.post(url, data: formData);
                                      print(
                                          'Response status: ${response.statusCode}');
                                      print('Response body: ${response.data}');
                                      setState(() {
                                        academicResponse =
                                            json.decode(response.data);
                                        isActivatdAcademic = value;
                                        print(isActivatdAcademic);
                                      });
                                      print(academicResponse[0]["is_active"]);
                                    }
                                  },
                                  activeTrackColor: Colors.lightBlueAccent,
                                  activeColor: Colors.lightBlueAccent,
                                ),
                                RaisedButton(
                                    child: Text("EDIT"), onPressed: () {})
                              ],
                            )) */
                       SizedBox()),
            ),
          ],
        ));
  }
}

var utilitybasic = Utility_Basic();
bool isActivatdAcademic = false;
String yesAct = "Active";
String noAct = "Inactive";
String activeOrInactive = "0";
var academicResponse;
