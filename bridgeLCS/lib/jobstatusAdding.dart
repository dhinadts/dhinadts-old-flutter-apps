import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:galubetech/addjobStatus.dart';
import 'package:galubetech/customer.dart';
import 'package:galubetech/db/utility_basics.dart';
import 'package:galubetech/feedBackForm.dart';
import 'package:galubetech/jobs.dart';
import 'package:galubetech/main.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:galubetech/jobStatus.dart';
import 'package:galubetech/supplierNew.dart';
import 'package:galubetech/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

var passingPara;
Color colorCode = Colors.white;

class JobStatusAdding extends StatefulWidget {
  final rowID;
  final int id;
  JobStatusAdding({Key key, @required this.rowID, @required this.id})
      : super(key: key);

  @override
  _JobStatusAddingState createState() => _JobStatusAddingState();
}

class _JobStatusAddingState extends State<JobStatusAdding>
    with TickerProviderStateMixin {
  TabController _nestedTabController;

  @override
  void initState() {
    super.initState();
    _nestedTabController = new TabController(length: 8, vsync: this);
    deafultFn();
  }

  deafultFn() async {
    Response response;
    Dio dio = new Dio();
    try {
      response = await dio.get(
          "http://api.lcsbridge.xyz/status/list/${widget.id}?api_token='$apiToken'&company_id='$companyID'&domain=$domainCode",
          queryParameters: {
            "api_token": apiToken,
            "company_id": companyID,
            "domain": domainCode,
          });

      passingPara = response.data;
      if (passingPara.isEmpty) {
        setState(() {
          passingPara["data"].length = 0;
        });
      } else {
        setState(() {});
      }
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
    _nestedTabController = new TabController(length: 8, vsync: this);
    deafultFn();
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          onTap: () {
                            print("Editing opject");
                          },
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
                          Navigator.pop(context);
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
                          await Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Jobs()));
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
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
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
                  child: Text("Add Status",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 20.0,
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
          color: Colors.black87,
        ),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TabBar(
                    controller: _nestedTabController,
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,
                    isScrollable: true,
                    tabs: <Widget>[
                      Tab(
                        text: "All",
                      ),
                      Tab(
                        text: "Clearance",
                      ),
                      Tab(
                        text: "Freight",
                      ),
                      Tab(
                        text: "Transportation",
                      ),
                      Tab(
                        text: "Relocation",
                      ),
                      Tab(
                        text: "Warehousing",
                      ),
                      Tab(
                        text: "Value Added",
                      ),
                      Tab(
                        text: "Trading",
                      ),
                    ]),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height / 1.5, // - 90.0,

                    child: passingPara == null
                        ? Center(child: CircularProgressIndicator())
                        : TabBarView(
                            controller: _nestedTabController,
                            children: <Widget>[
                                Container(
                                  // height: 640.0,
                                  color: Colors.white,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        passingPara["data"].length == 0
                                            ? Container(
                                                height: 450.0,
                                                child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        "There is no Item")),
                                              )
                                            : Container(
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    itemCount:
                                                        passingPara["data"]
                                                            .length,
                                                    itemBuilder: (context, i) {
                                                      return GestureDetector(
                                                        onTap: () async {
                                                          print("Id:::  ");
                                                          print(widget.id);
                                                          print(passingPara[
                                                              "data"][i]);
                                                        },
                                                        child: swipeableList(
                                                            context,
                                                            passingPara["data"]
                                                                [i],
                                                            widget.id),
                                                      );
                                                    }),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          children: <Widget>[
                                            passingPara["data"].length == 0
                                                ? Container(
                                                    height: 450.0,
                                                    child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                            "There is no Item")),
                                                  )
                                                : ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        passingPara["data"]
                                                            .length,
                                                    itemBuilder: (context, i) {
                                                      return passingPara["data"]
                                                                      [i][
                                                                  "service_id"] ==
                                                              1
                                                          ? swipeableList(
                                                              context,
                                                              passingPara[
                                                                  "data"][i],
                                                              widget.id)
                                                          : SizedBox();
                                                    }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          children: <Widget>[
                                            passingPara["data"].length == 0
                                                ? Container(
                                                    height: 450.0,
                                                    child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                            "There is no Item")),
                                                  )
                                                : ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        passingPara["data"]
                                                            .length,
                                                    itemBuilder: (context, i) {
                                                      return passingPara["data"]
                                                                      [i][
                                                                  "service_id"] ==
                                                              2
                                                          ? swipeableList(
                                                              context,
                                                              passingPara[
                                                                  "data"][i],
                                                              widget.id)
                                                          : SizedBox();
                                                    }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          children: <Widget>[
                                            passingPara["data"].length == 0
                                                ? Container(
                                                    height: 450.0,
                                                    child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                            "There is no Item")),
                                                  )
                                                : ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        passingPara["data"]
                                                            .length,
                                                    itemBuilder: (context, i) {
                                                      return passingPara["data"]
                                                                      [i][
                                                                  "service_id"] ==
                                                              4
                                                          ? swipeableList(
                                                              context,
                                                              passingPara[
                                                                  "data"][i],
                                                              widget.id)
                                                          : SizedBox();
                                                    }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          children: <Widget>[
                                            passingPara["data"].length == 0
                                                ? Container(
                                                    height: 450.0,
                                                    child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                            "There is no Item")),
                                                  )
                                                : ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        passingPara["data"]
                                                            .length,
                                                    itemBuilder: (context, i) {
                                                      return passingPara["data"]
                                                                      [i][
                                                                  "service_id"] ==
                                                              3
                                                          ? swipeableList(
                                                              context,
                                                              passingPara[
                                                                  "data"][i],
                                                              widget.id)
                                                          : SizedBox();
                                                    }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          children: <Widget>[
                                            passingPara["data"].length == 0
                                                ? Container(
                                                    height: 450.0,
                                                    child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                            "There is no Item")),
                                                  )
                                                : ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        passingPara["data"]
                                                            .length,
                                                    itemBuilder: (context, i) {
                                                      return passingPara["data"]
                                                                      [i][
                                                                  "service_id"] ==
                                                              6
                                                          ? swipeableList(
                                                              context,
                                                              passingPara[
                                                                  "data"][i],
                                                              widget.id)
                                                          : SizedBox();
                                                    }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          children: <Widget>[
                                            passingPara["data"].length == 0
                                                ? Container(
                                                    height: 450.0,
                                                    child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                            "There is no Item")),
                                                  )
                                                : ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        passingPara["data"]
                                                            .length,
                                                    itemBuilder: (context, i) {
                                                      return passingPara["data"]
                                                                      [i][
                                                                  "service_id"] ==
                                                              5
                                                          ? swipeableList(
                                                              context,
                                                              passingPara[
                                                                  "data"][i],
                                                              widget.id)
                                                          : SizedBox();
                                                    }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          children: <Widget>[
                                            passingPara["data"].length == 0
                                                ? Container(
                                                    height: 450.0,
                                                    child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                            "There is no Item")),
                                                  )
                                                : ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        passingPara["data"]
                                                            .length,
                                                    itemBuilder: (context, i) {
                                                      return passingPara["data"]
                                                                      [i][
                                                                  "service_id"] ==
                                                              7
                                                          ? swipeableList(
                                                              context,
                                                              passingPara[
                                                                  "data"][i],
                                                              widget.id)
                                                          : SizedBox();
                                                    }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                  ),
                ),
              ]),
          // ]),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color(0xff1a73e9),
          icon: Icon(Icons.add),
          label: Text("Add Status",
              style: TextStyle(color: Colors.white, fontFamily: "Nunito")),
          onPressed: () async {
            print(widget.rowID);
            print(widget.id);
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddJobStatus(rowID: widget.rowID, id: widget.id)));
          }),
    );
  }

  var summa = new List();

  Widget eachItem(var passingPara) {
    print(passingPara);
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "${passingPara["status"]}",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "${passingPara["updated"]["by"]}",
                  style: TextStyle(fontSize: 12.0, fontFamily: "Nunito"),
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    "${passingPara["status_category"]}",
                    style: TextStyle(fontSize: 13.0, fontFamily: "Nunito"),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "${passingPara["updated"]["at"]}",
                  style: TextStyle(fontSize: 10.0, fontFamily: "Nunito"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget swipeableList(BuildContext context, var passingPara, var rowID) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Material(
          // height:80.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),

          color: Colors.white,
          child: eachItem(passingPara),
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Color(0xff1a73e9),
            icon: Icons.delete,
            onTap: () async {
              Response response;
              Dio dio = new Dio();
              print("${passingPara["id"]}");
              try {
                response = await dio.get(
                    "http://api.lcsbridge.xyz/status/delete/${passingPara["id"]}?api_token='$apiToken'&company_id='$companyID'&domain=$domainCode",
                    // urlG,
                    queryParameters: {
                      "api_token": apiToken,
                      "company_id": companyID,
                      "domain": domainCode,
                    });
                deafultFn();
                setState(() {});
                var u = UtilityBasicS();
                u.toastfun((response.data)["message"]);
              } catch (e) {
                if (e.response.statusCode == 401) {
                  await prefs.setint("loggedIN", 2);

                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHomePageEx()));
                }
              }
            },
          ),
        ],
      ),
      // ),
    );
  }
}
