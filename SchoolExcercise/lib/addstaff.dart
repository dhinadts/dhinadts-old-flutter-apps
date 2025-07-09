import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school/main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'ScreenUtil.dart';
import 'db/utility_basics.dart';

enum role { admin, staff }
int roleStaff = 0;
var utilitybasic = Utility_Basic();

var birthDateInString = 'dd/mm/yy';
DateTime birthDate; // instance of DateTime
bool isDateSelected = false;

TextEditingController mobileStaffC = new TextEditingController();
TextEditingController nameStaffC = new TextEditingController();
TextEditingController dobC = new TextEditingController();

class AddStaffDetails extends StatefulWidget {
  @override
  AddStaffDetailsReg createState() {
    return new AddStaffDetailsReg();
  }
}

class AddStaffDetailsReg extends State<AddStaffDetails> {
  var url = 'http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php';
  role roleSelect;

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
                  "Add Staff Details",
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
                                "Name",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: nameStaffC,
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
                                controller: mobileStaffC,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
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
                                "Role",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                            flex: 2,
                            child: RadioListTile(
                              value: role.admin,
                              groupValue: roleSelect,
                              title: Text("Admin"),
                              onChanged: (role value) {
                                setState(() {
                                  roleSelect = value;
                                  roleStaff = 1;
                                });
                              },
                              activeColor: Colors.red,
                            ),
                          ),
                          Expanded(
                            flex: 2,
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
                        ],
                      ),
                    ),
                    /*  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 3,
                              child: Text(
                                "Is Class Teacher",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                            flex: 2,
                            child: RadioListTile(
                              value: 1,
                              groupValue: isClassradio,
                              title: Text("Yes"),
                              onChanged: (newValue) {
                                setState(() {
                                  ict = newValue;
                                });
                              },
                              activeColor: Colors.red,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: RadioListTile(
                              value: 2,
                              groupValue: isClassradio,
                              title: Text("No"),
                              onChanged: (newValue) {
                                setState(() {
                                  ict = newValue;
                                });

                              },
                              activeColor: Colors.red,

                            ),
                          ),
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
                                "DOB",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                autofocus: false,
                                controller: dobC,
                                style: TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                  hintText: birthDateInString,
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
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      final datePick = await showDatePicker(
                                          context: context,
                                          initialDate: new DateTime.now(),
                                          firstDate: new DateTime(1900),
                                          lastDate: new DateTime(2100));
                                      if (datePick != null &&
                                          datePick != birthDate) {
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
                                  print("Role: $roleStaff");
                                  var number = mobileStaffC.text;
                                  print(number);
                                  print(
                                      'schoolId : $schoolID, name : ${nameStaffC.text}, mobile : $number, role : $roleStaff,      dob : $birthDateInString, email: "a":, designation: "a", address: 1, country: 1, state: 1, city: 1, staffid: 1 ');

                                  if (number.length < 10 ||
                                      number.length > 10) {
                                    utilitybasic.toastfun(
                                        "Phone Number should be 10 digits");
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
                                          "mobile":
                                              mobileStaffC.text,
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
                                      
                                      utilitybasic
                                          .toastfun("Added Staff Details");
                                          mobileStaffC.clear();
                                          nameStaffC.clear();
                                          


                                      
                                    } else {
                                      utilitybasic.toastfun(temp[0]["status"] +
                                          temp[0]["dig_msg"]);
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
