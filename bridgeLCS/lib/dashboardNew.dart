import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:galubetech/customer.dart';

import 'package:galubetech/db/sharedprefs.dart';
import 'package:galubetech/feedBackForm.dart';
import 'package:galubetech/jobStatus.dart';
import 'package:galubetech/jobs.dart';
import 'package:galubetech/supplierNew.dart';
import 'package:galubetech/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'main.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rate_my_app/rate_my_app.dart';

import 'dart:async';

class DashBoardNew extends StatefulWidget {
  DashBoardNew({Key key}) : super(key: key);

  @override
  _DashBoardNewState createState() => _DashBoardNewState();
}

var dashboardRes;

class _DashBoardNewState extends State<DashBoardNew> {
  static double _lowerValue = 0.0;
  static double _upperValue = 10.0;
  Color colorCode = Colors.white;
  bool selected = false;
  bool selected1 = false;
  var animationBool = new List();

  RangeValues values = RangeValues(_lowerValue, _upperValue);

  double brightness = 0.0;
  var prefs = SharedPreferenceS();
  DateTime month;
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
  DateTime datePickedDay = new DateTime.now();
  String datePicked = "";
  String daySelected = "Today";
  var monthNumb = 0;

  String newVal = "September";

  @override
  void initState() {
    super.initState();
    datePick();
    apitoken();
    dashboardAPICALL();
    // permissionFN();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await rateMyApp.init();
      if (mounted && rateMyApp.shouldOpenDialog) {
        rateMyApp.showRateDialog(context);
      }
    });
    setState(() {});
  }

  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 2, // Show rate popup on first day of install.
    minLaunches:
        5, // Show rate popup after 5 launches of app after minDays is passed.
  );

  datePick() async {
    datePickedDay = new DateTime.now();
    datePicked = months[DateTime.parse(datePickedDay.toString()).month - 1];
    monthNumb = DateTime.parse(datePickedDay.toString()).month;
    print(monthNumb);
    setState(() {});
  }

  apitoken() async {
    apiToken = await prefs.getString("APIToken");
    companyID = await prefs.getInt("CompanyID");
    loginCode = await prefs.getString("CODE");
    domainCode = await prefs.getString("Domain");
    userEmail = await prefs.getString("userEmail");
    userName = await prefs.getString("userName");
    await prefs.setint("loggedIN", 1);
    loggedIN = await prefs.getInt("loggedIN");
    companyLogo = await prefs.getString("CompanyLOGO");
    compnayImage = await prefs.getString("compnayImage");
    datePicked = months[DateTime.parse(datePickedDay.toString()).month - 1];
  }

  dashboardAPICALL() async {
    // dashboardRes = "";
    Response response;

    Dio dio = new Dio();
    try {
      print(monthNumb);
      response = await dio
          .get("http://api.lcsbridge.xyz/dashboard", queryParameters: {
        "api_token": "$apiToken",
        "company_id": "$companyID",
        "domain": "$domainCode",
        "month": monthNumb,
      });

      if (response.statusCode == 401) {
        await prefs.setint("loggedIN", 2);

        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePageEx()));
      }
      dashboardRes = response.data;
      jobSummary = dashboardRes["jobSummary"];
      dailySummary = dashboardRes["dailySummary"];
      monthlyCount = dashboardRes["monthlyCount"];
      invoiceSummary = dashboardRes["invoiceSummary"];

      setState(() {});
    } catch (e) {
      if (e.response.statusCode == 401) {
        await prefs.setint("loggedIN", 2);

        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePageEx()));
      }

      dashboardRes = null;
      setState(() {});
    }
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    dashboardAPICALL();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 5;
    final double itemWidth = size.width / 2;

    return WillPopScope(
      onWillPop: () async {
        await Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          drawer: Drawer(
            child: SafeArea(
              child: Container(
                // color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        color: Colors.grey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                      icon: Icon(Icons.arrow_back),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                ),
                              ],
                            ),
                            Image.network(
                              companyLogo,
                              height: 80.0,
                              width: 150.0,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    leading: CircleAvatar(
                                        child: Image.network(
                                      companyLogo,
                                      height: 30.0,
                                      width: 30.0,
                                      color: Colors.white,
                                    )),
                                    title: Text("$userName"),
                                    subtitle: Text("$userEmail"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //  SizedBox(height: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ListTile(
                            leading: Icon(Icons.dashboard),
                            title: Text("Dashboard",
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    // fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            onTap: () async {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text("Customers",
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    // fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CustomerPage(
                                            cusOrSup: 1,
                                          )));
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.people),
                            title: Text("Suppliers",
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    // fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SuppliersPage(
                                            cusOrSup: 1,
                                          )));
                            },
                          ),
                          ListTile(
                            onTap: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Jobs()));
                            },
                            leading: Icon(Icons.edit),
                            title: Text("Jobs",
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    // fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                          ListTile(
                            onTap: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => JobStatus()));
                            },
                            leading: Icon(Icons.loyalty),
                            title: Text("Status",
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    // fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                          ListTile(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FeedBack()));
                            },
                            leading: Icon(Icons.feedback),
                            title: Text("Feedback",
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    // fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                          ListTile(
                            onTap: () async {
                              await prefs.setint("loggedIN", 2);
                              // await prefs.setint("loggedIN", 1);
                              await prefs.setString("APIToken", null);
                              await prefs.setint("CompanyID", 0);
                              await prefs.setString("Domain", null);
                              await prefs.setString("CODE", null);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePageEx()));
                            },
                            leading: Icon(Icons.input),
                            title: Text("Logout",
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    // fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                      rowPrivacySecurity(context),
                      Image.asset(
                        "assets/images/logo-new.png",
                        height: 40.0,
                        //  width: 150.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          appBar: AppBar(
            elevation: 1.0,
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: Builder(
              builder: (BuildContext context) {
                return Transform.translate(
                  offset: Offset(9, 0),
                  child: IconButton(
                    // alignment: Alignment(-2.5, 0.0),
                    icon: const Icon(
                      Icons.menu,
                      color: Color(0xff5d5d5d), /* size: 45, */
                    ),
                    iconSize: 30.0,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                );
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Transform.translate(
                  offset: Offset(-5, 0),
                  child: Text("Dashboard",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                Row(
                  children: <Widget>[
                    DropdownButton(
                        isDense: true,
                        // isExpanded: true,
                        underline: SizedBox(),
                        items: months.map((e) {
                          return DropdownMenuItem(
                            child: new Text(
                              e,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: "Nunito",
                              ),
                            ),
                            value: e,
                          );
                        }).toList(),
                        value: datePicked,
                        onChanged: (no) async {
                          setState(() {
                            datePicked = no;
                          });
                          pr = new ProgressDialog(context,
                              type: ProgressDialogType.Normal);
                          pr.style(message: 'Please Wait...');
                          pr.show();
                          for (var i = 0; i < months.length; i++) {
                            if (datePicked == months[i]) {
                              setState(() {
                                monthNumb = i + 1;
                              });
                            }
                          }
                          await dashboardAPICALL();
                          setState(() {});
                          if (pr.isShowing()) pr.hide();
                        }),
                    Material(
                      //  shape: CircleBorder(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      // clipBehavior: Clip.hardEdge,
                      color: Colors.transparent,
                      child: Container(
                        decoration: new BoxDecoration(
                            color: Color(0xff1c72ea),
                            borderRadius: BorderRadius.circular(100)),
                        child: InkWell(
                          onTap: () async {
                            Response response;
                            Dio dio = new Dio();
                            response = await dio.get(
                                "http://api.lcsbridge.xyz/companies", // ?api_token=$apiToken&company_id=$companyID&domain=$domainCode",
                                queryParameters: {
                                  "api_token": "$apiToken",
                                  "company_id": "$companyID",
                                  "domain": "$domainCode",
                                });

                            var summa = response.data;
                            setState(() {});
                            Dialog errorDialog = Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0 *
                                          MediaQuery.of(context)
                                              .devicePixelRatio))),
                              child: Container(
                                height: MediaQuery.of(context).size.height / 2,
                                width: MediaQuery.of(context).size.width,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Companies List",
                                            style: dialCard(),
                                          ),
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        primary: true,
                                        padding: const EdgeInsets.all(10.0),
                                        itemCount: summa['data'].length,
                                        itemBuilder: (context, ii) {
                                          return InkWell(
                                            onTap: () async {
                                              ProgressDialog pr;
                                              pr = new ProgressDialog(context,
                                                  type: ProgressDialogType
                                                      .Normal);
                                              pr.style(
                                                  message: 'Please Wait...');
                                              pr.show();
                                              loginCode =
                                                  summa['data'][ii]['code'];
                                              companyID =
                                                  summa['data'][ii]['id'];
                                              companyLogo =
                                                  summa['data'][ii]['logo'];
                                              await prefs.setint("CompanyID",
                                                  summa['data'][ii]['id']);

                                              await prefs.setString("CODE",
                                                  summa['data'][ii]['code']);
                                              await prefs.setString(
                                                  "CompanyLOGO",
                                                  summa['data'][ii]['logo']);

                                              companyLogo = await prefs
                                                  .getString("CompanyLOGO");
                                              companyID = await prefs
                                                  .getInt("CompanyID");
                                              loginCode =
                                                  await prefs.getString("CODE");
                                              await dashboardAPICALL();
                                              setState(() {});

                                              if (pr.isShowing()) pr.hide();
                                              Navigator.pop(context);
                                            },
                                            child: Row(
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: CircleAvatar(
                                                        backgroundColor:
                                                            Color(0xff1a73e8),
                                                        child: Text(
                                                          "${summa['data'][ii]['code']}",
                                                          style: TextStyle(
                                                              fontSize: 12.0,
                                                              fontFamily:
                                                                  "Nunito"),
                                                        ))),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width:
                                                          200.0, //MediaQuery.of(context).size.width,
                                                      child: Text(
                                                        "${summa['data'][ii]['name']}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: dialCard(),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 150.0,
                                                      child: Text(
                                                        "${summa['data'][ii]['name']}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) => errorDialog,
                              barrierDismissible: true,
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Text(
                              "$loginCode",
                              style: TextStyle(
                                  fontSize: 12.0, fontFamily: "Nunito"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            iconTheme: new IconThemeData(
              color: Colors.black87, /* size: 80.0 */
            ),
          ),
          body: SmartRefresher(
            enablePullDown: true,
            // enablePullUp: true,
            header: WaterDropHeader(),
            controller: _refreshController,
            onRefresh: _onRefresh,

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: dashboardRes == null
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          GridView.count(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              primary: true,
                              padding: const EdgeInsets.all(10.0),
                              crossAxisSpacing: 12.0,
                              mainAxisSpacing: 12.0,
                              // crossAxisCount: selected ? 1 : 2,
                              crossAxisCount: 2,
                              childAspectRatio: (itemWidth / itemHeight),
                              children: [
                                Container(
                                  decoration: new BoxDecoration(
                                      color: Color(0xfff2f2f2),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () async {
                                        print(MediaQuery.of(context)
                                            .devicePixelRatio);
                                            print(MediaQuery.of(context).size.width);
                                            var a = 1;
                                            var b = 12; 
                                            print((a<10) ?? b);
                                        Dialog errorDialog = Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0 *
                                                        MediaQuery.of(context)
                                                            .devicePixelRatio))),
                                            child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    3,
                                                width: 200.0,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Jobs",
                                                                style:
                                                                    dialCard(),
                                                              ),
                                                              Text(datePicked,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Nunito")),
                                                            ]),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: GridView.count(
                                                            shrinkWrap: true,
                                                            physics:
                                                                BouncingScrollPhysics(),
                                                            primary: true,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            crossAxisSpacing:
                                                                12.0,
                                                            mainAxisSpacing:
                                                                12.0,
                                                            // crossAxisCount: selected ? 1 : 2,
                                                            crossAxisCount: 2,
                                                            childAspectRatio:
                                                                (itemWidth /
                                                                    itemHeight),
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "${jobSummary["total"]}",
                                                                    style:
                                                                        dialCard(),
                                                                  ),
                                                                  Text(
                                                                    "Total",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Nunito"),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "${jobSummary["pending"]}",
                                                                    style:
                                                                        dialCard(),
                                                                  ),
                                                                  Text(
                                                                    "Pending",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Nunito"),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "${jobSummary["completed"]}",
                                                                    style:
                                                                        dialCard(),
                                                                  ),
                                                                  Text(
                                                                    "Completed",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Nunito"),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "${jobSummary["cancelled"]}",
                                                                    style:
                                                                        dialCard(),
                                                                  ),
                                                                  Text(
                                                                    "Cancelled",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Nunito"),
                                                                  ),
                                                                ],
                                                              ),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                )));

                                        await showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              errorDialog,
                                          barrierDismissible: true,
                                        );
                                      },
                                      child: Ink(
                                        child: cards(
                                            context,
                                            "Jobs",
                                            jobSummary["total"].toString(),
                                            datePicked),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: new BoxDecoration(
                                      color: Color(0xfff2f2f2),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () async {
                                        Dialog errorDialog = Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0 *
                                                        MediaQuery.of(context)
                                                            .devicePixelRatio))),
                                            child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    3,
                                                width: 200.0,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Income",
                                                                style:
                                                                    dialCard(),
                                                              ),
                                                              Text(datePicked,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Nunito")),
                                                            ]),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: GridView.count(
                                                            shrinkWrap: true,
                                                            physics:
                                                                BouncingScrollPhysics(),
                                                            primary: true,
                                                            /* padding:
                                                              const EdgeInsets
                                                                    .all(10.0),
                                                           */
                                                            crossAxisSpacing:
                                                                12.0,
                                                            mainAxisSpacing:
                                                                12.0,
                                                            // crossAxisCount: selected ? 1 : 2,
                                                            crossAxisCount: 2,
                                                            childAspectRatio:
                                                                (itemWidth /
                                                                    itemHeight),
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "${invoiceSummary["currentMonthRevenue"]}",
                                                                    style:
                                                                        dialCard(),
                                                                  ),
                                                                  Text(
                                                                    "Revenue",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Nunito"),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "${invoiceSummary["currentMonthCost"]}",
                                                                    style:
                                                                        dialCard(),
                                                                  ),
                                                                  Text(
                                                                    "Cost",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Nunito"),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "${invoiceSummary["currentMonthIncome"]}",
                                                                    style:
                                                                        dialCard(),
                                                                  ),
                                                                  Text(
                                                                    "Income",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Nunito"),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "${invoiceSummary["currentMonthMargin"]}",
                                                                    style:
                                                                        dialCard(),
                                                                  ),
                                                                  Text(
                                                                    "Margin",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Nunito"),
                                                                  ),
                                                                ],
                                                              ),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                )));

                                        await showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              errorDialog,
                                          barrierDismissible: true,
                                        );
                                      },
                                      child: cards(
                                          context,
                                          "Income",
                                          invoiceSummary["currentMonthIncome"]
                                              .toString(),
                                          datePicked),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: new BoxDecoration(
                                      color: Color(0xfff2f2f2),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () async {
                                        Dialog errorDialog = Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0 *
                                                        MediaQuery.of(context)
                                                            .devicePixelRatio))),
                                            child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    3,
                                                width: 200.0,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Import",
                                                                style:
                                                                    dialCard(),
                                                              ),
                                                              Text(datePicked,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Nunito")),
                                                            ]),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: GridView.count(
                                                            shrinkWrap: true,
                                                            physics:
                                                                BouncingScrollPhysics(),
                                                            primary: true,
                                                            /*  padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            */
                                                            crossAxisSpacing:
                                                                12.0,
                                                            mainAxisSpacing:
                                                                12.0,
                                                            // crossAxisCount: selected ? 1 : 2,
                                                            crossAxisCount: 2,
                                                            childAspectRatio:
                                                                (itemWidth /
                                                                    itemHeight),
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "${dailySummary["import"]["total"]}",
                                                                    style:
                                                                        dialCard(),
                                                                  ),
                                                                  Text(
                                                                    "Total",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Nunito"),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "${dailySummary["import"]["0-3"]}",
                                                                    style:
                                                                        dialCard(),
                                                                  ),
                                                                  Text(
                                                                    "0-3",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Nunito"),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "${dailySummary["import"]["4-7"]}",
                                                                    style:
                                                                        dialCard(),
                                                                  ),
                                                                  Text(
                                                                    "4-7",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Nunito"),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "${dailySummary["import"]["8-10"]}",
                                                                    style:
                                                                        dialCard(),
                                                                  ),
                                                                  Text(
                                                                    "8-10",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Nunito"),
                                                                  ),
                                                                ],
                                                              ),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                )));

                                        await showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              errorDialog,
                                          barrierDismissible: true,
                                        );
                                      },
                                      child: cards(
                                          context,
                                          "Import",
                                          "${dailySummary["import"]["total"]}",
                                          "$daySelected"),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: new BoxDecoration(
                                      color: Color(0xfff2f2f2),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () async {
                                        Dialog errorDialog = Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0 *
                                                        MediaQuery.of(context)
                                                            .devicePixelRatio))),
                                            child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    3,
                                                width: 200.0,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Export",
                                                                style:
                                                                    dialCard(),
                                                              ),
                                                              Text(datePicked,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Nunito")),
                                                            ]),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: GridView.count(
                                                            shrinkWrap: true,
                                                            physics:
                                                                BouncingScrollPhysics(),
                                                            primary: true,
                                                            crossAxisSpacing:
                                                                12.0,
                                                            mainAxisSpacing:
                                                                12.0,
                                                            crossAxisCount: 2,
                                                            childAspectRatio:
                                                                (itemWidth /
                                                                    itemHeight),
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "${dailySummary["export"]["total"]}",
                                                                    style:
                                                                        dialCard(),
                                                                  ),
                                                                  Text(
                                                                    "Total",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Nunito"),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "${dailySummary["export"]["0-3"]}",
                                                                    style:
                                                                        dialCard(),
                                                                  ),
                                                                  Text(
                                                                    "0-3",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Nunito"),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "${dailySummary["export"]["4-7"]}",
                                                                    style:
                                                                        dialCard(),
                                                                  ),
                                                                  Text(
                                                                    "4-7",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Nunito"),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "${dailySummary["export"]["8-10"]}",
                                                                    style:
                                                                        dialCard(),
                                                                  ),
                                                                  Text(
                                                                    "8-10",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Nunito"),
                                                                  ),
                                                                ],
                                                              ),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                )));

                                        await showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              errorDialog,
                                          barrierDismissible: true,
                                        );
                                      },
                                      child: cards(
                                          context,
                                          "Export",
                                          "${dailySummary["export"]["total"]}",
                                          "$daySelected"),
                                    ),
                                  ),
                                ),
                              ]),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                top: 5.0,
                                bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Income Report",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Nunito"),
                                ),
                                Text(
                                  "2020",
                                  style: TextStyle(
                                      // fontWeight: FontWeight.normal,
                                      fontFamily: "Nunito"),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width - 35,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Income",
                                      style: TextStyle(fontFamily: "Nunito"),
                                    ),
                                    Text(
                                      "${invoiceSummary["YearlyIncome"]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Nunito"),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width - 32,
                                    child: LinearPercentIndicator(
                                      linearStrokeCap:
                                          LinearStrokeCap.values[2],
                                      // width: MediaQuery.of(context).size.width - 35,
                                      lineHeight: 20.0,
                                      percent: (double.tryParse(invoiceSummary[
                                                  "YearlyIncomePercentage"]
                                              .toString()) /
                                          100),
                                      backgroundColor: /* Colors.grey[200],color: */ Color(
                                          0xfff2f2f2),
                                      progressColor: Color(0xff1a73e8),
                                      animationDuration: 2000,
                                      animation: true,
                                    ),
                                  ),
                                  /* Positioned(
                                                                                      /*  left: ((3.1 *
                                                                                            double.tryParse(invoiceSummary[
                                                                                                    "YearlyIncomePercentage"]
                                                                                                .toString())) +
                                                                                        ((double.tryParse(invoiceSummary[
                                                                                                        "YearlyIncomePercentage"]
                                                                                                    .toString()) /
                                                                                                100) *
                                                                                            10)), */
                                                                                      left: ((3.0 *
                                                                                              double.tryParse(invoiceSummary[
                                                                                                      "YearlyIncomePercentage"]
                                                                                                  .toString())) +
                                                                                          8),
                                                                                      top: 5.5,
                                                                                      child: Center(
                                                                                        child: CircleAvatar(
                                                                                            maxRadius: 4.0,
                                                                                            backgroundColor: Colors.white),
                                                                                      ),
                                                                                    ), */
                                ]),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: <Widget>[
                                Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Cost of Sales",
                                            style:
                                                TextStyle(fontFamily: "Nunito"),
                                          ),
                                          Text(
                                            "${invoiceSummary["YearlyCost"]}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Nunito"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                32,
                                        child: LinearPercentIndicator(
                                          // width: MediaQuery.of(context).size.width -
                                          //     35,
                                          lineHeight: 20.0,
                                          percent: (double.tryParse(
                                                  invoiceSummary[
                                                          "YearlyCostPercentage"]
                                                      .toString()) /
                                              100),
                                          backgroundColor: Color(0xfff2f2f2),
                                          progressColor: Color(0xff1a73e8),
                                          animationDuration: 2000,
                                          animation: true,
                                        ),
                                      ),
                                      /* Positioned(
                                                                                          /*  left: ((3.1 *
                                                                                                  double.tryParse(invoiceSummary[
                                                                                                          "YearlyCostPercentage"]
                                                                                                      .toString())) +
                                                                                              ((double.tryParse(invoiceSummary[
                                                                                                              "YearlyCostPercentage"]
                                                                                                          .toString()) /
                                                                                                      100) *
                                                                                                  10)), */
                                                                                          left: ((3.0 *
                                                                                                  double.tryParse(invoiceSummary[
                                                                                                          "YearlyCostPercentage"]
                                                                                                      .toString())) +
                                                                                              8),
                                                                                          top: 5.5,
                                                                                          child: Center(
                                                                                            child: CircleAvatar(
                                                                                                maxRadius: 4.0,
                                                                                                backgroundColor: Colors.white),
                                                                                          ),
                                                                                        ), */
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width - 35,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Sales",
                                        style: TextStyle(fontFamily: "Nunito"),
                                      ),
                                      Text(
                                        "${invoiceSummary["YearlyRevenue"]}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Nunito"),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                32,
                                        child: LinearPercentIndicator(
                                          // width: MediaQuery.of(context).size.width -
                                          //     35,
                                          lineHeight: 20.0,
                                          percent: (double.tryParse(invoiceSummary[
                                                      "YearlyRevenuePercentage"]
                                                  .toString()) /
                                              100),
                                          backgroundColor: Color(0xfff2f2f2),
                                          progressColor: Color(0xff1a73e8),
                                          animationDuration: 2000,
                                          animation: true,
                                        ),
                                      ),
                                      /*  Positioned(
                                                                                          /*  left: ((3.1 *
                                                                                                  double.tryParse(invoiceSummary[
                                                                                                          "YearlyRevenuePercentage"]
                                                                                                      .toString())) +
                                                                                              ((double.tryParse(invoiceSummary[
                                                                                                              "YearlyRevenuePercentage"]
                                                                                                          .toString()) /
                                                                                                      100) *
                                                                                                  10)), */
                                                                                          left: ((3.0 *
                                                                                                  double.tryParse(invoiceSummary[
                                                                                                          "YearlyRevenuePercentage"]
                                                                                                      .toString())) +
                                                                                              8),
                                                                                          top: 5.5,
                                                                                          child: Center(
                                                                                            child: CircleAvatar(
                                                                                                maxRadius: 4.0,
                                                                                                backgroundColor: Colors.white),
                                                                                          ),
                                                                                        ), */
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Month Stats",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  "$datePicked",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontFamily: "Nunito"),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //  crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                progressBarsVertical(
                                    context, "Jobs", monthlyCount["jobs"]),
                                progressBarsVertical(context, "Invoices",
                                    monthlyCount["invoices"]),
                                progressBarsVertical(context, "Quotations",
                                    monthlyCount["quotations"]),
                                Container(
                                  width: 80.0,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 100.0,
                                        child: RotatedBox(
                                          quarterTurns: 3,
                                          child: Stack(
                                              overflow: Overflow.visible,
                                              children: [
                                                LinearPercentIndicator(
                                                  width: 100.0,
                                                  lineHeight: 40.0,
                                                  percent: (double.tryParse(
                                                          monthlyCount[
                                                                  "vouchers"]
                                                              .toString()) /
                                                      350),
                                                  backgroundColor:
                                                      Color(0xfff2f2f2),
                                                  progressColor:
                                                      Color(0xff1a73e8),
                                                ),
                                                /*  monthlyCount["vouchers"] == 0
                                                                                                      ? SizedBox()
                                                                                                      : Positioned(
                                                                                                          left: double.tryParse(
                                                                                                                      monthlyCount[
                                                                                                                              "vouchers"]
                                                                                                                          .toString()) ==
                                                                                                                  350.0
                                                                                                              ? ((10.0 *
                                                                                                                      (double.tryParse(
                                                                                                                          monthlyCount[
                                                                                                                                  "vouchers"]
                                                                                                                              .toString())) *
                                                                                                                      10 /
                                                                                                                      350) -
                                                                                                                  10)
                                                                                                              : ((10.0 *
                                                                                                                      (double.tryParse(
                                                                                                                          monthlyCount[
                                                                                                                                  "vouchers"]
                                                                                                                              .toString())) *
                                                                                                                      10 /
                                                                                                                      350) +
                                                                                                                  10),
                                                                                                          /* left: ((1 / 10) *
                                                                                                                    double.tryParse(
                                                                                                                        monthlyCount[
                                                                                                                                "vouchers"]
                                                                                                                            .toString())) ==
                                                                                                                1.0
                                                                                                            ? ((8 *
                                                                                                                    double.tryParse(
                                                                                                                        monthlyCount[
                                                                                                                                "quotations"]
                                                                                                                            .toString())) +
                                                                                                                10)
                                                                                                            : ((8 *
                                                                                                                    double.tryParse(
                                                                                                                        monthlyCount[
                                                                                                                                "vouchers"]
                                                                                                                            .toString())) -
                                                                                                                10), */
                                                                                                          top: 13,
                                                                                                          child: Center(
                                                                                                            child: CircleAvatar(
                                                                                                                maxRadius: 6.0,
                                                                                                                backgroundColor:
                                                                                                                    Colors.white),
                                                                                                          ),
                                                                                                        ), */
                                              ]),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 15.0),
                                        child: Text(
                                          "${monthlyCount["vouchers"]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Nunito"),
                                        ),
                                      ),
                                      Text(
                                        "Vouchers",
                                        style: TextStyle(fontFamily: "Nunito"),
                                      )
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
          )),
    );
  }
}
