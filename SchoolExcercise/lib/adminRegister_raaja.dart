import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school/db/utility_basics.dart';
import 'package:school/main.dart';
import 'package:school/otpverify.dart';
import 'package:dio/dio.dart';

import 'ScreenUtil.dart';

// var url = 'http://13.127.33.107//upload/dhanraj/homework/api/json.php';
// var url = 'http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php';
var url = 'http://13.127.33.107/upload/dhanraj/homework/api/android.php';

var utilitybasic = Utility_Basic();

var schoolId, otp;
var nameLoggedAdmin = "";
var schoolname = "";
var acylable = "";
var acyid;
var temp123;
TextEditingController mobileNo = new TextEditingController();

class AdminRegister1 extends StatefulWidget {
  final int checkUser;

  const AdminRegister1({Key key, @required this.checkUser}) : super(key: key);
  @override
  AReg createState() {
    return new AReg();
  }
}

class AReg extends State<AdminRegister1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0),
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
                      "assets/icon2.webp",
                      height: ScreenUtil().setHeight(500),
                      width: ScreenUtil().setWidth(800),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: widget.checkUser == 1
                          ? Text(
                              "SIGN UP NEW SCHOOL",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(50),
                              ),
                            )
                          : (widget.checkUser == 2
                                ? Text(
                                    "SIGN UP STAFF",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(50),
                                    ),
                                  )
                                : Text(
                                    "SIGN UP STUDENT",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(50),
                                    ),
                                  )),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 35, bottom: 35),
                      child: Text(
                        "Mobile Verification",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(50),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: TextField(
                        controller: mobileNo,

                        maxLength: 10,
                        style: TextStyle(
                          color: Colors.white,
                          decorationColor: Colors.white,
                        ),
                        decoration: new InputDecoration(
                          labelText: "Enter Your Number",
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.white,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly,
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
                        var number = mobileNo.text;
                        print(number.length);
                        if (number.length < 10 || number.length > 10) {
                          utilitybasic.toastfun(
                            "Phone Number should be 10 digits",
                          );
                        } else {
                          Dialog errorDialog = Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  10.0 *
                                      MediaQuery.of(context).devicePixelRatio,
                                ),
                              ),
                            ),
                            child: Container(
                              height: 300.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/confm.png",
                                    height: ScreenUtil().setHeight(170),
                                    width: ScreenUtil().setWidth(170),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Confirm Mobile Number:",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${mobileNo.text}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        RaisedButton(
                                          color: Colors.white,
                                          onPressed: () async {
                                            int x = widget.checkUser;

                                            switch (x) {
                                              case 1:
                                                {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdminRegister1(
                                                            checkUser: 1,
                                                          ),
                                                    ),
                                                  );
                                                }
                                                break;
                                              case 2:
                                                {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdminRegister1(
                                                            checkUser: 2,
                                                          ),
                                                    ),
                                                  );
                                                }
                                                break;
                                              case 3:
                                                {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdminRegister1(
                                                            checkUser: 3,
                                                          ),
                                                    ),
                                                  );
                                                }
                                                break;
                                              default:
                                                utilitybasic.toastfun(
                                                  "Relogin",
                                                );
                                            }
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(10.0),
                                          ),
                                          child: Text(
                                            "Modify",
                                            style: TextStyle(
                                              color: appcolor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: ScreenUtil().setSp(50),
                                            ),
                                          ),
                                        ),
                                        RaisedButton(
                                          color: Colors.white,
                                          onPressed: () async {
                                            var schoolCheck = "";

                                            if (widget.checkUser == 1) {
                                              schoolCheck = "school_check";
                                              FormData formData =
                                                  new FormData.fromMap({
                                                    "action": "$schoolCheck",
                                                    "mobile": int.parse(
                                                      mobileNo.text,
                                                    ).toString(),
                                                  });
                                              Response response;
                                              Dio dio = new Dio();

                                              response = await dio.post(
                                                url,
                                                data: formData,
                                              );
                                              print(mobileNo.text);
                                              print(
                                                'Response status: ${response.statusCode}',
                                              );
                                              print(
                                                'Response body: ${response.data}',
                                              );
                                              temp123 = json.decode(
                                                response.data,
                                              );
                                              print('temp: $temp123');
                                              schoolId = int.parse(
                                                temp123[0]['schoolid']
                                                    .toString(),
                                              );
                                              await prefs.setint(
                                                "SchoolID",
                                                schoolId,
                                              );
                                              print("schoolID:");
                                              print(schoolId);
                                              otp = temp123[0]['otp'];
                                              print(otp);
                                              await prefs.setString(
                                                "mobile",
                                                mobileNo.text,
                                              );

                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      OtpVerify(checkUser: 1),
                                                ),
                                              );
                                            } else if (widget.checkUser == 2) {
                                              schoolCheck = "staffs_check";
                                              FormData formData =
                                                  new FormData.fromMap({
                                                    "action": "$schoolCheck",
                                                    "mobile": int.parse(
                                                      mobileNo.text,
                                                    ).toString(),
                                                  });
                                              Response response;
                                              Dio dio = new Dio();
                                              var url =
                                                  "http://13.127.33.107/upload/dhanraj/homework/api/staffapi.php";
                                              response = await dio.post(
                                                url,
                                                data: formData,
                                              );
                                              /* response = await http.post(
                                                      url,
                                                      body: jsonEncode({
                                                        "action": schoolCheck,
                                                        "mobile":
                                                            (mobileNo.text)
                                                      })); */
                                              print(mobileNo.text);
                                              print(
                                                'Response status: ${response.statusCode}',
                                              );
                                              print(
                                                'Response body: ${response.data}',
                                              );
                                              temp123 = json.decode(
                                                response.data,
                                              );
                                              print('temp: $temp123');
                                              if (temp123[0]['status'] ==
                                                  "new_staff") {
                                                utilitybasic.toastfun(
                                                  "Contact School Principal",
                                                );
                                              } else {
                                                schoolId =
                                                    temp123[0]['schoolid'];
                                                await prefs.setint(
                                                  "SchoolID",
                                                  int.parse(
                                                    schoolId.toString(),
                                                  ),
                                                );
                                                /* print("schoolID:");
                                                print(schoolId); */
                                                otp = temp123[0]['otp'];
                                                print(otp);
                                                print("Staff: Temp123");
                                                print(temp123);
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        OtpVerify(checkUser: 2),
                                                  ),
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
                                                  3) */ {
                                              schoolCheck = "student_check";
                                              FormData formData =
                                                  new FormData.fromMap({
                                                    "action": "$schoolCheck",
                                                    "mobile": int.parse(
                                                      mobileNo.text,
                                                    ).toString(),
                                                  });
                                              Response response;
                                              Dio dio = new Dio();

                                              response = await dio.post(
                                                url,
                                                data: formData,
                                              );
                                              /* response = await http.post(
                                                      url,
                                                      body: jsonEncode({
                                                        "action": schoolCheck,
                                                        "mobile": int.parse(
                                                            (mobileNo.text)
                                                                .toString())
                                                      })); */
                                              print(mobileNo.text);
                                              print(
                                                'Response status: ${response.statusCode}',
                                              );
                                              print(
                                                'Response body: ${response.data}',
                                              );
                                              var temp = json.decode(
                                                response.data,
                                              );
                                              print('temp: $temp');

                                              otp = temp[0]['otp'];
                                              if (temp[0]['status'] ==
                                                  "new_student") {
                                                utilitybasic.toastfun(
                                                  "Contact Class Teacher",
                                                );
                                              } else {
                                                startTimer();
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        OtpVerify(checkUser: 3),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(10.0),
                                          ),
                                          child: Text(
                                            "GET OTP",
                                            style: TextStyle(
                                              color: appcolor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: ScreenUtil().setSp(50),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );

                          await showDialog(
                            context: context,
                            builder: (BuildContext context) => errorDialog,
                            barrierDismissible: false,
                          );
                        }
                        startTimer();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      color: Color(0xFFffffff),
                      child: Text(
                        "  GET OTP  ",
                        style: TextStyle(
                          color: appcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(50),
                        ),
                      ),
                    ),
                  ),
                ),
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
      (Timer timer) => setState(() {
        if (startTimerC < 1) {
          timer.cancel();
        } else {
          setState(() {
            startTimerC = startTimerC - 1;
          });
        }
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
