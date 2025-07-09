import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school/adminDashBoard.dart';
import 'package:school/adminRegister.dart';
import 'package:school/db/utility_basics.dart';
import 'package:school/main.dart';
import 'package:school/staffdashboard.dart';
import 'package:school/studentdashboard.dart';
import 'package:http/http.dart' as http;

import 'ScreenUtil.dart';
// import 'addschooldetails.dart';
import 'raaja/addscholldetails1.dart';

TextEditingController otpController = new TextEditingController();
var schoolId1 = schoolId;
var view_link;
var utilitybasic = Utility_Basic();

class OtpVerify extends StatefulWidget {
  final int checkUser;

  const OtpVerify({Key key, @required this.checkUser}) : super(key: key);

  @override
  OtpVerify1 createState() {
    return new OtpVerify1();
  }
}

class OtpVerify1 extends State<OtpVerify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Container(
        color: appcolor,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset(
                      "assets/otpimg.webp",
                      height: ScreenUtil().setHeight(500),
                      width: ScreenUtil().setWidth(800),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Mobile Verification",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(50)),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 35, bottom: 35),
                      child: Text(
                        "OTP Verification",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(50)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: TextField(
                        controller: otpController,
                        maxLength: 6,
                        style: TextStyle(
                            color: Colors.white, decorationColor: Colors.white),
                        decoration: new InputDecoration(
                            labelText: "Enter OTP",
                            labelStyle: TextStyle(color: Colors.white)),
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.white,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ], // Only numbers can be entered
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ButtonTheme(
                    minWidth: ScreenUtil().setWidth(600),
                    height: ScreenUtil().setHeight(170),
                    child: RaisedButton(
                      onPressed: () async {
                        print("checkUser:: ${widget.checkUser}");
                        print("${otpController.text}");
                        if (widget.checkUser == 1) {
                          print("${otpController.text}");
                          if (otp == int.parse(otpController.text)) {
                            utilitybasic.toastfun("OTP Verified..");
                            if (temp123[0]['status'] == "existing_school") {
                              await prefs.setint("LoggedIn", 1);
                              String schID = temp123[0]["schoolid"];
                              await prefs.setint(
                                  "SchoolID", int.parse(schID.toString()));
                              schoolID = await prefs.getInt("SchoolID");

                              // await prefs.setint("SchoolID", schoolId);

                              nameLoggedAdmin = temp123[0]["login_name"];
                              await prefs.setString(
                                  "LoggedName", nameLoggedAdmin);

                              schoolname = temp123[0]["school_name"];
                              await prefs.setString("SchoolName", schoolname);
                              acylable = temp123[0]["acylable"];
                              await prefs.setString("AcademicLabel", acylable);
                              view_link = temp123[0]["view_link"];
                              await prefs.setString("SchoolLink", view_link);
                              acyid = int.parse(temp123[0]["acyid"].toString());
                              await prefs.setint("AcademicYear", acyid);
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AdminDashBoard()), //AddStaffDetails()),
                              );
                            } else {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddSchoolDetails1()),
                              );
                            }
                          } else {
                            utilitybasic.toastfun("OTP Not Verified..");
                          }
                        } else if (widget.checkUser == 2) {
                          if (otp == int.parse(otpController.text)) {
                            utilitybasic.toastfun("OTP Verified..");
                            print("Staff: Temp123");
                            print(temp123);

                            if (temp123[0]["role"] == "1") {
                              await prefs.setint("SchoolID",
                                  int.parse(temp123[0]["schoolid"].toString()));
                              schoolID = await prefs.getInt("SchoolID");
                              print("schoolid: $schoolID");
                              await prefs.setint("LoggedIn", 1);

                              // await prefs.setint("SchoolID", schoolId);

                              nameLoggedAdmin = temp123[0]["login_name"];
                              await prefs.setString(
                                  "LoggedName", nameLoggedAdmin);

                              schoolName = temp123[0]["school_name"];
                              await prefs.setString("SchoolName", schoolName);
                              acylable = temp123[0]["acylable"];
                              await prefs.setString("AcademicLabel", acylable);
                              view_link = temp123[0]["view_staff"];
                              await prefs.setString("SchoolLink", view_link);
                              acyid = int.parse(temp123[0]["acyid"].toString());
                              await prefs.setint("AcademicYear", acyid);
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AdminDashBoard()), //AddStaffDetails()),
                              );
                            } else {
                              await prefs.setint("LoggedIn", 2);
                              print("Staff Details: ");
                              print(temp123);
                              await prefs.setint("SchoolID",
                                  int.parse(temp123[0]["schoolid"].toString()));
                              schoolID = await prefs.getInt("SchoolID");
                              await prefs.setint("StaffID",
                                  int.parse(temp123[0]["staffid"].toString()));
                              staffID = await prefs.getInt("StaffID");
                              await prefs.setint("AcademicYear",
                                  int.parse(temp123[0]["acyid"].toString()));
                              academicYear = await prefs.getInt("AcademicYear");
                              print("schoolid: $schoolID");
                              print("staffID: $staffID");

                              await prefs.setint(
                                  "IsClassTeacher",
                                  int.parse(temp123[0]["is_class_teacher"]
                                      .toString()));
                              isClassTeacher =
                                  await prefs.getInt("IsClassTeacher");

                              // await prefs.setint("SchoolID", schoolId);

                              nameLoggedAdmin = temp123[0]["login_name"];
                              await prefs.setString(
                                  "LoggedName", nameLoggedAdmin);

                              schoolName = temp123[0]["school_name"];
                              await prefs.setString("SchoolName", schoolName);
                              acylable = temp123[0]["acylable"];
                              print(acylable);
                              await prefs.setString("AcademicLabel", acylable);
                              view_link = temp123[0]["view_staff"];
                              await prefs.setString("SchoolLink", view_link);
                              acyid = int.parse(temp123[0]["acyid"].toString());
                              print(acyid);
                              await prefs.setint("AcademicYear", acyid);

                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StaffDashboard()),
                              );
                            }
                          } else {
                            utilitybasic.toastfun("OTP Not Verified..");
                          }
                        } else if (widget.checkUser == 3) {
                          if (otp == int.parse(otpController.text)) {
                            utilitybasic.toastfun("OTP Verified..");
                            await prefs.setint("LoggedIn", 3);

                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentDashboard()),
                            );
                          } else {
                            utilitybasic.toastfun("OTP Not Verified..");
                          }
                        } else {}
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      color: Color(0xFFffffff),
                      child: Text(
                        "  VERIFY  ",
                        style: TextStyle(
                            color: appcolor,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(50)),
                      ),
                    ),
                  ),
                ),
                startTimerC == 0 && setResend == false
                    ? new InkWell(
                        child: new Container(
                          height: 32,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(32)),
                          alignment: Alignment.center,
                          child: new Text(
                            "Resend OTP",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        onTap: () async {
                          String schoolCheck = "";
                          var response;
                          setState(() {
                            setResend = !setResend;
                            startTimerC = 119;
                            minute = 1;
                            secx = 59;
                            secy = 59;
                          });

                          if (widget.checkUser == 1) {
                            schoolCheck = "school_check";
                            response = await http.post(url,
                                body: jsonEncode({
                                  "action": schoolCheck,
                                  "mobile":
                                      int.parse((mobileNo.text).toString())
                                }));
                            print(mobileNo.text);
                            print('Response status: ${response.statusCode}');
                            print('Response body: ${response.body}');
                            temp123 = json.decode(response.body);
                            print('temp: $temp123');
                            schoolId =
                                int.parse(temp123[0]['schoolid'].toString());
                            await prefs.setint("SchoolID", schoolId);
                            print("schoolID:");
                            print(schoolId);
                            otp = temp123[0]['otp'];
                            await prefs.setString("mobile", mobileNo.text);

                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OtpVerify(checkUser: 1)),
                            );
                          } else if (widget.checkUser == 2) {
                            schoolCheck = "staffs_check";
                            response = await http.post(url,
                                body: jsonEncode({
                                  "action": schoolCheck,
                                  "mobile": (mobileNo.text)
                                }));
                            print(mobileNo.text);
                            print('Response status: ${response.statusCode}');
                            print('Response body: ${response.body}');
                            temp123 = json.decode(response.body);
                            print('temp: $temp123');
                            schoolId =
                                int.parse(temp123[0]['schoolid'].toString());
                            await prefs.setint("SchoolID", schoolId);
                            /* print("schoolID:");
                                                print(schoolId); */
                            otp = temp123[0]['otp'];
                            print(otp);
                            print("Staff: Temp123");
                            print(temp123);

                            if (temp123[0]['status'] == "new_staff") {
                              utilitybasic.toastfun("Contact School Principal");
                            } else {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OtpVerify(checkUser: 2)),
                              );
                            }
                            /* await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          OtpVerify(
                                                              checkUser: 2)),
                                                ); */
                          } else /* if (widget.checkUser ==
                                                  3) */
                          {
                            schoolCheck = "student_check";
                            response = await http.post(url,
                                body: jsonEncode({
                                  "action": schoolCheck,
                                  "mobile":
                                      int.parse((mobileNo.text).toString())
                                }));
                            print(mobileNo.text);
                            print('Response status: ${response.statusCode}');
                            print('Response body: ${response.body}');
                            var temp = json.decode(response.body);
                            print('temp: $temp');

                            otp = temp[0]['otp'];
                            if (temp[0]['status'] == "new_student") {
                              utilitybasic.toastfun("Contact Class Teacher");
                            } else {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OtpVerify(checkUser: 3)),
                              );
                            }
                          }

                          // startTimer();
                          // Resend you OTP via API or anything
                        },
                      )
                    : setSec
                        ? (secx < 10
                            ? Text("0$minute:0$secx")
                            : Text("0$minute:$secx"))
                        : (secy < 10
                            ? Text("0$minute:0$secy")
                            : Text("0$minute:$secy")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (startTimerC < 1) {
            timer.cancel();
          } else {
            setState(() {
              setResend = !setResend;
              startTimerC = startTimerC - 1;
              if (startTimerC < 60) {
                setState(() {
                  setSec = false;
                  minute = 0;
                  secy = secy - 1;
                });
              } else if (startTimerC == 60) {
                setState(() {
                  setSec = true;
                  minute = 1;
                  secx = 0;
                });
              } else {
                setState(() {
                  setSec = true;
                  minute = 1;
                  secx = secx - 1;
                });
              }
            });
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }
}

Timer timer;
int startTimerC = 119;
int minute = 1;
int secx = 59;
int secy = 59;
bool setSec = false;
bool setResend = false;
