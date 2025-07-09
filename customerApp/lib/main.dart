import 'dart:ui';

import 'package:animated/SplashScreenSample.dart';
import 'package:animated/jobList.dart';
import 'package:animated/loginPage.dart';
import 'package:animated/statementsDownload.dart';
import 'package:animated/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'jobs.dart';
import 'package:flutter/services.dart';
import 'package:animated/utility_basics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  zoomImageHotfix();
  runApp(MyApp());
}

void zoomImageHotfix() {
  WidgetsFlutterBinding.ensureInitialized();
  const maxBytes = 768 * (1 << 20);
  SystemChannels.skia.invokeMethod('setResourceCacheMaxBytes', maxBytes);
  SystemChannels.skia.invokeMethod('Skia.setResourceCacheMaxBytes', maxBytes);
}

int loggedIN = 0;
int introSlide; // = 0;
String custName = "";

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    fn();
    // fn1();
  }

  fn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedIN = prefs.getInt("LoggedIN");
    apiToken = prefs.getString("apiToken");
    companyID = prefs.getInt("companyID");
    domain = prefs.getString("domain");
    cusRowNo = prefs.getString("RowNO");
    introSlide = prefs.getInt("IntroSlides");
    custLogo = prefs.getString("CustLogo");
    custName = prefs.getString("CustName");
    print("introSlide:: $introSlide");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bridge LCS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreenSample(),
    );
  }
}

fn1() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  apiToken = prefs.getString("apiToken");
  companyID = prefs.getInt("companyID");
  domain = prefs.getString("domain");
  cusRowNo = prefs.getString("RowNO");

  Response response;
  Dio dio = new Dio();

  try {
    var url = "https://api.lcsbridge.com/tracking/dashboard";
    response = await dio.get(url,
        queryParameters: ({
          "api_token": "$apiToken",
          "company_id": "$companyID",
          "domain": "$domain",
        }));
    dashBoardRes = response.data;
  } catch (e) {
    print(e);
    print("Print::");
    // print(response.statusCode);
    if (e.response.statusCode == 401) {
      await prefs.setString("apiToken", null);
      await prefs.setInt("companyID", null);
      await prefs.setString("domain", null);
      await prefs.setInt("LoggedIN", null);
      await prefs.setString("LoggedName", null);
    }
  }
}

String apiToken = "";
int companyID = 0;
String domain = "";
String loggedName = "";
String custLogo = "";
String cusRowNo = "";

var dashBoardRes, jobSList, pending, completed;

int _index = 0;

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  var index;
  MyHomePage({Key key, @required this.index, Function fn1()}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final globalScaffoldKey2 = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _index = widget.index;

    net();
    fn();
  }

  @override
  void dispose() {
    super.dispose();
    widget.index = _index;
  }

  void net() async {
    var utilityBasic = UtilityBasicS();
    var net = await utilityBasic.checknetwork();
    if (net == false) {
      customToast(context, "Check net connection");
    }
  }

  fn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiToken = prefs.getString("apiToken");
    companyID = prefs.getInt("companyID");
    domain = prefs.getString("domain");
    loggedName = prefs.getString("LoggedName");
    cusRowNo = prefs.getString("RowNO");

    Response response;
    Dio dio = new Dio();

    var a = UtilityBasicS();
    var net = await a.checknetwork(); // as bool;
    if (net == true) {
      try {
        var url = "https://api.lcsbridge.com/tracking/dashboard";
        response = await dio.get(url,
            queryParameters: ({
              "api_token": "$apiToken",
              "company_id": "$companyID",
              "domain": "$domain",
            }));

        setState(() {
          dashBoardRes = response.data;
        });
        print(dashBoardRes);
      } catch (e) {
        if (e.response.statusCode == 401) {
          await prefs.setString("apiToken", null);
          await prefs.setInt("companyID", null);
          await prefs.setString("domain", null);
          await prefs.setInt("LoggedIN", null);
          await prefs.setString("LoggedName", null);

          await Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
        dashBoardRes = null;
        setState(() {});
      }
    } else {
      dashBoardRes = null;
      setState(() {});
      customToast(context, "Please check net connection");
    }
    setState(() {});
  }

  final tabs = [
    Builder(
      builder: (context) {
        return Home();
      },
    ),
    Builder(
      builder: (context) {
        return JobsList(jobSList: jobSList);
      },
    ),
    Builder(
      builder: (context) {
        return StateMents();
      },
    ),
    Builder(
      builder: (context) {
        return More();
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: Scaffold(
        key: globalScaffoldKey2,
        backgroundColor: Colors.white,
        appBar: _index != 3
            ? AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back_ios, size: 20)),
                elevation: 0.0,
                title: _index != 3
                    ? MediaQuery.of(context).size.width <= 420
                        ? Transform.translate(
                            offset: Offset(-28, 0),
                            child: Text(loggedName == null ? "" : "$loggedName",
                                // overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: "Gilory-Medium",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo)),
                          )
                        : Align(
                            alignment: Alignment(2.2, 0),
                            child: Text("$loggedName",
                                // overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: "Gilory-Medium",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo)),
                          )
                    : Text(""),
              )
            : null,
        body: _index == 3
            ? tabs[3]
            : (dashBoardRes == null
                ? Center(child: CircularProgressIndicator())
                : tabs[_index]),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                MdiIcons.home,
                size: 32,
              ),
              label: 'Home',
              /* title: Text(
                  "Home",
                  style: bottomButtons(),
                ) */
            ),
            BottomNavigationBarItem(
              icon: Icon(
                MdiIcons.pencil,
                size: 32,
              ),
              label: 'Jobs',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                MdiIcons.download,
                size: 32,
              ),
              label: 'Statement',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                MdiIcons.menu,
                size: 32,
              ),
              label: 'More',
            ),
          ],
          onTap: (index) async {
            setState(() {
              _index = index;
              widget.index = index;
            });
          },
          currentIndex: _index,
          selectedItemColor: Colors.blue,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedLabelStyle: bottomButtons(),
          unselectedLabelStyle: TextStyle(fontSize: 13, fontFamily: "Gilory"),
        ),
      ),
    );
  }
}

TextStyle one() {
  return TextStyle(
    fontSize: 20,
  );
}

TextStyle two() {
  return TextStyle(
    fontSize: 15,
  );
}

TextStyle bottomButtons() {
  return TextStyle(fontSize: 15, fontFamily: "Gilory");
}

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

var ab = DateTime.now();
var abc = DateFormat("dd/MM/yy");
var months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];
String monthName = "";

class _HomeState extends State<Home> {
  int _index = 1;

  var newFormat = abc.format(ab);

  @override
  void initState() {
    super.initState();
    newFormat = "TODAY";
    fn();
  }

  fn() async {
    if (apiToken == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt("loggedIN", null);
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
      dashBoardRes = null;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 45.0, top: 15.0, bottom: 15.0),
          child: Text(
            "Dashboard",
            style: TextStyle(
                letterSpacing: 1.0,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: "Gilory-Medium",
                color: Color(0xff202020)),
          ),
        ),
        Container(
          width: 370.0,
          height: 210.0, //250.0,
          child: PageView(
            controller:
                new PageController(initialPage: 1, viewportFraction: 0.835),
            allowImplicitScrolling: true,
            onPageChanged: (i) {
              setState(() {
                _index = i;
              });
            },
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              sliderCardsNew(
                  _index == 0 ? Color(0xff5862fe) : Color(0xFF7F7AFF),
                  0,
                  dashBoardRes["data"]["job_summary"],
                  months[DateTime.parse(DateTime.now().toString()).month - 1],
                  newFormat),
              sliderCardsNew(
                  _index == 1 ? Color(0xff5862fe) : Color(0xFF7F7AFF),
                  1,
                  dashBoardRes["data"]["invoice_count"],
                  months[DateTime.parse(DateTime.now().toString()).month - 1],
                  newFormat),
              sliderCardsNew(
                  _index == 2 ? Color(0xff5862fe) : Color(0xFF7F7AFF),
                  2,
                  dashBoardRes["data"]["statement_summary"],
                  months[DateTime.parse(DateTime.now().toString()).month - 1],
                  newFormat),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 8.0,
                width: 8.0,
                decoration: BoxDecoration(
                    color: _index == 0 ? Color(0xff5862fe) : Color(0xFF7F7AFF),
                    borderRadius: BorderRadius.circular(100.0)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 8.0,
                width: 8.0,
                decoration: BoxDecoration(
                    color: _index == 1 ? Color(0xff5862fe) : Color(0xFF7F7AFF),
                    borderRadius: BorderRadius.circular(100.0)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 8.0,
                width: 8.0,
                decoration: BoxDecoration(
                    color: _index == 2 ? Color(0xff5862fe) : Color(0xFF7F7AFF),
                    borderRadius: BorderRadius.circular(100.0)),
              ),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 15.0, left: 28.0, right: 28.0, bottom: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Pending Jobs",
                  style: TextStyle(
                      letterSpacing: 1.0,
                      fontSize: 17,
                      fontFamily: "Gilory-Medium",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF202020))),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(index: 1)));
                },
                child: Text(
                  "See all",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Gilory-Medium",
                      color: Color(0xff5862fe)),
                ),
              ),
            ],
          ),
        ),
        dashBoardRes["data"]["jobs"].length == 0
            ? Padding(
                // padding: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.only(
                  top: 15.0, /*  left: 28.0, right: 28.0, bottom: 0.0 */
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Center(
                      child: Text("No items",
                          style: TextStyle(color: Colors.black))),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                    top: 15.0, left: 28.0, right: 28.0, bottom: 0.0),
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemCount: dashBoardRes["data"]["jobs"].length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Jobs(
                                    rowID: dashBoardRes["data"]["jobs"][i]
                                        ["row_no"],
                                    id: dashBoardRes["data"]["jobs"][i]["id"],
                                    comp: false,
                                  )));
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 5.0, left: 0.0, right: 0.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        "${dashBoardRes["data"]["jobs"][i]["row_no"]} - ",
                                        style: TextStyle(
                                            color: Color(0xff757575),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Gilory-Medium",
                                            fontSize: 17.0)),
                                    Text(
                                        dashBoardRes["data"]["jobs"][i]
                                                        ["awb_bill_no"] ==
                                                    null ||
                                                dashBoardRes["data"]["jobs"][i]
                                                        ["awb_bill_no"] ==
                                                    ""
                                            ? "AWB No"
                                            : "${dashBoardRes["data"]["jobs"][i]["awb_bill_no"]}",
                                        style: TextStyle(
                                            color: Color(0xff757575),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Gilory-Medium",
                                            fontSize: 12.0)),
                                  ],
                                ),
                                if ((dashBoardRes["data"]["jobs"][i]["pol"] ==
                                            "" ||
                                        dashBoardRes["data"]["jobs"][i]
                                                ["pol"] ==
                                            null) &&
                                    (dashBoardRes["data"]["jobs"][i]["pod"] ==
                                            "" ||
                                        dashBoardRes["data"]["jobs"][i]
                                                ["pod"] ==
                                            null))
                                  Text(
                                    "POL-POD",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: "Gilory-Medium",
                                      fontSize: 12.0,
                                    ),
                                  )
                                else if ((dashBoardRes["data"]["jobs"][i]
                                            ["pol"] ==
                                        "" ||
                                    dashBoardRes["data"]["jobs"][i]["pol"] ==
                                        null))
                                  Text(
                                    "POL-${dashBoardRes["data"]["jobs"][i]["pod"]}",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: "Gilory-Medium",
                                      fontSize: 12.0,
                                    ),
                                  )
                                else if ((dashBoardRes["data"]["jobs"][i]
                                            ["pod"] ==
                                        "" ||
                                    dashBoardRes["data"]["jobs"][i]["pod"] ==
                                        null))
                                  Text(
                                    "${dashBoardRes["data"]["jobs"][i]["pol"]}-POD",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: "Gilory-Medium",
                                      fontSize: 12.0,
                                    ),
                                  )
                                else
                                  Text(
                                    "${dashBoardRes["data"]["jobs"][i]["pol"]}-${dashBoardRes["data"]["jobs"][i]["pod"]}",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: "Gilory-Medium",
                                      fontSize: 12.0,
                                    ),
                                  ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if ((dashBoardRes["data"]["jobs"][i]
                                                ["status"] ==
                                            "" ||
                                        dashBoardRes["data"]["jobs"][i]
                                                ["status"] ==
                                            null) &&
                                    (dashBoardRes["data"]["jobs"][i]
                                                ["status_date"] ==
                                            "" ||
                                        dashBoardRes["data"]["jobs"][i]
                                                ["status_date"] ==
                                            null))
                                  Text(
                                    "STATUS - DATE",
                                    style: TextStyle(
                                      color: Color(0xFF313131),
                                      fontFamily: "Gilory-Medium",
                                      fontSize: 12.0,
                                    ),
                                  )
                                else if ((dashBoardRes["data"]["jobs"][i]
                                            ["status"] ==
                                        "" ||
                                    dashBoardRes["data"]["jobs"][i]["status"] ==
                                        null))
                                  Text(
                                    "STATUS - ${dashBoardRes["data"]["jobs"][i]["status_date"]}",
                                    style: TextStyle(
                                      color: Color(0xFF313131),
                                      fontFamily: "Gilory-Medium",
                                      fontSize: 12.0,
                                    ),
                                  )
                                else if ((dashBoardRes["data"]["jobs"][i]
                                            ["status_date"] ==
                                        "" ||
                                    dashBoardRes["data"]["jobs"][i]
                                            ["status_date"] ==
                                        null))
                                  Text(
                                    "${dashBoardRes["data"]["jobs"][i]["status"]} - DATE",
                                    style: TextStyle(
                                      color: Color(0xFF313131),
                                      fontFamily: "Gilory-Medium",
                                      fontSize: 12.0,
                                    ),
                                  )
                                else
                                  Text(
                                    "${dashBoardRes["data"]["jobs"][i]["status"]} - ${dashBoardRes["data"]["jobs"][i]["status_date"]}",
                                    style: TextStyle(
                                      color: Color(0xFF313131),
                                      fontFamily: "Gilory-Medium",
                                      fontSize: 12.0,
                                    ),
                                  ),
                                /*  Text(
                                    "${dashBoardRes["data"]["jobs"][i]["status"]} - ${dashBoardRes["data"]["jobs"][i]["status_date"]}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Gilory-Medium",
                                        color: Color(0xFF313131))), */
                                Text(
                                    dashBoardRes["data"]["jobs"][i]["eta"] ==
                                                "" ||
                                            dashBoardRes["data"]["jobs"][i]
                                                    ["eta"] ==
                                                null
                                        ? "ETA ETA"
                                        : "ETA ${dashBoardRes["data"]["jobs"][i]["eta"]}",
                                    style: TextStyle(
                                        fontFamily: "Gilory-Medium",
                                        fontSize: 12,
                                        color: Color(0xFF313131)))
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Divider(
                              color: Colors.grey[400],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })
      ],
    );
  }
}

Widget dotsC() {
  return Container(
    height: 50.0,
    width: 50.0,
    color: Colors.red,
    decoration: BoxDecoration(
      border: Border.all(),
    ),
  );
}

class More extends StatefulWidget {
  const More({Key key}) : super(key: key);

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  void initState() {
    super.initState();
  }

  fn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    custLogo = prefs.getString("CustLogo");
    custName = prefs.getString("CustName");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.network(
                        custLogo,
                        width: MediaQuery.of(context).size.width, // * 0.15,
                        height: 70,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "$custName",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Gilory-Medium",
                          color: Colors.blue,
                          fontSize: 18.0),
                    ),
                  ),
                  Container(
                    color: Colors.grey[100],
                    height: MediaQuery.of(context).size.width / 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                      height: 70.0,
                                      width: 70.0,
                                      /* decoration: BoxDecoration(
                                          border: Border.all(
                                              style: BorderStyle.solid,
                                              color: Colors.white,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(100)), */
                                      child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Text(
                                            "${loggedName[0]}${loggedName[1]}"
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 25.0,
                                                fontFamily: "Gilory-Medium"),
                                          )))),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 8.0, bottom: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width <
                                              400
                                          ? 220.0
                                          : 245.0,
                                      child: Text("$loggedName",
                                          textAlign: TextAlign.start,
                                          maxLines: 1, //2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontFamily: "Gilory-Medium",
                                              fontSize: 18.0)),
                                    ),
                                    SizedBox(height: 8),
                                    Text(cusRowNo,
                                        style: TextStyle(
                                            fontFamily: "Gilory-Medium",
                                            fontSize: 15.0)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          //  Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: [
                        moreWidget(
                            context,
                            Icon(Icons.lock, color: Colors.grey[700]),
                            "Password change",
                            1),
                        Divider(indent: 55.0, color: Colors.grey[400]),
                        moreWidget(
                            context,
                            Icon(Icons.loyalty, color: Colors.grey[700]),
                            "Privacy Policy",
                            2),
                        Divider(indent: 55.0, color: Colors.grey[400]),
                        moreWidget(
                            context,
                            Icon(Icons.security, color: Colors.grey[700]),
                            "Security",
                            3),
                        Divider(indent: 55.0, color: Colors.grey[400]),
                        moreWidget(
                            context,
                            Icon(Icons.message_outlined,
                                color: Colors.grey[700]),
                            "Feedback",
                            4),
                        Divider(indent: 55.0, color: Colors.grey[400]),
                        moreWidget(
                            context,
                            Icon(Icons.input, color: Colors.grey[700]),
                            "Logout",
                            5),
                        Divider(indent: 55.0, color: Colors.grey[400]),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Container(
                color: Colors.grey[200],
                height: 40,
                child: Center(
                    child: Text("Version 1.0.0+1",
                        style: TextStyle(fontFamily: "Gilory-Medium"))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Map jobDetails = {
  "title": "",
  "type": null,
  "message": [],
  "data": {
    "job": {
      "id": null,
      "row_no": null,
      "awb_bill_no": null,
      "posting_date": null,
      "pol": null,
      "pod": null,
      "eta": null,
      "etd": null,
      "client_reference": null,
      "bayan_no": null,
      "carrier": "",
      "commodity": "",
      "vessel_flt_no": "",
      "weight": "",
      "volume": "",
      "aging": null
    },
    "services": {},
    "files": [],
    "status": [],
  }
};
