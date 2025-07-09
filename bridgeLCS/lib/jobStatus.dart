import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:galubetech/customer.dart';
import 'package:galubetech/dashboardNew.dart';
import 'package:galubetech/feedBackForm.dart';
import 'package:galubetech/jobstatusAdding.dart';
import 'package:galubetech/supplierNew.dart';
import 'package:galubetech/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'jobs.dart';
import 'main.dart';

var jobStatusResponse;
var pendingJobStatusResponse;
var completedJobStatusResponse;
var mutedJobStatusResponse;
bool setProgress = false;
Color colorCode = Colors.white;

class JobStatus extends StatefulWidget {
  JobStatus({Key key}) : super(key: key);

  @override
  _JobStatusState createState() => _JobStatusState();
}

class _JobStatusState extends State<JobStatus> {
// Customer

  bool showFab = true;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    customerFN();
  }

  customerFN() async {
    Response response;
    Dio dio = new Dio();
    try {
      response = await dio.get(
          "http://api.lcsbridge.xyz/status?api_token='$apiToken'&company_id='$companyID'&domain='$domainCode'&status=0",
          queryParameters: {
            "api_token": apiToken,
            "company_id": companyID,
            "domain": domainCode,
            "status": 0,
          });

      pendingJobStatusResponse = response.data;
      response = await dio.get(
          "http://api.lcsbridge.xyz/status?api_token='$apiToken'&company_id='$companyID'&domain='$domainCode'&status=1",
          queryParameters: {
            "api_token": apiToken,
            "company_id": companyID,
            "domain": domainCode,
            "status": 1,
          });
      completedJobStatusResponse = response.data;

      response = await dio.get(
          "http://api.lcsbridge.xyz/status?api_token='$apiToken'&company_id='$companyID'&domain='$domainCode'&status=2",
          queryParameters: {
            "api_token": apiToken,
            "company_id": companyID,
            "domain": domainCode,
            "status": 2,
          });

      mutedJobStatusResponse = response.data;
      setProgress = true;
      setState(() {});
    } catch (e) {
      if (e.response.statusCode == 401) {
        await prefs.setint("loggedIN", 2);

        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePageEx()));
      }
    }
  }

  void showFoatingActionButton(bool value) {
    setState(() {
      showFab = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(height: 10),
                          ListTile(
                            leading: Icon(Icons.dashboard),
                            title: Text("Dashboard",
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DashBoardNew()));
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text("Customers",
                                style: TextStyle(
                                    fontFamily: "Nunito",
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
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                          ListTile(
                            onTap: () async {
                              Navigator.pop(context);
                            },
                            leading: Icon(Icons.loyalty),
                            title: Text("Status",
                                style: TextStyle(
                                    fontFamily: "Nunito",
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
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                          ListTile(
                            onTap: () async {
                              Response response;
                              Dio dio = new Dio();

                              response = await dio.get(
                                  "http://api.lcsbridge.xyz/logout?api_token='$apiToken'&company_id='$companyID'&domain='$domainCode'",
                                  queryParameters: {
                                    "api_token": apiToken,
                                    "company_id": companyID,
                                    "domain": domainCode,
                                  });

                              await prefs.setint("loggedIN", 2);
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
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                      rowPrivacySecurity(context),
                      Image.asset(
                        "assets/images/logo-new.png",
                        height: 40.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          appBar: AppBar(
            elevation: 0.5,
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: Builder(
              builder: (BuildContext context) {
                return Transform.translate(
                  offset: Offset(9, 0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Color(0xff5d5d5d),
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
              children: <Widget>[
                Transform.translate(
                  offset: Offset(-5, 0),
                  child: Text("Job Status",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkResponse(
                        onTap: () async {
                          Response response;

                          Dio dio = new Dio();
                          try {} catch (e) {}
                          response = await dio.get(
                              "http://api.lcsbridge.xyz/companies",
                              queryParameters: {
                                "api_token": "$apiToken",
                                "company_id": "$companyID",
                                "domain": "$domainCode",
                              });

                          var summa = response.data;
                          setState(() {});
                          Dialog errorDialog = Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    10.0 *
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
                                                type: ProgressDialogType.Normal);
                                            pr.style(message: 'Please Wait...');
                                            pr.show();
                                            loginCode = summa['data'][ii]['code'];
                                            companyID = summa['data'][ii]['id'];
                                            companyLogo =
                                                summa['data'][ii]['logo'];
                                            await prefs.setint("CompanyID",
                                                summa['data'][ii]['id']);

                                            await prefs.setString("CODE",
                                                summa['data'][ii]['code']);
                                            await prefs.setString("CompanyLOGO",
                                                summa['data'][ii]['logo']);

                                            companyLogo = await prefs
                                                .getString("CompanyLOGO");
                                            companyID =
                                                await prefs.getInt("CompanyID");
                                            loginCode =
                                                await prefs.getString("CODE");
                                            await customerFN();
                                            setState(() {});
                                            if (pr.isShowing()) pr.hide();

                                            Navigator.pop(context);
                                          },
                                          child: Row(
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CircleAvatar(
                                                      backgroundColor:
                                                          Color(0xff1a73e8),
                                                      child: Text(
                                                        "${summa['data'][ii]['code']}",
                                                        style: TextStyle(fontSize: 12.0,

                                                            fontFamily: "Nunito"),
                                                      ))),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 200.0,
                                                    child: Text(
                                                      "${summa['data'][ii]['name']}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: dialCard(),
                                                    ),
                                                  ),
                                                  Text(
                                                      "${summa['data'][ii]['name']}")
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
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                backgroundColor: Color(0xff1a73e8),
                                child: Text(
                                  "$loginCode",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: "Nunito"),
                                ))),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            iconTheme: new IconThemeData(
              color: Colors.black87, /* size: 80.0 */
            ),
            bottom: pendingJobStatusResponse == null
                ? TabBar(
                    indicatorWeight: 3.0,
                    controller: _tabController,
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: 3.0,
                          color: Color(0xff1c72ea),
                        ),
                        insets: EdgeInsets.symmetric(horizontal: 20.0)),
                    indicatorColor: Color(0xff1c72ea),
                    unselectedLabelColor: Colors.black,
                    labelColor: Color(0xff1a74e6),
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontFamily: "Nunito"),
                    tabs: [
                      Tab(
                        text: "Pending",
                      ),
                      Tab(
                        text: "Updated",
                      ),
                      Tab(
                        text: "Muted",
                      ),
                    ],
                  )
                : TabBar(
                    indicatorWeight: 3.0,
                    controller: _tabController,
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: 3.0,
                          color: Color(0xff1c72ea),
                        ),
                        insets: EdgeInsets.symmetric(horizontal: 20.0)),
                    indicatorColor: Color(0xff1c72ea),
                    unselectedLabelColor: Colors.black,
                    labelColor: Color(0xff1a74e6),
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontFamily: "Nunito"),
                    tabs: [
                      Tab(
                        text: pendingJobStatusResponse.length != 0
                            ? "Pending - ${pendingJobStatusResponse.length}"
                            : "Pending",
                      ),
                      Tab(
                        text: completedJobStatusResponse.length != 0
                            ? "Updated - ${completedJobStatusResponse.length}"
                            : "Updated",
                      ),
                      Tab(
                        text: mutedJobStatusResponse.length != 0
                            ? "Muted - ${mutedJobStatusResponse.length}"
                            : "Muted",
                      ),
                    ],
                  ),
          ),
          body: setProgress == false
              ? Center(child: CircularProgressIndicator())
              : TabBarView(
                  children: [
                    JobsStatusPending(
                      pass: pendingJobStatusResponse,
                      whichTab: 0,
                    ),
                    JobsStatusPending(
                      pass: completedJobStatusResponse,
                      whichTab: 1,
                    ),
                    JobsStatusPending(
                      pass: mutedJobStatusResponse,
                      whichTab: 2,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class JobsStatusPending extends StatefulWidget {
  final pass;
  final int whichTab;
  JobsStatusPending({Key key, @required this.pass, @required this.whichTab})
      : super(key: key);

  @override
  _JobsStatusPendingState createState() => _JobsStatusPendingState();
}

class _JobsStatusPendingState extends State<JobsStatusPending> {
  @override
  Widget build(BuildContext context) {
    return jobStatus(widget.pass, widget.whichTab);
  }
}

Widget jobStatus(var pendingJobStatusResponse, int whichTab) {
  return pendingJobStatusResponse.length ==
          0 /* || pendingJobStatusResponse == null */
      ? Center(
          child: whichTab == 0
              ? Text("Ther is no Item in Pending")
              : (whichTab == 1
                  ? Text("There is no Item in Updated")
                  : (whichTab == 2
                      ? Text("There is no Item in Muted ")
                      : CircularProgressIndicator())
              /* : Text("There is no item in Muted") */))
      : Material(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                      ),
                      shrinkWrap: true,
                      itemCount: pendingJobStatusResponse.length,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JobStatusAdding(
                                        rowID: pendingJobStatusResponse[i]
                                            ['row_no'],
                                        id: pendingJobStatusResponse[i]
                                            ["id"])));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                            ),
                            child: Material(
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    color: Colors.white,
                                    height: 18,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Transform.translate(
                                                  offset: Offset(5, 0),
                                                  child: Row(children: [
                                                    pendingJobStatusResponse[i]
                                                                    ["name"]
                                                                .length >
                                                            15
                                                        ? Container(
                                                            width: 100.0,
                                                            child: Text(
                                                              "${pendingJobStatusResponse[i]["name"]}",
                                                              softWrap: true,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    "Nunito",
                                                              ),
                                                            ),
                                                          )
                                                        : Text(
                                                            "${pendingJobStatusResponse[i]["name"]}",
                                                            softWrap: true,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  "Nunito",
                                                            ),
                                                          ),
                                                    SizedBox(
                                                      width: 4.0,
                                                    ),
                                                    Transform.translate(
                                                      offset: Offset(0, 3),
                                                      child: Text(
                                                        "${pendingJobStatusResponse[i]["posting_date"]}",
                                                        style: TextStyle(
                                                          fontSize: 9,
                                                          fontFamily: "Nunito",
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              ]),
                                          Row(
                                            children: <Widget>[
                                              Transform.translate(
                                                offset: Offset(0, 3),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "${pendingJobStatusResponse[i]["aging"]} days",
                                                        style: TextStyle(
                                                          fontSize: 9,
                                                          fontFamily: "Nunito",
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 4.0,
                                                      ),
                                                      Text(
                                                        "${pendingJobStatusResponse[i]["row_no"]}",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: "Nunito",
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                            ],
                                          ),
                                        ]),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    height: 11,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Transform.translate(
                                          offset: Offset(7, 0),
                                          child: Text(
                                           pendingJobStatusResponse[i]["awb_bill_no"] == null ? "" : "${pendingJobStatusResponse[i]["awb_bill_no"]}",
                                            style: TextStyle(
                                                fontSize: 10.0,
                                                fontFamily: "Nunito"),
                                          ),
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                pendingJobStatusResponse[i]
                                                            ["status"] ==
                                                        null
                                                    ? "NO STATUS"
                                                    : "${pendingJobStatusResponse[i]["status"]}",
                                                softWrap: true,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 9,
                                                  fontFamily: "Nunito",
                                                ),
                                              ),
                                            ]),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
}
