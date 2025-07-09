import 'package:flutter/material.dart';
import 'package:school/ScreenUtil.dart';
import 'package:school/addclassandsections1.dart';
import 'package:school/addstudent.dart';
import 'package:school/main.dart';
import 'package:school/raaja/mappingStaffwithClass1.dart';
import 'package:school/raaja/notificationBoard.dart';
import 'package:school/raaja/studentlistmap.dart';
import 'package:school/rough/academicYearNew.dart';
import 'package:school/rough/addStaffAdmin.dart';

import 'package:school/stafflist.dart';

import 'package:school/totalSubjects.dart';
import 'package:school/viewSchoolProfile.dart';

class AdminDashBoard extends StatefulWidget {
  AdminDashBoard({Key key}) : super(key: key);

  @override
  _AdminDashBoardState createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
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
    academicYear = await prefs.getInt("AcademicYear"); // academicyear ID

    //visibleSet = await prefs.getBool("AcademicBool");
    print(loggedIn);
    print("$viewLink, $schoolName, $academicLabel,$academicYear , $schoolID");
    if (academicYear == 0) {
      setState(() {
        visibleSet = false;
        visibleSett = 0;
      });
      visibleSett = 0;
      await prefs.setint("AcademicSet", visibleSett);
    } else {
      setState(() {
        visibleSet = true;
        visibleSett = 1;
      });
      visibleSett = 1;
      await prefs.setint("AcademicSet", visibleSett);
    }
    /* if (int.parse(academicYear.toString()) > 0) {
      setState(() {
        visibleSet = true;
        visibleSett = 1;
      });
      visibleSett = 1;
      await prefs.setint("AcademicSet", visibleSett);
    } */

    setState(() {});
    // lastId = await prefs.getInt("lastID");
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Welcome $nameLoogedAs"),
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
                GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: <Widget>[
                    visibleSett == 1
                        ? GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AcademicYearNew()),
                                    // AcademicYear()),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/vusp.png",
                                        height: ScreenUtil().setHeight(170),
                                        width: ScreenUtil().setWidth(170),
                                      ),
                                      Text("Academic Year",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ViewSchollProfile(viewLink: viewLink)),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/vusp.png",
                                        height: ScreenUtil().setHeight(170),
                                        width: ScreenUtil().setWidth(170),
                                      ),
                                      Text("View / Update Profile",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                    visibleSett != 0
                        ? GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddStaffAdmin()),
                                    
                                    // AddStaffDetails1()),
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
                                        "Add Admin/Staff",
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    visibleSett != 0
                        ? GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Stafflist()),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/vuas.png",
                                        height: ScreenUtil().setHeight(170),
                                        width: ScreenUtil().setWidth(170),
                                      ),
                                      Text("View / Update Admin - Staff",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    visibleSett != 0
                        ? GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddClasssAndSections1()),
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
                                        "Add Class & Sections",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    visibleSett != 0
                        ? GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TotalSubjects()),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/vusp.png",
                                        height: ScreenUtil().setHeight(170),
                                        width: ScreenUtil().setWidth(170),
                                      ),
                                      Text("Add Subjects",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    visibleSett != 0
                        ? GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MappingStaffsWIthClass1()),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/vusp.png",
                                        height: ScreenUtil().setHeight(170),
                                        width: ScreenUtil().setWidth(170),
                                      ),
                                      Text("Map Staff with Classes",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    visibleSett != 0
                        ? GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddStudentDetails()),
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
                                      Text(
                                        "Add Student",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),                                

                    visibleSett != 0
                        ? GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StudentListMap()),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/vusp.png",
                                        height: ScreenUtil().setHeight(170),
                                        width: ScreenUtil().setWidth(170),
                                      ),
                                      Text("View Student List",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    visibleSett != 0
                        ? GestureDetector(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/vusp.png",
                                        height: ScreenUtil().setHeight(170),
                                        width: ScreenUtil().setWidth(170),
                                      ),
                                      Text("Send Circular",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    /* visibleSett != 0? GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewSchollProfile(
                                          viewLink: viewLink)),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/vusp.png",
                                          height: ScreenUtil().setHeight(170),
                                          width: ScreenUtil().setWidth(170),
                                        ),
                                        Text("View / Update \n Profile",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                            : SizedBox(), */
                  ],
                ),

                /* Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    visibleSett== 0? GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AcademicYear()),
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
                                Text("Academic Year",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ): SizedBox(),
                    visibleSett != 0 
                        ? GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddStaffDetails()),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                        "Add Admin / Staff",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
                ), */

                /*  visibleSett != 0 
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Stafflist()),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/vuas.png",
                                        height: ScreenUtil().setHeight(170),
                                        width: ScreenUtil().setWidth(170),
                                      ),
                                      Text("View / Update \nAdmin - Staff",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20))
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
                                    builder: (context) =>
                                        AddClasssAndSections()),
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
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          "assets/acs.png",
                                          height: ScreenUtil().setHeight(170),
                                          width: ScreenUtil().setWidth(170),
                                        ),
                                      ),
                                      Text(
                                        "Add Class & Sections",
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
                      )
                    : SizedBox(), */
                /* visibleSett != 0 
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                            GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TotalSubjects()),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/vusp.png",
                                          height: ScreenUtil().setHeight(170),
                                          width: ScreenUtil().setWidth(170),
                                        ),
                                        Text("Add Subjects",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20))
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
                                      builder: (context) =>
                                          MappingStaffsWIthClass()),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/vusp.png",
                                          height: ScreenUtil().setHeight(170),
                                          width: ScreenUtil().setWidth(170),
                                        ),
                                        Text("Map Staff with Classes",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ])
                    : SizedBox(), */
                /*  visibleSett != 0 
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddStudentDetails()),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                        "Add Student",
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
                                    builder: (context) => StudentListMap()),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/vusp.png",
                                        height: ScreenUtil().setHeight(170),
                                        width: ScreenUtil().setWidth(170),
                                      ),
                                      Text("View Student List",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(), */
                /* visibleSett != 0 
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                            /*  GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentListMap()),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/vusp.png",
                                    height: ScreenUtil().setHeight(170),
                                    width: ScreenUtil().setWidth(170),
                                  ),
                                  Text("Map Students with Classes",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ), */
                           /*  GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewSchollProfile(
                                          viewLink: viewLink)),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/vusp.png",
                                          height: ScreenUtil().setHeight(170),
                                          width: ScreenUtil().setWidth(170),
                                        ),
                                        Text("View / Update \n Profile",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ), */
                            /* GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddSchoolDetails1()),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/vusp.png",
                                    height: ScreenUtil().setHeight(170),
                                    width: ScreenUtil().setWidth(170),
                                  ),
                                   Text("School detail ....", 
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ), */
                          ])
                    : SizedBox(), */
              ],
            ),
          ),
        ),
      ),
    );
  }
}
