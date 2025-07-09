/* import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school/ScreenUtil.dart';
import 'package:school/db/utility_basics.dart';
import 'package:school/main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

enum role { admin, staff }
int roleStaff = 0;
var utilitybasic = Utility_Basic();

var birthDateInString = 'dd/mm/yy';
DateTime birthDate; // instance of DateTime
bool isDateSelected = false;

TextEditingController mobileStaffC = new TextEditingController();
TextEditingController nameStaffC = new TextEditingController();
TextEditingController dobC = new TextEditingController();

class AddStaffDetails1 extends StatefulWidget {
  @override
  AddStaffDetails1Reg createState() {
    return new AddStaffDetails1Reg();
  }
}

class AddStaffDetails1Reg extends State<AddStaffDetails1> {
  var url = 'http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php';
  role roleSelect;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Add Staff Details",
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
                  child: TextField(
                    controller: nameStaffC,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8.0),
                        hintText: "Enter Staff Name"),
                    style: TextStyle(fontSize: 20, height: 1.5),
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Name",
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
                        controller: nameStaffC,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(8.0),
                            hintText: "Enter Staff Name"),
                        style: TextStyle(fontSize: 20, height: 1.5),
                      )),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Mobile Number",
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
                        controller: mobileStaffC,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(8.0),
                            hintText: "Enter Mobile Number"),
                        style: TextStyle(fontSize: 20, height: 1.5),
                      )),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Role",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20),
                      ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RadioListTile(
                        value: role.admin,
                        groupValue: roleSelect,
                        title: Text("Admin", ),
                        onChanged: (role value) {
                          setState(() {
                            roleSelect = value;
                            roleStaff = 1;
                          });
                        },
                        activeColor: Colors.red,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RadioListTile(
                        value: role.staff,
                        groupValue: roleSelect,
                        title: Text("Staff"),
                        onChanged: (role newValue) {
                          setState(() {
                            roleSelect = newValue;
                            roleStaff = 2;
                          });
                        },
                        activeColor: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Date Of Birth",
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
                        keyboardType: TextInputType.datetime,
                        controller: dobC,
                        style: TextStyle(fontSize: 20, height: 1.5),
                        decoration: InputDecoration(
                          hintText: birthDateInString,
                          border: InputBorder.none,
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
                            print("Role: $roleStaff");
                            var number = mobileStaffC.text;
                            print(number);
                            print(
                                'schoolId : $schoolID, name : ${nameStaffC.text}, mobile : $number, role : $roleStaff,      dob : $birthDateInString, email: "a":, designation: "a", address: 1, country: 1, state: 1, city: 1, staffid: 1 ');

                            if (number.length < 10 || number.length > 10) {
                              utilitybasic
                                  .toastfun("Phone Number should be 10 digits");
                            } else {
                              // String actionS = "add_staffs";
/*                                     var map = new Map<String, dynamic>();
                                    map['action'] = "add_staffs";
                                    map['schoolid'] = schoolID;
                                    map['name'] = nameStaffC.text;
                                    map['mobile'] = mobileStaffC.text;
                                    map['role'] = roleStaff;
                                    map['dob'] = birthDateInString;
                                    map['email'] = "roleStaff";
                                    map['designation'] = "roleStaff";
                                    map['address'] = "roleStaff";
                                    map['country'] = roleStaff;
                                    map['state'] = roleStaff;
                                    map['city'] = roleStaff;
                                    map['staffid'] = roleStaff;
 */
                              try {
                                var a = 1;
                                print("SCHOOLID::: $schoolID");

                                var response = await http.post(
                                  url,
                                  body: jsonEncode({
                                    "action": "add_staffs",
                                    "schoolid": schoolID,
                                    "name": nameStaffC.text,
                                    "mobile": mobileStaffC.text,
                                    "role": roleStaff,
                                    "dob": birthDateInString,
                                    "email": "a",
                                    "designation": "a",
                                    "address": "dfghd",
                                    "country": a,
                                    "state": a,
                                    "city": a,
                                    "staffid": 0
                                  }),
                                );

                                print('Response body: ${response.body}');
                                var temp = jsonDecode(response.body);
                                print('temp: $temp');
                                print("status");
                                if (temp[0]["status"] == "sucess") {
                                  utilitybasic.toastfun("Added Staff Details");
                                  mobileStaffC.clear();
                                } else {
                                  utilitybasic.toastfun(
                                      temp[0]["status"] + temp[0]["dig_msg"]);
                                }
                                /* utility_basic
                                          .toastfun("Added Staff Details"); */
                              } catch (e) {
                                print(e);
                              }

                              // print(temp[0]['status']);
                              /* if (temp[0]["status"] == "sucess") {
                                      
                                      utility_basic
                                          .toastfun("Added Staff Details");

                                      /* await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AdminDashBoard()), //AddStaffDetails()), 
                                    );*/
                                    } else {
                                      utility_basic.toastfun(temp[0]["status"] +
                                          temp[0]["dig_msg"]);
                                    } */
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

class Post {
  final String action = "add_staffs";
  final int schoolid = schoolID;
  final String name;
  final String mobile;
  final int role = roleStaff;
  final String dob;
  final String email;
  final String designation;
  final String address;
  final int country;
  final int state;
  final int city;
  final int staffid;

  Post(
      {action,
      schoolid,
      this.name,
      this.mobile,
      role,
      this.dob,
      this.email,
      this.designation,
      this.address,
      this.country,
      this.state,
      this.city,
      this.staffid});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      action: json['action'],
      schoolid: json['schoolid'],
      name: json['name'],
      mobile: json['mobile'],
      role: json['role'],
      dob: json['dob'],
      email: json['email'],
      designation: json['designation'],
      address: json['address'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      staffid: json['staffid'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["action"] = action;
    map["schoolid"] = schoolid;
    map["name"] = name;
    map["mobile"] = mobile;
    map["role"] = role;
    map["dob"] = dob;
    map["email"] = email;
    map["designation"] = designation;
    map["address"] = address;

    map["country"] = country;
    map["state"] = state;
    map["city"] = city;
    map["staffid"] = staffid;
    return map;
  }
}
 */