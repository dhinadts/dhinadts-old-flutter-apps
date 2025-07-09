import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school/ScreenUtil.dart';
import 'package:school/db/utility_basics.dart';
import 'package:school/main.dart';
import 'package:intl/intl.dart';
import 'package:school/rough/exitdia.dart';
import 'package:school/rough/viewStaffAdmin.dart';

enum role { admin, staff }
enum gender { male, female, transgender }
int roleStaff = 0;
String roleStaffName = "";
String genderStaff = "";
var utilitybasic = Utility_Basic();

var birthDateInString = 'dd/mm/yyyy';
DateTime birthDate; // instance of DateTime
bool isDateSelected = false;
var exitApp = ExitDial();

TextEditingController mobileStaffC = new TextEditingController();
TextEditingController nameStaffC = new TextEditingController();
TextEditingController dobC = new TextEditingController();
TextEditingController emailStaffC = new TextEditingController();
var url = 'http://13.127.33.107/upload/dhanraj/homework/api/android.php';

class AddStaffAdmin extends StatefulWidget {
  @override
  AddStaffDetails1Reg createState() {
    return new AddStaffDetails1Reg();
  }
}

class AddStaffDetails1Reg extends State<AddStaffAdmin> {
  role roleSelect;
  gender genderSelect;
  var staffName = "";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exitApp.exitApp(context),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              "Add Staff Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                  ),
                  onPressed: () async {
                    // view
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewStaffAdmin()),
                      // ViewStaffDetails()),
                    );
                  })
            ],
          ),
          body: Container(
              // color: Colors.white,
              child: SingleChildScrollView(
                  child: Column(children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameStaffC,
                  decoration: const InputDecoration(
                    hintText: 'What is your name?',
                    labelText: 'Name *',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF4169E1)),
                    ),
                  ),
                  style: TextStyle(fontSize: 20, height: 1.5),
                  keyboardType: TextInputType.text,
                  onSaved: (String value) {},
//                     validator: (String value) {
//                       return value.contains('@')
//                           ? 'Do not use the @ char.'
//                           : null;
//                     },
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: mobileStaffC,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 20, height: 1.5),
                  decoration: const InputDecoration(
                    hintText: 'What is your mobile number?',
                    labelText: 'Mobile *',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF4169E1)),
                    ),
                  ),
                  onSaved: (String value) {},
                  validator: (String value) {
                    return value.contains('@')
                        ? 'Do not use the @ char.'
                        : null;
                  },
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailStaffC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'What is your email?',
                    labelText: 'Email ',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF4169E1)),
                    ),
                  ),
                  onSaved: (String value) {},
                  validator: (String value) {
                    return value.contains('@') ? 'OK' : 'Noty valid email';
                  },
                )),
            Row(children: [
              Container(width: 60, child: Text("DOB:")),
              Expanded(
                flex: 2,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
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
                                isDateSelected = true;

                                // put it here
                                birthDateInString =
                                    new DateFormat("dd\/MM\/yyyy")
                                        .format(birthDate);
                                // "${birthDate.day}/${birthDate.month}/${birthDate.year}"; // 08/14/2019
                              });
                            }
                          },
                        ),
                      ),
                    )),
              ),
            ]),
            Row(children: [
              Container(width: 70, child: Text("GENDER*:")),
              Expanded(
                flex: 2,
                child: Container(
                  width: 300.0,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.loose,
                        child: RadioListTile(
                          value: gender.male,
                          groupValue: genderSelect,
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Male"),
                          ),
                          onChanged: (gender value) {
                            setState(() {
                              genderSelect = value;
                              genderStaff = "Male";
                            });
                          },
                          activeColor: appcolor,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: RadioListTile(
                          value: gender.female,
                          groupValue: genderSelect,
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Female"),
                          ),
                          onChanged: (gender value) {
                            setState(() {
                              genderSelect = value;
                              genderStaff = "Female";
                            });
                          },
                          activeColor: appcolor,
                        ),
                      ),
                      /* Flexible(
                        fit: FlexFit.loose,
                        child: RadioListTile(
                          value: gender.transgender,
                          groupValue: genderSelect,
                          title: Text("T"),
                          onChanged: (gender value) {
                            setState(() {
                              genderSelect = value;
                              genderStaff = 3;
                            });
                          },
                          activeColor: appcolor,
                        ),
                      ), */
                    ],
                  ),
                ),
              )
            ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(width: 70, child: Text("ROLE*:")),
                  Flexible(
                    flex: 2,
                    child: Container(
                      width: 300.0,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            fit: FlexFit.tight,
                            child: RadioListTile(
                              value: role.admin,
                              groupValue: roleSelect,
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Admin"),
                              ),
                              onChanged: (role value) {
                                setState(() {
                                  roleSelect = value;
                                  roleStaff = 1;
                                  roleStaffName = "Admin";
                                });
                              },
                              activeColor: appcolor,
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: RadioListTile(
                              value: role.staff,
                              groupValue: roleSelect,
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Teacher"),
                              ),
                              onChanged: (role newValue) {
                                setState(() {
                                  roleSelect = newValue;
                                  roleStaff = 2;
                                  roleStaffName = "Teacher";
                                });
                              },
                              activeColor: appcolor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
            Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ButtonTheme(
                  minWidth: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(110),
                  child: RaisedButton(
                      color: appcolor,
                      child: Text("ADD",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      onPressed: () async {
                        print("Role: $roleStaff");
                        var number = mobileStaffC.text;
                        print(number);
                        /* print(
                            'schoolId : $schoolID, name : ${nameStaffC.text}, mobile : $number, role : $roleStaff,      dob : $birthDateInString, email: "a":, designation: "a", address: 1, country: 1, state: 1, city: 1, staffid: 1 '); */

                        if (number.length < 10 || number.length > 10) {
                          utilitybasic
                              .toastfun("Phone Number should be 10 digits");
                        } else {
                          try {
                            var a = 1;
                            print("SCHOOLID::: $schoolID");
                            FormData formData = new FormData.fromMap({
                              "action": "add_staffs",
                              "schoolid": 2, // schoolID,
                              "name": nameStaffC.text,
                              "mobile": mobileStaffC.text,
                              "gender": genderStaff,
                              // "role": roleStaff,
                              "rolename" : roleStaffName,
                              "dob": birthDateInString,
                              "email": "a",
                              "designation": "a",
                              "address": "dfghd",
                              "country": a,
                              "state": a,
                              "city": a,
                            });
                            Response response;
                            Dio dio = new Dio();
                            response = await dio.post(url, data: formData);

                            /*  var response = await http.post(
                              url,
                              body: jsonEncode({
                                "action": "add_staffs",
                                "schoolid": 2, // schoolID,
                                "name": nameStaffC.text,
                                "mobile": mobileStaffC.text,
                                "gender": "male",
                                "role": "admin",
                                "dob": birthDateInString,
                                "email": "a",
                                "designation": "a",
                                "address": "dfghd",
                                "country": a,
                                "state": a,
                                "city": a,
                                // "staffid": 0
                              }),
                            ); */

                            print('Response body: ${response.data}');
                            var temp = jsonDecode(response.data);
                            print('temp: $temp');
                            print("status");
                            if (temp[0]["status"] == "sucess") {
                              utilitybasic.toastfun("Added Staff Details");
                              mobileStaffC.clear();
                            } else {
                              utilitybasic.toastfun(
                                  // temp[0]["status"] + temp[0]["dig_msg"]);
                                  temp);
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
                      }),
                ))
          ])))),
    );
  }
}

int id = 1;
String radioButtonItem = 'ONE';
