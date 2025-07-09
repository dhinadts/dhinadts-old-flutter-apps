import 'package:flutter/material.dart';
import 'package:school/StaffNew/AssigningHomeWork.dart';
import 'package:school/adminDashBoard.dart';
import 'package:school/adminRegister.dart';
import 'package:school/db/utility_basics.dart';
import 'package:school/rough/mapRough.dart';

import 'package:school/staffdashboard.dart';
import 'package:school/studentdashboard.dart';

import 'ScreenUtil.dart';
import 'db/sharedprefs.dart';

var utilitybasic = Utility_Basic();

int loggedIn; // = -1;
int schoolID;
var nameLoogedAs,
    viewLink,
    schoolName,
    academicLabel,
    academicYear,
    isClassTeacher;
bool visibleSet = false;
int visibleSett = 0;
var staffID;

void main() => runApp(MyApp());
Color appcolor = Color(0xFF4169E1);

var prefs = SharedPreferenceS();

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    checkNet();
    getLoggedIn();
  }

  checkNet() async {
    var net = await utilitybasic.checknetwork();
    if (net == false) {
      utilitybasic.toastfun("Check Net ");
    } else {
      utilitybasic.toastfun("Welcome to School App");
    }
  }

  /* getLoggedIn() async {
    loggedIn = await prefs.getInt("LoggedIn");
    print(loggedIn);
    setState(() {});
    // lastId = await prefs.getInt("lastID");
  } */
  getLoggedIn() async {
    loggedIn = await prefs.getInt("LoggedIn");
    schoolID = await prefs.getInt("SchoolID");
    schoolName = await prefs.getString("SchoolName");
    nameLoogedAs = await prefs.getString("LoggedName");
    viewLink = await prefs.getString("SchoolLink");
    academicLabel = await prefs.getString("AcademicLabel");
    academicYear = await prefs.getInt("AcademicYear");
    isClassTeacher = await prefs.getInt("IsClassTeacher");

    print(loggedIn);
    print("$viewLink, $schoolName, $academicLabel,$academicYear , $schoolID");
    setState(() {});
    /* if (int.parse(academicYear.toString()) > 0)  {
      setState(() {
        visibleSet = true;
        visibleSett = 1;
      });
      visibleSett = 1;
      await prefs.setint("AcademicSet", visibleSett);
    } */
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

    // lastId = await prefs.getInt("lastID");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nithra School',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: appcolor,
          primaryColorDark: Colors.white),
      home: loggedIn == 3
          ? StudentDashboard()
          : (loggedIn == 2
              ? StaffDashboard()
              : (loggedIn == 1
                  ? AdminDashBoard()
                  : (loggedIn == 0
                      ? SafeArea(child: MyHomePage(title: ''))
                      : HomeScreen()))),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    checkNet();
  }

  checkNet() async {
    var net = await utilitybasic.checknetwork();
    if (net == true) {
    } else {
      utilitybasic.toastfun("Check Net ");
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return Container(
      color: appcolor,
      height: double.infinity,
      width: double.infinity,
      child: Center(child: Text("")),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0.0,
      ),
      body: Container(
        color: appcolor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset(
                    "assets/homelogo.png",
                    height: ScreenUtil().setHeight(250),
                    width: ScreenUtil().setWidth(250),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "SCHOOL HOMEWORK",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(50)),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ButtonTheme(
                      minWidth: ScreenUtil().setWidth(800),
                      height: ScreenUtil().setHeight(170),
                      child: RaisedButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    // AdminRegister1(checkUser: 1)),
                                    // AddClasssAndSections1()),
                                    RoughMappingStaffWithSub()),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        color: Color(0xFF00B2FE),
                        child: Text(
                          "I am Admin",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(50)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ButtonTheme(
                      minWidth: ScreenUtil().setWidth(800),
                      height: ScreenUtil().setHeight(170),
                      child: RaisedButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AdminRegister1(checkUser: 2)),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        color: Color(0xFFFEDC00),
                        child: Text(
                          "I am Teacher",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(50)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ButtonTheme(
                      minWidth: ScreenUtil().setWidth(800),
                      height: ScreenUtil().setHeight(170),
                      child: RaisedButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    // RoughMappingStaffWithSub()),
                                    // AcademicYearNew()),
                                    AssigningHomeWork()),
                            // ViewStudents()),
                            // MapStudentWithClasses())
                            // AdminRegister(checkUser: 3)),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        color: Color(0xFFE100CE),
                        child: Text(
                          "I am Student",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(50)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Text(
                "* If you have school Sign up,\nBuild your Admin",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(50)),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
