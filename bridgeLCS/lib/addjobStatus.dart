import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:galubetech/customer.dart';
import 'package:galubetech/dashboardNew.dart';
import 'package:galubetech/feedBackForm.dart';
import 'package:galubetech/jobStatus.dart';
import 'package:galubetech/jobs.dart';
import 'package:galubetech/main.dart';
import 'package:galubetech/supplierNew.dart';
import 'package:galubetech/widgets.dart';
import 'package:intl/intl.dart';

import 'package:galubetech/db/utility_basics.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Color colorCode = Colors.white;

class AddJobStatus extends StatefulWidget {
  final rowID;
  final int id;
  AddJobStatus({Key key, @required this.rowID, @required this.id})
      : super(key: key);

  @override
  _AddJobStatusState createState() => _AddJobStatusState();
}

class _AddJobStatusState extends State<AddJobStatus> {
  var _items = ["Select"];
  var _items1 = ["Select", "CUSTOM"];
  String defaultSelect = "Select";
  String defaultSelect1 = "Select";
  var serviceTypes = new List();
  // var serviceCat = new List();
  // var defaultCont = new List();

  String dropDownValueST = "Select";
  String dropDownValueSC = "Select";
  String dropDownValueDC = "Select";
  String serviceType = "";
  int serviceID = 0;
  var serviceIDs = new List();
  var serviceCatID = "";
  // var serviceCatIDs = new List();
  bool customBool = false;
  bool checkSave = false;
  TextEditingController customContr = new TextEditingController();
  var formatter = new DateFormat('dd-MM-yyy');
  var now = new DateTime.now();
  var birthDateInString; // = formatter.format(now);

  DateTime birthDate; // instance of
  bool isDateSelected = false;
  bool clearALL = false;
  var serviceCat = ["Select"];
  var serviceCatIDs = ["Select"];
  var defaultCont = ["Select"];
  @override
  void initState() {
    super.initState();
    birthDateInString = formatter.format(now);

    callingDefault();
  }

  callingServiceAPI(int serviceID) async {
    // serviceCat.add("Select");
    // serviceCatIDs.add("Select");
    // defaultCont.add("Select");
    // serviceCat.clear();
    // serviceCatIDs.clear();
    // defaultCont.clear();
    // serviceCat.add("Select");
    // serviceCatIDs.add("Select");
    // defaultCont.add("Select");
    customBool = false;
    serviceCat = ["Select"];
    serviceCatIDs = ["Select"];
    serviceCatID = "";
    defaultCont = ["Select"];
    dropDownValueSC = "Select";
    dropDownValueDC = "Select";

    var passingPara;
    Response response;
    Dio dio = new Dio();

    response = await dio.get(
        "http://api.lcsbridge.xyz/status/service/$serviceID?api_token=$apiToken&company_id=$companyID&domain=$domainCode&service=$serviceType",
        // urlG,
        queryParameters: {
          "api_token": apiToken,
          "company_id": companyID,
          "domain": domainCode,
          "service": "$serviceType",
        });

    // print(response.statusCode);
    passingPara = response.data;
    print(passingPara);
    if (passingPara["categories"].isNotEmpty) {
      var a = passingPara["categories"].keys.toList();
      for (var i = 0; i < passingPara["categories"].length; i++) {
        serviceCat.add(passingPara["categories"][a[i]]);
        serviceCatIDs.add(a[i]);
      }
    }
    if (passingPara["status"].isNotEmpty) {
      for (var i = 0; i < passingPara["status"].length; i++) {
        defaultCont.add(passingPara["status"][i]);
      }
    }
    defaultCont.add("CUSTOM");
    setState(() {});
  }

  callingDefault() async {
    serviceCat = ["Select"];
    serviceCatIDs = ["Select"];
    defaultCont = ["Select"];
    customBool = false;

    var passingPara;
    Response response;
    Dio dio = new Dio();
    try {
      response = await dio.get(
          "http://api.lcsbridge.xyz/status/form/${widget.id}?api_token='$apiToken'&company_id='$companyID'&domain=$domainCode",
          // urlG,
          queryParameters: {
            "api_token": apiToken,
            "company_id": companyID,
            "domain": domainCode,
          });

      passingPara = response.data;
      serviceTypes.add("Select");
      serviceIDs.add(0);
      for (var i = 0; i < passingPara["services"].length; i++) {
        serviceTypes.add(passingPara["services"][i]["description"]);
        serviceIDs.add(passingPara["services"][i]["id"]);
      }

      setState(() {});
    } catch (e) {
      if (e.response.statusCode == 401) {
        await prefs.setint("loggedIN", 0);

        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePageEx()));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    serviceTypes.clear();
    serviceCat.clear();
    defaultCont.clear();

    dropDownValueST = "Select";
    dropDownValueSC = "Select";
    dropDownValueDC = "Select";
    serviceType = "";
    serviceID = 0;
    serviceIDs.clear();
    serviceCatID = "";
    serviceCatIDs.clear();
    callingDefault();
    _refreshController.refreshCompleted();
  }

  // ignore: unused_element
  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
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
                    // color: Color(0xff898989),
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
                        // SizedBox(height: 10),
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
                                  builder: (context) => DashBoardNew()));
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
                          await Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Jobs()));
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
                          await Navigator.push(
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
            child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Service Type*",
                        style: TextStyle(fontFamily: "Nunito", fontSize: 12.0),
                        textAlign: TextAlign.left,
                      )),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    // height: 40.0,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        border: new Border.all(
                            style: BorderStyle.solid, color: Color(0xffdadce0)),
                        borderRadius: BorderRadius.circular(6)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: DropdownButton(
                          underline: Container(),
                          elevation: 0,
                          isExpanded: true,
                          isDense: true,
                          value: dropDownValueST,
                          onChanged: (newValue) {
                            setState(() {
                              dropDownValueST = newValue;
                            });

                            for (int i = 0; i < serviceTypes.length; i++) {
                              if (serviceTypes[i] == dropDownValueST) {
                                serviceID = serviceIDs[i];
                                serviceType = dropDownValueST;
                                setState(() {});
                                callingServiceAPI(serviceID);
                              }
                            }
                          },
                          items: serviceTypes.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location,
                                  style: TextStyle(
                                    fontFamily: "Nunito",
                                  )),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    // ),
                  ),
                ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Status Category*",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: "Nunito",
                        ),
                        textAlign: TextAlign.left,
                      )),
                ),
                serviceCat.length > 1
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          // height: 40.0,
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: new Border.all(
                                  style: BorderStyle.solid,
                                  color: Color(0xffdadce0)),
                              borderRadius: BorderRadius.circular(6)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: DropdownButton(
                              underline: Container(),
                              elevation: 0,
                              isExpanded: true,
                              isDense: true,
                              value: dropDownValueSC,
                              onChanged: (newValue) {
                                setState(() {
                                  dropDownValueSC = newValue;
                                });
                                for (int i = 0; i < serviceCat.length; i++) {
                                  if (serviceCat[i] == dropDownValueSC) {
                                    serviceCatID = serviceCatIDs[i];
                                    setState(() {});
                                  }
                                }
                              },
                              items: serviceCat.map((location) {
                                return DropdownMenuItem(
                                  child: new Text(
                                    location,
                                    style: TextStyle(
                                      // fontSize: 12.0,
                                      fontFamily: "Nunito",
                                    ),
                                  ),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ),
                          // ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          // height: 40.0,
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: new Border.all(
                                  style: BorderStyle.solid,
                                  color: Color(0xffdadce0)),
                              borderRadius: BorderRadius.circular(6)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: DropdownButton(
                              onChanged: (newvalue) {},
                              underline: Container(),
                              elevation: 0,
                              isExpanded: true,
                              isDense: true,
                              value: defaultSelect,
                              items: _items.map((location) {
                                return DropdownMenuItem(
                                  child: new Text(
                                    location,
                                    style: TextStyle(
                                      // fontSize: 12.0,
                                      fontFamily: "Nunito",
                                    ),
                                  ),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ),
                          // ),
                        ),
                      ),

                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Posting Date*",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: "Nunito",
                        ),
                        textAlign: TextAlign.left,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      final datePick = await showDatePicker(
                          context: context,
                          initialDate: new DateTime.now(),
                          firstDate: new DateTime(1900),
                          lastDate: new DateTime(2100));
                      if (datePick != null && datePick != birthDate) {
                        setState(() {
                          birthDate = datePick;
                          isDateSelected = true;
                          birthDateInString =
                              new DateFormat("dd-MM-yyyy").format(birthDate);
                        });
                      }
                    },
                    child: Container(
                      height: 45.0,
                      width: double.infinity,
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          border: new Border.all(
                              style: BorderStyle.solid,
                              color: Color(0xffdadce0)),
                          borderRadius: BorderRadius.circular(6)),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              birthDateInString,
                              style: TextStyle(
                                // fontSize: 12.0,
                                fontFamily: "Nunito",
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Default Content*",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: "Nunito",
                        ),
                        textAlign: TextAlign.left,
                      )),
                ),
                defaultCont.length > 1
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          // height: 40.0,
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: new Border.all(
                                  style: BorderStyle.solid,
                                  color: Color(0xffdadce0)),
                              borderRadius: BorderRadius.circular(6)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: DropdownButton(
                                underline: Container(),
                                elevation: 0,
                                isExpanded: true,
                                isDense: true,
                                value: dropDownValueDC,
                                onChanged: (newValue) {
                                  setState(() {
                                    dropDownValueDC = newValue;
                                    if (newValue == "CUSTOM") {
                                      customBool = true;
                                    } else {
                                      customBool = false;
                                    }
                                  });
                                },
                                items: defaultCont.map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(
                                      location,
                                      style: TextStyle(
                                        //  fontSize: 12.0,
                                        fontFamily: "Nunito",
                                      ),
                                    ),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          // height: 40.0,
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: new Border.all(
                                  style: BorderStyle.solid,
                                  color: Color(0xffdadce0)),
                              borderRadius: BorderRadius.circular(6)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: DropdownButton(
                              onChanged: (newValue) {
                                setState(() {
                                  defaultSelect1 = newValue;
                                  if (newValue == "CUSTOM") {
                                    customBool = true;
                                  } else {
                                    customBool = false;
                                  }
                                });
                              },
                              underline: Container(),
                              elevation: 0,
                              isExpanded: true,
                              isDense: true,
                              value: defaultSelect1,
                              items: _items1.map((location) {
                                return DropdownMenuItem(
                                  child: new Text(
                                    location,
                                    style: TextStyle(
                                      // fontSize: 12.0,
                                      fontFamily: "Nunito",
                                    ),
                                  ),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),

                Visibility(
                  visible: customBool,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 20.0,
                            width: 20.0,
                            child: Checkbox(
                                value: checkSave,
                                onChanged: (value) {
                                  setState(() {
                                    checkSave = value;
                                  });
                                }),
                          ),
                          Text(
                            "Save the status",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: "Nunito",
                            ),
                            textAlign: TextAlign.left,
                          )
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: customBool,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: 45.0,
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          border: new Border.all(
                              style: BorderStyle.solid,
                              color: Color(0xffdadce0)),
                          borderRadius: BorderRadius.circular(6)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: customContr,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                // borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 40.0,
                ),

                Material(
                  elevation: 0.0,
                  color: Colors.white,
                  child: ButtonTheme(
                    minWidth: 360.0,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(100.0),
                    ),
                    child: RaisedButton(
                      color: Color(0xff1a73e9),
                      onPressed: () async {
                        pr = new ProgressDialog(context,
                            type: ProgressDialogType.Normal);
                        pr.style(message: 'Please Wait...');
                        pr.show();

                        try {
                          if (checkSave == true || customBool) {
                            print(
                                "http://api.lcsbridge.xyz/status/save/${widget.id}?api_token=$apiToken&company_id=$companyID&domain=$domainCode&service_type=$serviceID&service_category=$serviceCatID&default_content=$dropDownValueDC&custom_status=${customContr.text}&add_status=$checkSave&posting_date=$birthDateInString");
                            // var url =
                            //     "http://api.lcsbridge.xyz/status/save/${widget.id}"; //?api_token=$apiToken&company_id=$companyID&domain=$domainCode&service_type=$serviceID&service_category=$serviceCatID&default_content=$dropDownValueDC&custom_status=${customContr.text}&add_status=$checkSave&posting_date=$birthDateInString";

                            /* var response = await http.get(
                              url,
                              queryParameters: {
                                "api_token": apiToken,
                                "company_id": companyID,
                                "domain": domainCode,
                            // service_type=$serviceID&service_category=$serviceCatID&default_content=$dropDownValueDC&custom_status=${customContr.text}&add_status=$checkSave&posting_date=$birthDateInString"    
                              }); */
                            Response response;
                            Dio dio = new Dio();

                            response = await dio.get(
                                "http://api.lcsbridge.xyz/status/save/${widget.id}",
                                queryParameters: {
                                  "api_token": apiToken,
                                  "company_id": companyID,
                                  "domain": domainCode,
                                  "service_type": serviceID,
                                  "service_category": serviceCatID,
                                  "default_content": dropDownValueDC == "Select"
                                      ? ""
                                      : dropDownValueDC,
                                  "custom_status": customContr.text,
                                  "add_status": checkSave,
                                  "posting_date": birthDateInString
                                });

                            resPONSE = response.data;
                          } else {
                            print(
                                "${widget.id}?api_token=$apiToken&company_id=$companyID&domain=$domainCode&service_type=$serviceID&service_category=$serviceCatID&default_content=$dropDownValueDC&posting_date=$birthDateInString");
                            // var url =
                            //     "http://api.lcsbridge.xyz/status/save/${widget.id}?api_token=$apiToken&company_id=$companyID&domain=$domainCode&service_type=$serviceID&service_category=$serviceCatID&default_content=$dropDownValueDC&posting_date=$birthDateInString";
                            // var response = await http.get(
                            //   url, /* headers:{ "Accept": "application/json" } , */
                            // );

                            // resPONSE = json.decode(response.body);
                            Response response;
                            Dio dio = new Dio();

                            response = await dio.get(
                                "http://api.lcsbridge.xyz/status/save/${widget.id}",
                                queryParameters: {
                                  "api_token": apiToken,
                                  "company_id": companyID,
                                  "domain": domainCode,
                                  "service_type": serviceID,
                                  "service_category": serviceCatID,
                                  "default_content": dropDownValueDC == "Select"
                                      ? ""
                                      : dropDownValueDC, // dropDownValueDC,
                                   "custom_status":customContr.text,
                                   "add_status":checkSave,
                                  "posting_date": birthDateInString
                                });

                            resPONSE = response.data;
                            print(resPONSE);
                          }
                          if (pr.isShowing()) {
                            pr.hide();
                          }
                          var utilityBasic = UtilityBasicS();
                          utilityBasic.toastfun(resPONSE["title"]);
                          utilityBasic.toastfun(resPONSE["message"]);
                          serviceTypes.clear();
                          serviceCat.clear();
                          defaultCont.clear();

                          dropDownValueST = "Select";
                          dropDownValueSC = "Select";
                          dropDownValueDC = "Select";
                          serviceType = "";
                          serviceID = 0;
                          serviceIDs.clear();
                          serviceCatID = "";
                          serviceCatIDs.clear();
                          if (customBool == true) {
                            customBool = false;
                          }
                          callingDefault();
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
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          // fontFamily: "Nunito",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  int _state = 0;
  Widget setUpButtonChild() {
    if (_state == 0) {
      return Container(
        height: 45.0,
        width: double.infinity,
        decoration: new BoxDecoration(
          border: new Border.all(
              color: Color(0xff1a73e9), width: 5.0, style: BorderStyle.solid),
          borderRadius: new BorderRadius.circular(100.0),
        ),
        child: new Container(
          height: 35.0,
          width: double.infinity,
          decoration: new BoxDecoration(
            border: new Border.all(
                color: Color(0xff1a73e8), width: 5.0, style: BorderStyle.solid),
            borderRadius: new BorderRadius.circular(100.0),
          ),
          child: Container(
            color: Color(0xff1a73e8),
            child: Center(
              child: Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontFamily: "Nunito",
                ),
              ),
            ),
          ),
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      );
    } else {
      return Icon(Icons.check, color: Colors.black);
    }
  }

  Future<void> animateButton() async {
    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 3000), () {
      setState(() {
        _state = 0;
      });
    });
    serviceTypes.clear();
    serviceCat.clear();
    defaultCont.clear();

    dropDownValueST = "Select";
    dropDownValueSC = "Select";
    dropDownValueDC = "Select";
    serviceType = "";
    serviceID = 0;
    serviceIDs.clear();
    serviceCatID = "";
    serviceCatIDs.clear();
    callingDefault();
    var utilityBasic = UtilityBasicS();
    utilityBasic.toastfun(resPONSE["message"]);
  }
}

var resPONSE;
var utilityBasic = UtilityBasicS();
