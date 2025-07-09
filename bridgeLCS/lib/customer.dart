// Customer

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:galubetech/dashboardNew.dart';
import 'package:galubetech/db/utility_basics.dart';
import 'package:galubetech/feedBackForm.dart';
import 'package:galubetech/jobStatus.dart';
import 'package:galubetech/jobs.dart';
import 'package:galubetech/supplierNew.dart';
import 'package:galubetech/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'main.dart';

var customerGeneral; // = new List();
Color colorCode = Colors.white;
int countGeneral = 0;
int countBlocked = 0;
int limit = 0;
String urlG =
    "http://api.lcsbridge.xyz/customers"; // ?api_token='$apiToken'&company_id='$companyID'&domain='$domainCode'";

class CustomerPage extends StatefulWidget {
  final int cusOrSup;

  CustomerPage({Key key, @required this.cusOrSup}) : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  var tabIndex = 0;
  @override
  void initState() {
    super.initState();

    if (widget.cusOrSup == 1) {
      customerFN();
    } else if (widget.cusOrSup == 2) {
      customerSupplierFN();
    } else {
      var utilityBasic = UtilityBasicS();
      utilityBasic.toastfun("Something went wrong");
    }
    _tabController = new TabController(length: 2, vsync: this);
    _tabController.addListener(_handleSelected);
    setState(() {});
  }

  void _handleSelected() {
    setState(() {});
  }

  customerSupplierFN() async {
    Response response;
    Dio dio = new Dio();
    print(
        "http://api.lcsbridge.xyz/suppliers?api_token='$apiToken'&company_id='$companyID'&domain='$domainCode'");
    response = await dio.get(
        "http://api.lcsbridge.xyz/suppliers?api_token='$apiToken'&company_id='$companyID'&domain='$domainCode'",
        // urlG,
        queryParameters: {
          "api_token": apiToken,
          "company_id": companyID,
          "domain": "$domainCode",
        });

    customerGeneral = response.data;

    setState(() {});
  }

  customerFN() async {
    Response response;
    Dio dio = new Dio();
    print(
        "http://api.lcsbridge.xyz/customers?api_token='$apiToken'&company_id='$companyID'&domain='$domainCode'");
    try {
      response = await dio.get(urlG, queryParameters: {
        "api_token": apiToken,
        "company_id": companyID,
        "domain": domainCode,
        "limit": limit,
      });
      setState(() {
        customerGeneral = response.data;
        scrollLength = customerGeneral["General"].length;
      });
      print(customerGeneral);
      print(customerGeneral["General"].length);
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
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    if (widget.cusOrSup == 1) {
      customerFN();
    } else if (widget.cusOrSup == 2) {
      customerSupplierFN();
    } else {
      var utilityBasic = UtilityBasicS();
      utilityBasic.toastfun("Something went wrong");
    }
    _tabController = new TabController(length: 2, vsync: this);
    _tabController.addListener(_handleSelected);
    setState(() {});

    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // initialIndex: 0,
      length: 2,
      child: customerGeneral == null
          ? Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
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
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
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
                      child: Text(
                          widget.cusOrSup == 1 ? "Customer" : "Supplier",
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
                                  height:
                                      MediaQuery.of(context).size.height / 2,
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
                                                loginCode = await prefs
                                                    .getString("CODE");
                                                await customerFN();

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
                                                        CrossAxisAlignment
                                                            .start,
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
                              customerFN();
                            },
                            child: CircleAvatar(
                                backgroundColor: Color(0xff1c72ea),
                                child: Text(
                                  "$loginCode",
                                  style: TextStyle(
                                      fontSize: 12.0, fontFamily: "Nunito"),
                                )),
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
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SafeArea(
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
                              // color: Color(0xff898989),
                              color: Colors.grey,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: IconButton(
                                            icon: Icon(Icons.arrow_back),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                      ),
                                      /* Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      children: <Widget>[
                                        IconButton(
                                            icon: Icon(Icons.mail),
                                            onPressed: () {
                                              print("message me");
                                            }),
                                        IconButton(
                                            icon: Icon(Icons.calendar_today),
                                            onPressed: () {
                                              print("message me");
                                            })
                                      ],
                                    ),
                                  ) */
                                    ],
                                  ),
                                  Image.network(
                                    companyLogo,
                                    // color: Colors.grey,
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
                                          // trailing: Icon(Icons.edit),
                                        ),
                                        /* Divider(
                                      thickness: 2.0,
                                      color: Colors.grey,
                                    ), */
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
                                          // fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  onTap: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DashBoardNew()));
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
                                    Navigator.pop(context);
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
                                    Response response;
                                    Dio dio = new Dio();

                                    response = await dio.get(
                                        "http://api.lcsbridge.xyz/logout?api_token='$apiToken'&company_id='$companyID'&domain='$domainCode'",
                                        queryParameters: {
                                          "api_token": apiToken,
                                          "company_id": companyID,
                                          "domain": domainCode,
                                        });

                                    print(response.data.toString());
                                    await prefs.setint("loggedIN", 2);
                                    // await prefs.setint("loggedIN", 1);
                                    await prefs.setString("APIToken", null);
                                    await prefs.setint("CompanyID", 0);
                                    await prefs.setString("Domain", null);
                                    await prefs.setString("CODE", null);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyHomePageEx()));
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
                        color: Colors.black,
                        fontSize: 15.0,
                        fontFamily: "Nunito"),
                    tabs: [
                      Tab(
                        text: customerGeneral["General"] == null
                            ? "General"
                            : "General - ${scrollLength}",
                      ),
                      Tab(
                        text: customerGeneral["Blocked"] == null
                            ? "Blocked"
                            : "Blocked - ${customerGeneral["Blocked"].length}",
                      ),
                    ],
                  ),
                  elevation: 0.0,
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
                          tooltip: MaterialLocalizations.of(context)
                              .openAppDrawerTooltip,
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
                        child: Text(
                            widget.cusOrSup == 1 ? "Customer" : "Supplier",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                      Row(
                        children: <Widget>[
                          InkResponse(
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

                              print(summa);
                              Dialog errorDialog = Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0 *
                                            MediaQuery.of(context)
                                                .devicePixelRatio))),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
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
                                                loginCode = await prefs
                                                    .getString("CODE");
                                                await customerFN();
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
                                                        CrossAxisAlignment
                                                            .start,
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
                                    backgroundColor: Color(0xff1c72ea),
                                    child: Text(
                                      "$loginCode",
                                      style: TextStyle(
                                          fontSize: 12.0, fontFamily: "Nunito"),
                                    ))),
                          ),
                        ],
                      ),
                    ],
                  ),
                  iconTheme: new IconThemeData(
                    color: Colors.black87, /* size: 80.0 */
                  ),
                ),
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    CustomerGeneralDetails(),
                    CustomerBlockedDetails(),
                  ],
                ),
              ),
            ),
    );
  }
}

int scrollLength;
bool circle = true;

class CustomerGeneralDetails extends StatefulWidget {
  const CustomerGeneralDetails({
    Key key,
  }) : super(key: key);

  @override
  _CustomerGeneralDetailsState createState() => _CustomerGeneralDetailsState();
}

class _CustomerGeneralDetailsState extends State<CustomerGeneralDetails>
    with TickerProviderStateMixin {
  ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(fn);

    super.initState();
  }

  fn() async {
    if (_controller.offset == _controller.position.maxScrollExtent) {
      print(_controller.position.maxScrollExtent);
      // setState(() {
      // customerGeneral.clear();
      circle = true;
      var ss;
      Response response;
      Dio dio = new Dio();
      print(
          "http://api.lcsbridge.xyz/suppliers?api_token='$apiToken'&company_id='$companyID'&domain='$domainCode'");
      try {
        response = await dio.get(urlG, queryParameters: {
          "api_token": apiToken,
          "company_id": companyID,
          "domain": domainCode,
          "limit": limit + 250, //customerGeneral["General"].length
        });
        setState(() {
          // print(response.data);
          ss = response.data;
          print("customerGeneral");

          print(customerGeneral["General"]);
          print("ss");
          print(ss);
          print("length");

          // if(ss["limit"])
          print(ss["General"].length);
          if (ss["General"].length > 0) {
            for (var i = 0; i < ss["General"].length; i++) {
              customerGeneral["General"].add(ss["General"][i]);
            }
            circle = false;
          }
          scrollLength = customerGeneral["General"].length;
          //  scrollLength = scrollLength -1;
          setState(() {});
          print(scrollLength);
        });

        setState(() {});
      } catch (e) {
        if (e.response.statusCode == 401) {
          await prefs.setint("loggedIN", 2);

          await Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyHomePageEx()));
        }
      }

      print(scrollLength);
      // });

    }
    if (_controller.offset == _controller.position.minScrollExtent) {
      print(_controller.position.minScrollExtent);
      setState(() {
        scrollLength = customerGeneral["General"].length;
        print(scrollLength);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return customerGeneral["General"] == null
        ? Center(child: Text("There is no General Customers"))
        : Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(
                left: 8.0,
                right: 8.0,
              ),
              child: ListView.builder(
                controller: _controller,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                itemCount: customerGeneral["General"].length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, i) {
                  // print("${customerGeneral["General"][i]}");
                  return Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                            maxRadius: 20.0,
                            backgroundColor: Color(0xfff2f2f2),
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: customerGeneral["General"][i]["short"]
                                          .length ==
                                      1
                                  ? Text(
                                      "${customerGeneral["General"][i]["short"]}",
                                      textAlign: TextAlign.justify,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )
                                  : Text(
                                      "${customerGeneral["General"][i]["short"]}",
                                      textAlign: TextAlign.justify,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                            )),
                        Transform.translate(
                          offset: Offset(-18, 0),
                          child: Container(
                            width: 175.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100.0,
                                      child: Text(
                                        "${customerGeneral["General"][i]["name"]},",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Nunito"),
                                      ),
                                    ),
                                    Text(
                                      "${customerGeneral["General"][i]["row_no"]}",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: "Nunito"),
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 175.0,
                                  child: Text(
                                    customerGeneral["General"][i]["country"] ==
                                            null
                                        ? "${customerGeneral["General"][i]["email"]}"
                                        : "${customerGeneral["General"][i]["email"]}, ${customerGeneral["General"][i]["country"]}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12, fontFamily: "Nunito"),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text("${customerGeneral["General"][i]["balance"]}",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              "${customerGeneral["General"][i]["posting_date"]}",
                              style: TextStyle(fontSize: 10.0),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
  }
}

class CustomerBlockedDetails extends StatefulWidget {
  const CustomerBlockedDetails({
    Key key,
  }) : super(key: key);

  @override
  _CustomerBlockedDetailsState createState() => _CustomerBlockedDetailsState();
}

class _CustomerBlockedDetailsState extends State<CustomerBlockedDetails>
    with TickerProviderStateMixin {
  ScrollController _controller;
  int scrollLength;
  @override
  void initState() {
    _controller = ScrollController();

    // print(_controller.position.maxScrollExtent);
    super.initState();
    _controller.addListener(fn);
  }

  fn() async {
    if (_controller.offset == _controller.position.maxScrollExtent) {
      print(_controller.position.maxScrollExtent);
      // setState(() {
      // customerGeneral.clear();
      circle = true;
      var ss;
      Response response;
      Dio dio = new Dio();
      print(
          "http://api.lcsbridge.xyz/suppliers?api_token='$apiToken'&company_id='$companyID'&domain='$domainCode'");
      try {
        response = await dio.get(urlG, queryParameters: {
          "api_token": apiToken,
          "company_id": companyID,
          "domain": domainCode,
          "limit": limit + 250,
        });
        setState(() {
          ss = response.data;
          print("customerGeneral");
          print(customerGeneral["General"]);
          print("ss");
          print(ss);
          print("length");
          print(ss["Blocked"].length);
          if (ss["Blocked"].length > 0) {
            for (var i = 0; i < ss["Blocked"].length; i++) {
              customerGeneral["Blocked"].add(ss["Blocked"][i]);
            }
            circle = false;
          }
          scrollLength = customerGeneral["Blocked"].length;
          //  scrollLength = scrollLength -1;
          setState(() {});
          print(scrollLength);
        });

        setState(() {});
      } catch (e) {
        if (e.response.statusCode == 401) {
          await prefs.setint("loggedIN", 2);

          await Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyHomePageEx()));
        }
      }
    }

    print(scrollLength);
    // });
    if (_controller.offset == _controller.position.minScrollExtent) {
      print(_controller.position.minScrollExtent);
      setState(() {
        scrollLength = customerGeneral["Blocked"].length;
        print(scrollLength);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return customerGeneral["Blocked"] == null
        ? Center(child: Text("There is no Blocked Customers"))
        : Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
              ),
              child: ListView.builder(
                controller: _controller,
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                itemCount: customerGeneral["Blocked"].length, // + 12,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                            maxRadius: 20.0,
                            backgroundColor: Color(0xfff1f1f1),
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: customerGeneral["Blocked"][i]["short"]
                                          .length ==
                                      1
                                  ? Text(
                                      "${customerGeneral["Blocked"][i]["short"]}",
                                      textAlign: TextAlign.justify,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )
                                  : Text(
                                      "${customerGeneral["Blocked"][i]["short"][0]}${customerGeneral["Blocked"][i]["short"][1]}",
                                      textAlign: TextAlign.justify,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                            )),
                        Transform.translate(
                          offset: Offset(-14, 0),
                          child: Container(
                            width: 175.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100.0,
                                      child: Text(
                                        "${customerGeneral["Blocked"][i]["name"]},",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Nunito"),
                                      ),
                                    ),
                                    Text(
                                      "${customerGeneral["Blocked"][i]["row_no"]}",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: "Nunito"),
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                                /* Text(
                                  "${customerGeneral["Blocked"][i]["name"]}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Nunito"),
                                ), */
                                Container(
                                  width: 175.0,
                                  child: Text(
                                    "${customerGeneral["Blocked"][i]["email"]}, ${customerGeneral["Blocked"][i]["country"]}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 13, fontFamily: "Nunito"),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text("${customerGeneral["Blocked"][i]["balance"]}",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              "${customerGeneral["Blocked"][i]["posting_date"]}",
                              style: TextStyle(fontSize: 12.0),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
  }
}

var customerBlocked = new List();
