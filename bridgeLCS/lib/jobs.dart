// Customer

import 'dart:io';
import 'dart:ui';
import 'package:galubetech/jobstatusAdding.dart';
import 'package:galubetech/supplierNew.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as Io;
import 'package:permission_handler/permission_handler.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:galubetech/addjobStatus.dart';
import 'package:galubetech/customer.dart';
import 'package:galubetech/db/utility_basics.dart';
import 'package:galubetech/feedBackForm.dart';
import 'package:galubetech/jobStatus.dart';
import 'package:galubetech/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'fileupload.dart';

import 'dashboardNew.dart';

import 'main.dart';

Color colorCode = Colors.white;
var jobsDetailedResponse;
var pendingJobsDetailedResponse;
var completedJobsDetailedResponse;
var cancelledJobsDetailedResponse;

double incVal = 1.0;
bool setProgress1 = false;

class Jobs extends StatefulWidget {
  Jobs({Key key}) : super(key: key);

  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  bool showFab = true;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    defaultFN();
    // setState(() {});
  }

  defaultFN() async {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(message: 'Please Wait...');
    await pr.show();
    Response response;
    Dio dio = new Dio();
    try {
      response = await dio.get(
          "http://api.lcsbridge.xyz/jobs?api_token='$apiToken'&company_id='$companyID'&domain='$domainCode'",
          queryParameters: {
            "api_token": apiToken,
            "company_id": companyID,
            "domain": domainCode,
          });

      jobsDetailedResponse = response.data;
      pendingJobsDetailedResponse = jobsDetailedResponse["Pending"];
      completedJobsDetailedResponse = jobsDetailedResponse["Completed"];
      cancelledJobsDetailedResponse = jobsDetailedResponse["Cancelled"];
      setProgress1 = true;
      setState(() {});

      if (pr.isShowing()) await pr.hide();
    } catch (e) {
      if (e.response.statusCode == 401) {
        await prefs.setint("loggedIN", 2);

        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePageEx()));
      }
    }

    setState(() {});
  }

  void showFoatingActionButton(bool value) {
    setState(() {
      showFab = value;
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    refreshITEMS();
    _refreshController.refreshCompleted();
  }

  refreshITEMS() async {
    Response response;
    Dio dio = new Dio();
    try {
      response = await dio.get(
          "http://api.lcsbridge.xyz/jobs?api_token=$apiToken&company_id=$companyID&domain=$domainCode",
          queryParameters: {
            "api_token": apiToken,
            "company_id": companyID,
            "domain": domainCode,
          });
      jobsDetailedResponse = response.data;

      pendingJobsDetailedResponse = jobsDetailedResponse["Pending"];
      completedJobsDetailedResponse = jobsDetailedResponse["Completed"];
      cancelledJobsDetailedResponse = jobsDetailedResponse["Cancelled"];
      setState(() {});
    } catch (e) {
      if (e.response.statusCode == 401) {
        await prefs.setint("loggedIN", 2);
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePageEx()));
      }
    }
    setProgress1 = true;
    setState(() {});
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
                              // color: Colors.grey,
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
                              Navigator.pop(context);
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
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => JobStatus()));
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
                        //  width: 150.0,
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
              children: <Widget>[
                Transform.translate(
                  offset: Offset(-5, 0),
                  child: Text("Jobs",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                GestureDetector(
                  onTap: () {
                    refreshITEMS();
                  },
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkResponse(
                          onTap: () async {
                            Response response;

                            Dio dio = new Dio();
                            try {} catch (e) {}
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

                                              await refreshITEMS();
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
                                                      width: 200.0,
                                                      child: Text(
                                                        "${summa['data'][ii]['name']}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                        fontSize: 12.0, fontFamily: "Nunito"),
                                  ))),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            iconTheme: new IconThemeData(
              color: Colors.black87, /* size: 80.0 */
            ),
            bottom: TabBar(
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
                  color: Colors.black, fontSize: 12.0, fontFamily: "Nunito"),
              tabs: [
                Tab(
                  text: pendingJobsDetailedResponse == null
                      ? "Pending"
                      : (pendingJobsDetailedResponse["Count"] > 0
                          ? "Pending - ${pendingJobsDetailedResponse["Count"]}"
                          : "Pending"),
                ),
                Tab(
                  text: completedJobsDetailedResponse == null
                      ? "Completed"
                      : (completedJobsDetailedResponse["Count"] > 0
                          ? "Completed - ${completedJobsDetailedResponse["Count"]}"
                          : "Completed"),
                ),
                Tab(
                  text: cancelledJobsDetailedResponse == null
                      ? "Cancelled"
                      : (cancelledJobsDetailedResponse["Count"] > 0
                          ? "Cancelled - ${cancelledJobsDetailedResponse["Count"]}"
                          : "Cancelled"),
                ),
              ],
            ),
          ),
          body: SmartRefresher(
            enablePullDown: true,
            header: WaterDropHeader(),
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: setProgress1 == false
                ? Center(child: CircularProgressIndicator())
                : TabBarView(
                    children: [
                      SmartRefresher(
                          enablePullDown: true,
                          header: WaterDropHeader(),
                          controller: _refreshController,
                          onRefresh: _onRefresh,
                          child: setProgress1
                              ? JobsPending()
                              : Center(child: CircularProgressIndicator())),
                      SmartRefresher(
                          enablePullDown: true,
                          header: WaterDropHeader(),
                          controller: _refreshController,
                          onRefresh: _onRefresh,
                          child: JobsCompleted()),
                      SmartRefresher(
                          enablePullDown: true,
                          header: WaterDropHeader(),
                          controller: _refreshController,
                          onRefresh: _onRefresh,
                          child: JobsCancelled()),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class JobsPending extends StatefulWidget {
  JobsPending({Key key}) : super(key: key);

  @override
  _JobsPendingState createState() => _JobsPendingState();
}

class _JobsPendingState extends State<JobsPending> {
  @override
  Widget build(BuildContext context) {
    // print(pendingJobsDetailedResponse);
    return Scaffold(
      backgroundColor: Colors.white,
      body: pendingJobsDetailedResponse == null
          ? Center(child: Text("There is no Pending jobs"))
          : Material(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      pendingJobsDetailedResponse["Favourites"].length != 0
                          ? title("Favourites")
                          : SizedBox(),
                      pendingJobsDetailedResponse["Favourites"].length != 0
                          ? eachContents("Favourites",
                              pendingJobsDetailedResponse["Favourites"])
                          : SizedBox(),
                      pendingJobsDetailedResponse["Today"].length != 0
                          ? title("Today")
                          : SizedBox(),
                      pendingJobsDetailedResponse["Today"].length != 0
                          ? eachContents(
                              "Today", pendingJobsDetailedResponse["Today"])
                          : SizedBox(),
                      pendingJobsDetailedResponse["Last 7 Days"] != 0
                          ? title("Last 7 Days")
                          : SizedBox(),
                      pendingJobsDetailedResponse["Last 7 Days"].length != 0
                          ? eachContents("Last 7 Days",
                              pendingJobsDetailedResponse["Last 7 Days"])
                          : SizedBox(),
                      pendingJobsDetailedResponse["Earlier"].length != 0
                          ? title("Earlier")
                          : SizedBox(),
                      pendingJobsDetailedResponse["Earlier"].length != 0
                          ? eachContents(
                              "Earlier", pendingJobsDetailedResponse["Earlier"])
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

Widget title(String title) {
  return Padding(
    padding: const EdgeInsets.only(top: 22.0, bottom: 12.0),
    child: Transform.translate(
      offset: Offset(15, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Material(
          color: Colors.white,
          child: Text(
            "$title",
            style: TextStyle(
                fontSize: 12 + incVal,
                fontWeight: FontWeight.bold,
                fontFamily: "Nunito"),
          ),
        ),
      ),
    ),
  );
}

class JobsCompleted extends StatefulWidget {
  JobsCompleted({Key key}) : super(key: key);

  @override
  _JobsCompletedState createState() => _JobsCompletedState();
}

class _JobsCompletedState extends State<JobsCompleted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: completedJobsDetailedResponse == null
          ? Center(child: Text("There is no Completed jobs"))
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
                      completedJobsDetailedResponse["Favourites"].length == 0
                          ? SizedBox()
                          : title("Favourites"),
                      completedJobsDetailedResponse["Favourites"].length != 0
                          ? eachContents("Favourites",
                              completedJobsDetailedResponse["Favourites"])
                          : SizedBox(),
                      completedJobsDetailedResponse["Today"].length == 0
                          ? SizedBox()
                          : title("Today"),
                      completedJobsDetailedResponse["Today"].length != 0
                          ? eachContents(
                              "Today", completedJobsDetailedResponse["Today"])
                          : SizedBox(),
                      completedJobsDetailedResponse["Last 7 Days"].length != 0
                          ? title("Last 7 Days")
                          : SizedBox(),
                      completedJobsDetailedResponse["Last 7 Days"].length != 0
                          ? eachContents("Last 7 Days",
                              completedJobsDetailedResponse["Last 7 Days"])
                          : SizedBox(),
                      completedJobsDetailedResponse["Earlier"] != 0
                          ? title("Earlier")
                          : SizedBox(),
                      completedJobsDetailedResponse["Earlier"].length != 0
                          ? eachContents("Earlier",
                              completedJobsDetailedResponse["Earlier"])
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class JobsCancelled extends StatefulWidget {
  JobsCancelled({Key key}) : super(key: key);

  @override
  _JobsCancelledState createState() => _JobsCancelledState();
}

class _JobsCancelledState extends State<JobsCancelled> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: cancelledJobsDetailedResponse == null
          ? Center(
              child: Text("There is no Cancelled Jobs"),
            )
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
                      cancelledJobsDetailedResponse["Favourites"].length == 0
                          ? SizedBox()
                          : title("Favourites"),
                      cancelledJobsDetailedResponse["Favourites"].length != 0
                          ? eachContents("Favourites",
                              cancelledJobsDetailedResponse["Favourites"])
                          : SizedBox(),
                      cancelledJobsDetailedResponse["Today"].length == 0
                          ? SizedBox()
                          : title("Today"),
                      cancelledJobsDetailedResponse["Today"].length != 0
                          ? eachContents(
                              "Today", cancelledJobsDetailedResponse["Today"])
                          : SizedBox(),
                      cancelledJobsDetailedResponse["Last 7 Days"].length != 0
                          ? title("Last 7 Days")
                          : SizedBox(),
                      cancelledJobsDetailedResponse["Last 7 Days"].length != 0
                          ? eachContents("Last 7 Days",
                              cancelledJobsDetailedResponse["Last 7 Days"])
                          : SizedBox(),
                      cancelledJobsDetailedResponse["Earlier"] != 0
                          ? title("Earlier")
                          : SizedBox(),
                      cancelledJobsDetailedResponse["Earlier"].length != 0
                          ? eachContents("Earlier",
                              cancelledJobsDetailedResponse["Earlier"])
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

bool showFabExtra = false;

void showFloatingActionButton(bool value) {
  showFabExtra = value;
}

Widget eachContents(String title, var pendingJobsDetailedResponse) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: ListView.builder(
      padding: EdgeInsets.only(
        left: 8.0,
        right: 8.0,
      ),
      shrinkWrap: true,
      itemCount: pendingJobsDetailedResponse.length,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, i) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.grey,
            highlightColor: Colors.grey,
            onTap: () async {
              showModalBottomSheet(
                  elevation: 5.0,
                  context: context,
                  builder: (context) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 250.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Transform.translate(
                                    offset: Offset(22, 0),
                                    child: Text(
                                      "${pendingJobsDetailedResponse[i]["row_no"]}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: "Nunito",
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.file_upload,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    "Upload Files",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Nunito"),
                                  ),
                                  onTap: () async {
                                    // print(
                                    //     '${pendingJobsDetailedResponse[i]["id"]}');
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FileUpload(
                                                  rowID:
                                                      pendingJobsDetailedResponse[
                                                          i]["row_no"],
                                                  id: pendingJobsDetailedResponse[
                                                      i]["id"],
                                                )));
                                  },
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.view_list,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    "View Uploaded Files",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Nunito"),
                                  ),
                                  onTap: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewUploadedFiles(
                                                  rowID:
                                                      pendingJobsDetailedResponse[
                                                          i]["row_no"],
                                                  id: pendingJobsDetailedResponse[
                                                      i]["id"],
                                                )));
                                  },
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.view_module,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    "View Job Status",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Nunito"),
                                  ),
                                  onTap: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                JobStatusAdding(
                                                  rowID:
                                                      pendingJobsDetailedResponse[
                                                          i]["row_no"],
                                                  id: pendingJobsDetailedResponse[
                                                      i]["id"],
                                                )));
                                  },
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.add_box,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    "Add Job Status",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Nunito"),
                                  ),
                                  onTap: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddJobStatus(
                                                  rowID:
                                                      pendingJobsDetailedResponse[
                                                          i]["row_no"],
                                                  id: pendingJobsDetailedResponse[
                                                      i]["id"],
                                                )));
                                  },
                                ),
                              ],
                            )),
                      ));
            },
            child: Material(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 20,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Transform.translate(
                                    offset: Offset(4, 2),
                                    child: Icon(
                                      Icons.fiber_manual_record,
                                      size: 10.0,
                                      color: pendingJobsDetailedResponse[i]
                                                  ["invoiced"] ==
                                              2
                                          ? Colors.blue
                                          : (pendingJobsDetailedResponse[i]
                                                      ["invoiced"] ==
                                                  1
                                              ? Colors.orange
                                              : Colors.grey),
                                    )),
                                Transform.translate(
                                  offset: Offset(5, 0),
                                  child: Row(children: [
                                    if (pendingJobsDetailedResponse[i]["name"]
                                            .length >
                                        15)
                                      Container(
                                        width: 100.0,
                                        child: Text(
                                          "${pendingJobsDetailedResponse[i]["name"]}",
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 15 + incVal,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Nunito",
                                          ),
                                        ),
                                      )
                                    else
                                      Text(
                                        "${pendingJobsDetailedResponse[i]["name"]}",
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15 + incVal,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Nunito",
                                        ),
                                      ),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Transform.translate(
                                      offset: Offset(0, 3),
                                      child: Text(
                                        "${pendingJobsDetailedResponse[i]["aging"]} days",
                                        style: TextStyle(
                                          fontSize: 7 + incVal,
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
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${pendingJobsDetailedResponse[i]["posting_date"]}",
                                        style: TextStyle(
                                          fontSize: 10 + incVal,
                                          fontFamily: "Nunito",
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4.0,
                                      ),
                                      if (pendingJobsDetailedResponse[i]
                                              ["mode"] ==
                                          "Air")
                                        if (pendingJobsDetailedResponse[i]
                                                ["type"] ==
                                            "Export")
                                          Icon(
                                            Icons.flight_takeoff,
                                            size: 10,
                                            color: Color(0xff3e8ef7),
                                          )
                                        else
                                          Icon(
                                            Icons.flight_land,
                                            size: 10,
                                            color: Color(0xffff4c52),
                                          )
                                      else if (pendingJobsDetailedResponse[i]
                                              ["mode"] ==
                                          "Sea")
                                        if (pendingJobsDetailedResponse[i]
                                                ["type"] ==
                                            "Export")
                                          Icon(
                                            Icons.directions_boat,
                                            size: 10,
                                            color: Color(0xff3e8ef7),
                                          )
                                        else
                                          Icon(
                                            Icons.directions_boat,
                                            size: 10,
                                            color: Color(0xffff4c52),
                                          )
                                      else if (pendingJobsDetailedResponse[i]
                                              ["mode"] ==
                                          "Land")
                                        if (pendingJobsDetailedResponse[i]
                                                ["type"] ==
                                            "Export")
                                          Icon(
                                            Icons.local_shipping,
                                            size: 10,
                                            color: Color(0xff3e8ef7),
                                          )
                                        else
                                          Icon(
                                            Icons.local_shipping,
                                            size: 10,
                                            color: Color(0xffff4c52),
                                          )
                                      else
                                        Icon(
                                          Icons.local_shipping,
                                          size: 10,
                                          color: Color(0xff3e8ef7),
                                        ),
                                      SizedBox(
                                        width: 4.0,
                                      ),
                                      Text(
                                        "${pendingJobsDetailedResponse[i]["row_no"]}",
                                        style: TextStyle(
                                          fontSize: 12 + incVal,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Nunito",
                                        ),
                                      )
                                    ]),
                              ),
                            ],
                          ),
                        ]),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    color: Colors.white,
                    height: 11,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Transform.translate(
                              offset: Offset(-15, -6),
                              child: IconButton(
                                  icon: title == "Favourites"
                                      ? Icon(
                                          Icons.favorite,
                                          color: Color(0xffff4c52),
                                        )
                                      : Icon(Icons.favorite_border),
                                  iconSize: 10.0,
                                  onPressed: () {}),
                            ),
                            Transform.translate(
                              offset: Offset(-30, 0),
                              child: Container(
                                width: 100.0,
                                child: Text(
                                  "${pendingJobsDetailedResponse[i]["pol"]} - ${pendingJobsDetailedResponse[i]["pod"]}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 10.0 + incVal,

                                      // fontWeight: FontWeight.bold,
                                      fontFamily: "Nunito"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                pendingJobsDetailedResponse[i]["containers"] > 0
                                    ? "${pendingJobsDetailedResponse[i]["containers"]} containers"
                                    : (pendingJobsDetailedResponse[i]
                                                ["packages"] >
                                            0
                                        ? "${pendingJobsDetailedResponse[i]["packages"]} packages"
                                        : ""),
                                style: TextStyle(
                                  fontSize: 8 + incVal,
                                  fontFamily: "Nunito",
                                ),
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              pendingJobsDetailedResponse[i]["awb_bill_no"] ==
                                      ""
                                  ? Text(
                                      "",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Nunito",
                                      ),
                                    )
                                  : Text(
                                      "${pendingJobsDetailedResponse[i]["awb_bill_no"]}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 10 + incVal,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Nunito",
                                      ),
                                    ),
                            ]),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.0)
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

var uploadedFIles;
var secured = new List();
var insecured = new List();
var customerFiles = new List();

class ViewUploadedFiles extends StatefulWidget {
  final String rowID;
  final int id;
  ViewUploadedFiles({Key key, @required this.rowID, @required this.id})
      : super(key: key);

  @override
  _ViewUploadedFilesState createState() => _ViewUploadedFilesState();
}

class _ViewUploadedFilesState extends State<ViewUploadedFiles> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    defaultFN();

    setState(() {});
  }

  defaultFN() async {
    Response response;
    Dio dio = new Dio();
    try {
      response = await dio.get(
          "http://api.lcsbridge.xyz/jobs/upload/list/${widget.id}?api_token='$apiToken'&company_id='$companyID'&domain='$domainCode'",
          queryParameters: {
            "api_token": apiToken,
            "company_id": companyID,
            "domain": domainCode,
          });
      // print(response.data.toString());

      uploadedFIles = response.data;
      secured = uploadedFIles["Secured"];
      insecured = uploadedFIles["InSecured"];
      customerFiles = uploadedFIles["Customer"];
      setState(() {});
    } catch (e) {
      if (e.response.statusCode == 401) {
        await prefs.setint("loggedIN", 2);

        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePageEx()));
      }
    }
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    defaultFN();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                            Navigator.push(
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
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JobStatus()));
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
                      //  width: 150.0,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(-5, 0),
                    child: Text("Uploaded Files",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                  Transform.translate(
                    offset: Offset(-5, 0),
                    child: Text(" - ${widget.rowID}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                ],
              ),
            ],
          ),
          iconTheme: new IconThemeData(
            color: Colors.black87, /* size: 80.0 */
          ),
          bottom: uploadedFIles == null
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
                      text: secured.length == 0
                          ? "Secured"
                          : "Secured - ${secured.length}",
                    ),
                    Tab(
                      text: insecured.length == 0
                          ? "Insecured"
                          : "Insecured - ${insecured.length}",
                    ),
                    Tab(
                      text: customerFiles.length == 0
                          ? "By Customer"
                          : "By Customer - ${customerFiles.length}",
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
                      text: secured.length == 0
                          ? "Secured"
                          : "Secured - ${secured.length}",
                    ),
                    Tab(
                      text: insecured.length == 0
                          ? "Insecured"
                          : "Insecured - ${insecured.length}",
                    ),
                    Tab(
                      text: customerFiles.length == 0
                          ? "By Customer"
                          : "By Customer - ${customerFiles.length}",
                    ),
                  ],
                ),
        ),
        body: SmartRefresher(
          enablePullDown: true,
          header: WaterDropHeader(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: TabBarView(children: [
            SmartRefresher(
                enablePullDown: true,
                header: WaterDropHeader(),
                controller: _refreshController,
                onRefresh: _onRefresh,
                child: secure(context, "Secured", secured, widget.id)),
            SmartRefresher(
                enablePullDown: true,
                header: WaterDropHeader(),
                controller: _refreshController,
                onRefresh: _onRefresh,
                child: secure(context, "InSecured", insecured, widget.id)),
            SmartRefresher(
                enablePullDown: true,
                header: WaterDropHeader(),
                controller: _refreshController,
                onRefresh: _onRefresh,
                child: secure(context, "Customer", customerFiles, widget.id)),
          ]),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Color(0xff1a73e9),
            icon: Icon(Icons.add),
            label: Text("Upload Files",
                style: TextStyle(color: Colors.white, fontFamily: "Nunito")),
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FileUpload(rowID: widget.rowID, id: widget.id)));
            }),
      ),
    );
  }

  Widget secure(
      BuildContext context, String whichTab, var insecure, int jobID) {
    setState(() {});
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: insecure.length == 0
          ? Center(child: Text("There is no Items in $whichTab"))
          : ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              itemCount: insecure.length,
              itemBuilder: (context, i) {
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Delete',
                      color: Color(0xff1a73e9),
                      icon: Icons.delete,
                      onTap: () async {
                        Response response;
                        Dio dio = new Dio();
                        try {
                          response = await dio.get(
                              "http://api.lcsbridge.xyz/jobs/upload/delete/${insecure[i]["id"]}?api_token=$apiToken&company_id=$companyID&domain=$domainCode",
                              // urlG,
                              queryParameters: {
                                "api_token": apiToken,
                                "company_id": companyID,
                                "domain": domainCode,
                              });

                          var u = UtilityBasicS();
                          u.toastfun((response.data)["message"]);
                          response = await dio.get(
                              "http://api.lcsbridge.xyz/jobs/upload/list/$jobID?api_token='$apiToken'&company_id='$companyID'&domain='$domainCode'",
                              queryParameters: {
                                "api_token": apiToken,
                                "company_id": companyID,
                                "domain": domainCode,
                              });

                          uploadedFIles = response.data;
                          secured = uploadedFIles["Secured"];
                          insecured = uploadedFIles["InSecured"];
                          customerFiles = uploadedFIles["Customer"];
                          setState(() {});
                        } catch (e) {
                          if (e.response.statusCode == 401) {
                            await prefs.setint("loggedIN", 2);

                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePageEx()));
                          }
                        }
                      },
                    ),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (insecure[i]["type"] == "pdf")
                              Image.asset("assets/fileTypes/pdf.png")
                            else if (insecure[i]["type"] == "png" ||
                                insecure[i]["type"] == "jpg" ||
                                insecure[i]["type"] == "jpeg")
                              Image.asset("assets/fileTypes/jpg.png")
                            else if (insecure[i]["type"] == "doc" ||
                                insecure[i]["type"] == "docs")
                              Image.asset("assets/fileTypes/docs.png")
                            else if (insecure[i]["type"] == "xls" ||
                                insecure[i]["type"] == "xlsx")
                              Image.asset("assets/fileTypes/excel.png")
                            else
                              Image.asset("assets/fileTypes/docs.png"),
                            SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${insecure[i]["service"]}",
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold)),
                                Container(
                                  width: 150.0,
                                  child: Text("${insecure[i]["title"]}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 13.0,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 70.0,
                                  child: Text("${insecure[i]["user_name"]}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 12.0,
                                      )),
                                ),
                                Text(
                                    "${insecure[i]["type"]} - ${insecure[i]["size"]}",
                                    style: TextStyle(
                                      fontFamily: "Nunito",
                                      fontSize: 10.0,
                                    ))
                              ],
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            GestureDetector(
                                onTap: () async {
                                  var testing =
                                      await Permission.storage.request();
                                  if (testing.isGranted == true) {
                                    var dir =
                                        await getExternalStorageDirectory();
                                    String str = insecure[i]["file"];
                                    var arr = str.split('/');
                                    String fileNameS = arr[arr.length - 1];
                                    String aaaaa = "${dir.path}" +
                                        Platform.pathSeparator +
                                        "BridgeLCS";
                                    var testdir =
                                        await new Io.Directory('$aaaaa')
                                            .create(recursive: true);

                                    final taskId =
                                        await FlutterDownloader.enqueue(
                                      url: insecure[i]["file"],
                                      fileName: fileNameS,
                                      savedDir: testdir.path,
                                      showNotification: true,
                                      openFileFromNotification: true,
                                      requiresStorageNotLow: true,
                                    );
                                    print("task:: $taskId");
                                    FlutterDownloader.open(taskId: taskId);
                                  } else {
                                    var u = UtilityBasicS();
                                    u.toastfun("Please give access");
                                  }
                                },
                                child: Icon(Icons.file_download))
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
