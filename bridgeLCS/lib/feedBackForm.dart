import 'dart:async';
import 'package:dio/dio.dart';
import 'package:galubetech/customer.dart';
import 'package:galubetech/dashboardNew.dart';
import 'package:galubetech/db/utility_basics.dart';
import 'package:galubetech/jobStatus.dart';
import 'package:galubetech/jobs.dart';
import 'package:galubetech/main.dart';
import 'package:galubetech/supplierNew.dart';
import 'package:galubetech/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class FeedBack extends StatefulWidget {
  FeedBack({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FeedBackState createState() => _FeedBackState();
}

enum groupValues { bug, suggesstion }

class _FeedBackState extends State<FeedBack> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var nameController, emailController, mobileNoController;
  // var groupValues; // = [0, 1];
  int radioValues = 0;
  int radioOut;
  groupValues seleCt;

  TextEditingController feedbackController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  @override
  void initState() {
    super.initState();
    seleCt = groupValues.bug;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                          Navigator.pop(context);
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

                          print(response.data.toString());
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
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 1.0,
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
            Transform.translate(
              offset: Offset(-5, 0),
              child: Text("Feedback",
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
                                10.0 * MediaQuery.of(context).devicePixelRatio))),
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
                                        await pr.show();
                                        loginCode = summa['data'][ii]['code'];
                                        companyID = summa['data'][ii]['id'];
                                        companyLogo = summa['data'][ii]['logo'];
                                        await prefs.setint(
                                            "CompanyID", summa['data'][ii]['id']);
                                        await prefs.setString(
                                            "CODE", summa['data'][ii]['code']);
                                        await prefs.setString("CompanyLOGO",
                                            summa['data'][ii]['logo']);

                                        companyLogo =
                                            await prefs.getString("CompanyLOGO");
                                        companyID =
                                            await prefs.getInt("CompanyID");
                                        loginCode = await prefs.getString("CODE");
                                        setState(() {});
                                        Future.delayed(
                                            const Duration(milliseconds: 500),
                                            () {
                                          setState(() {});
                                        });
                                        if (pr.isShowing()) await pr.hide();

                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.all(8.0),
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
                                                  overflow: TextOverflow.ellipsis,
                                                  style: dialCard(),
                                                ),
                                              ),
                                              Text("${summa['data'][ii]['name']}")
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
          color: Colors.black87,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: RadioListTile(
                                  title: Text(
                                    "Bug",
                                    style: TextStyle(
                                        fontFamily: "Nunito", fontSize: 15.0),
                                  ),
                                  value: groupValues.bug,
                                  groupValue: seleCt,
                                  onChanged: (value) {
                                    setState(() {
                                      radioValues = 0;
                                      seleCt = value;
                                    });
                                  }),
                            ),
                            Expanded(
                              child: RadioListTile(
                                  title: Text(
                                    "Suggestion",
                                    style: TextStyle(
                                        fontFamily: "Nunito", fontSize: 15.0),
                                  ),
                                  value: groupValues.suggesstion,
                                  groupValue: seleCt,
                                  onChanged: (value) {
                                    setState(() {
                                      seleCt = value;
                                      radioValues = 1;
                                    });
                                  }),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: subjectController,
                            maxLines: 2,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Valid Feedback';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                alignLabelWithHint: true,
                                labelText: "Subject",
                                hintText: 'Subject',
                                border: OutlineInputBorder()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: feedbackController,
                            maxLines: 8,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Valid Feedback';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                alignLabelWithHint: true,
                                labelText: "Feedback",
                                hintText: 'Feedback',
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  )),
              Material(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonTheme(
                    minWidth: 320,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(100.0),
                    ),
                    child: RaisedButton(
                      color: Color(0xff1a73e9),
                      textColor: Colors.white,
                      onPressed: submitForm,
                      child: Text(
                        'Submit Feedback',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _state = 0;
  Widget setUpButtonChildFEEDBACK() {
    if (_state == 0) {
      return Container(
        height: 45.0,
        width: 360.0,
        decoration: new BoxDecoration(
          border: new Border.all(
              color: Color(0xff1a73e8), width: 5.0, style: BorderStyle.solid),
          borderRadius: new BorderRadius.circular(100.0),
        ),
        child: new Container(
          height: 35.0,
          width: 200.0,
          decoration: new BoxDecoration(
            border: new Border.all(
                color: Color(0xff1a73e8), width: 5.0, style: BorderStyle.solid),
            borderRadius: new BorderRadius.circular(100.0),
          ),
          child: Container(
            color: Color(0xff1a73e8),
            child: Center(
              child: Text(
                "Submit Feedback",
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

  void animateButton() {
    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 10000), () {
      setState(() {
        _state = 0;
      });
    });
  }

  submitForm() async {
    String urlFeedBack = "http://api.lcsbridge.xyz/feedback";
    try {
      await Dio().get(urlFeedBack, queryParameters: {
        "api_token": apiToken,
        "company_id": companyID,
        "domain": domainCode,
        "type": radioValues,
        "subject": subjectController.text,
        "description": feedbackController.text,
      }).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(url).then((response) async {
            var a = UtilityBasicS();
            a.toastfun("Your feedback Sent successfully");
            radioValues = 0;
            seleCt = groupValues.bug;
          subjectController.clear();
          feedbackController.clear();
          setState(() {
            
          });
            /*   await Navigator.push(context,
                MaterialPageRoute(builder: (context) => DashBoardNew())); */
          });
        } else {
          var a = UtilityBasicS();
          a.toastfun("Your feedback Sent successfully");
          radioValues = 0;
          seleCt = groupValues.bug;
          subjectController.clear();
          feedbackController.clear();
          setState(() {
            
          });
          /* await Navigator.push(
              context, MaterialPageRoute(builder: (context) => DashBoardNew())); */
        }
      });
    } catch (e) {
      var a = UtilityBasicS();
      a.toastfun("Something went wrong");
      if (e.response.statusCode == 401) {
        await prefs.setint("loggedIN", 2);
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePageEx()));
      }
    }
  }
}
