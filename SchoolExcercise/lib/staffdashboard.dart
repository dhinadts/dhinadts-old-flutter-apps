
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school/AttendanceNew.dart';
import 'package:school/StaffNew/AddMarks.dart';
import 'package:school/StaffNew/GeneralItems.dart';
import 'package:school/StaffNew/HomeWork.dart';
import 'package:school/StaffNew/NoticeBoard.dart';
import 'package:school/StaffNew/StudentMapView.dart';
import 'package:school/StaffNew/StudyMaterial.dart';
import 'package:school/StaffNew/ViewClassSubjects.dart';
import 'package:school/db/utility_basics.dart';
import 'package:school/main.dart';
import 'package:school/rough/exitdia.dart';

import 'ScreenUtil.dart';

var utilitybasic = Utility_Basic();
var displayListItem = new List();
var exitApp = ExitDial();

class StaffDashboard extends StatefulWidget {
  @override
  StaffDashboardDetails createState() {
    return new StaffDashboardDetails();
  }
}

class StaffDashboardDetails extends State<StaffDashboard> {
  String isClassradio = "";
  int ict = 0;

  @override
  void initState() {
    super.initState();
    getLoggedIn();
  }

  getLoggedIn() async {
    loggedIn = await prefs.getInt("LoggedIn");
    schoolID = await prefs.getInt("SchoolID");
    schoolName = await prefs.getString("SchoolName");
    nameLoogedAs = await prefs.getString("LoggedName");
    viewLink = await prefs.getString("SchoolLink");
    academicLabel = await prefs.getString("AcademicLabel");
    academicYear = await prefs.getInt("AcademicYear");
    staffID = await prefs.getInt("StaffID");
    isClassTeacher = await prefs.getInt("IsClassTeacher");
    print(loggedIn);
    print("$viewLink, $schoolName, $academicLabel,$academicYear , $schoolID, $isClassTeacher");
    print(staffID);
    setState(() {});

    // lastId = await prefs.getInt("lastID");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exitApp.exitApp(context),
          child: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Staff Dashboard"),
          actions: <Widget>[
            new IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () async {
                /* await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notificationactivity()),
                );*/
              },
            ),
          ],
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100.0,
                    child: Center(
                        child: Text(
                      "Welcome $nameLoogedAs",
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    )),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewCLassSubjects()),
                            );
                          },
                          child: SizedBox(
                            height: ScreenUtil().setHeight(450),
                            width: ScreenUtil().setWidth(500),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Color(0xFFED5751),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/vuas.png",
                                      height: ScreenUtil().setHeight(170),
                                      width: ScreenUtil().setWidth(170),
                                    ),
                                    Text(
                                      "View Subjects & Classes",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentMapView()),
                            );
                          },
                          child: SizedBox(
                            height: ScreenUtil().setHeight(450),
                            width: ScreenUtil().setWidth(500),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Color(0xFFED5751),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/vuas.png",
                                      height: ScreenUtil().setHeight(170),
                                      width: ScreenUtil().setWidth(170),
                                    ),
                                    Text(
                                      "Student Map & View",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeWork()),
                          );
                        },
                        child: SizedBox(
                          height: ScreenUtil().setHeight(450),
                          width: ScreenUtil().setWidth(500),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Color(0xFFFFBA31),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/vuas.png",
                                      height: ScreenUtil().setHeight(170),
                                      width: ScreenUtil().setWidth(170),
                                    ),
                                  ),
                                  Text(
                                    "HomeWork",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudyMaterial()),
                          );
                        },
                        child: SizedBox(
                          height: ScreenUtil().setHeight(450),
                          width: ScreenUtil().setWidth(500),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/vusp.png",
                                    height: ScreenUtil().setHeight(170),
                                    width: ScreenUtil().setWidth(170),
                                  ),
                                  Text("Study Material",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoticeBoardItems()),
                          );
                        },
                        child: SizedBox(
                          height: ScreenUtil().setHeight(450),
                          width: ScreenUtil().setWidth(500),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Color(0xFF036EE4),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/attendence.png",
                                    height: ScreenUtil().setHeight(170),
                                    width: ScreenUtil().setWidth(170),
                                  ),
                                  Text("Notice Board",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GeneralItems()),
                          );
                          // utilitybasic.toastfun("Need To do");
                        },
                        child: SizedBox(
                          height: ScreenUtil().setHeight(450),
                          width: ScreenUtil().setWidth(500),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Color(0xFFED5751),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/utt.png",
                                      height: ScreenUtil().setHeight(170),
                                      width: ScreenUtil().setWidth(170),
                                    ),
                                  ),
                                  Text(
                                    "General",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AttendanceNew()),
                          );
                          
                        },
                        child: SizedBox(
                          height: ScreenUtil().setHeight(450),
                          width: ScreenUtil().setWidth(500),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Color(0xFF20CB9C),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/ashomework.png",
                                    height: ScreenUtil().setHeight(170),
                                    width: ScreenUtil().setWidth(170),
                                  ),
                                  Text("Attendance",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          utilitybasic.toastfun("Need To do");
                        },
                        child: SizedBox(
                          height: ScreenUtil().setHeight(450),
                          width: ScreenUtil().setWidth(500),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Color(0xFF7D75FC),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/sma.png",
                                      height: ScreenUtil().setHeight(170),
                                      width: ScreenUtil().setWidth(170),
                                    ),
                                  ),
                                  Text(
                                    "Upload Time Table",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddMarks()),
                            );
                            utilitybasic.toastfun("Need To do");
                          },
                          child: SizedBox(
                            height: ScreenUtil().setHeight(450),
                            width: ScreenUtil().setWidth(500),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Color(0xFF50B2D7),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/evhomework.png",
                                      height: ScreenUtil().setHeight(170),
                                      width: ScreenUtil().setWidth(170),
                                    ),
                                    Text("Add Marks",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            /* await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ViewSchollProfile(viewLink: viewLink)),
                            ); */
                            utilitybasic.toastfun("Need To do");
                          },
                          child: SizedBox(
                            height: ScreenUtil().setHeight(450),
                            width: ScreenUtil().setWidth(500),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/vusp.png",
                                      height: ScreenUtil().setHeight(170),
                                      width: ScreenUtil().setWidth(170),
                                    ),
                                    Text("Chat",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                  /* GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationBoard()),
                      );
                    },
                    child: SizedBox(
                      height: ScreenUtil().setHeight(450),
                      width: ScreenUtil().setWidth(500),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.asset(
                                "assets/vusp.png",
                                height: ScreenUtil().setHeight(170),
                                width: ScreenUtil().setWidth(170),
                              ),
                              Text("Notification",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ), */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
