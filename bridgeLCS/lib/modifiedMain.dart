import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:galubetech/dashboardNew.dart';
import 'package:galubetech/db/sharedprefs.dart';
import 'package:galubetech/db/utility_basics.dart';
import 'package:galubetech/introSLides.dart';
import 'package:galubetech/privacyPolicy.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter/services.dart';
import 'package:rate_my_app/rate_my_app.dart';

var prefs = SharedPreferenceS();
int loggedIN;
const debug = true;
ProgressDialog pr;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: debug);
  zoomImageHotfix();

  runApp(new MyApp());
}

void zoomImageHotfix() {
  WidgetsFlutterBinding.ensureInitialized();
  const maxBytes = 768 * (1 << 20);
  SystemChannels.skia.invokeMethod('setResourceCacheMaxBytes', maxBytes);
  SystemChannels.skia.invokeMethod('Skia.setResourceCacheMaxBytes', maxBytes);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    loginInfo();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await rateMyApp.init();
      if (mounted && rateMyApp.shouldOpenDialog) {
        rateMyApp.showRateDialog(context);
      }
    });
  }

  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'Rate this app',
    googlePlayIdentifier: 'com.bridgelcs',
    minDays: 2, // Show rate popup on first day of install.
    minLaunches:
        5, // Show rate popup after 5 launches of app after minDays is passed.
  );

  @override
  void dispose() {
    super.dispose();
  }

  loginInfo() async {
    loggedIN = await prefs.getInt("loggedIN");
    apiToken = await prefs.getString("APIToken");
    companyID = await prefs.getInt("CompanyID");
    loginCode = await prefs.getString("CODE");
    domainCode = await prefs.getString("Domain");
    userEmail = await prefs.getString("userEmail");
    userName = await prefs.getString("userName");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "BridgeLCS",
        theme: ThemeData(fontFamily: 'Nunito'),
        home: loggedIN == 1
            ? DashBoardNew()
            : (loggedIN == 0
                ? INtroSlides()
                : (loggedIN == 2 ? MyHomePageEx() : LoadingPage())));
  }
}

class MyHomePageEx extends StatefulWidget {
  MyHomePageEx({Key key}) : super(key: key);

  @override
  _MyHomePageExState createState() => _MyHomePageExState();
}

class _MyHomePageExState extends State<MyHomePageEx> {
  setLoGGED() async {
    await prefs.setint("loggedIN", 1);
    loggedIN = await prefs.getInt("loggedIN");
  }

  FocusNode focusNode;
  bool a = false, b = false, c = false;
  TextEditingController emailAdd = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController domain = new TextEditingController();

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
    focusNode.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            // scrollDirection: Axis.vertical,
            // physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //  crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/logo-new.png",
                      width: 220.0,
                    ),
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(),
                ),
                Container(
                  child: Padding(
                      padding: EdgeInsets.only(
                        left: 25.0,
                        right: 25.0,
                        // top: 0.0,
                      ),
                      child: Column(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              )),
                          Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, bottom: 10.0),
                                child: Text(
                                  "Please sign in to continue",
                                  style: TextStyle(
                                    fontFamily: "Nunito",
                                  ),
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Focus(
                                // autofocus: true,
                                onFocusChange: (hasFocus) {
                                  if (hasFocus) {
                                    setState(() {
                                      a = true;
                                      b = false;
                                      c = false;
                                    });
                                  }
                                },
                                child: a
                                    ? Material(
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: TextFormField(
                                          autofocus: true,
                                          controller: emailAdd,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          onSaved: (String value) {
                                            var u = UtilityBasicS();
                                            return value.contains('@')
                                                ? u.toastfun("OK")
                                                : u.toastfun(
                                                    'Noty valid email');
                                          },
                                          validator: (String value) {
                                            return value.contains('@')
                                                ? 'OK'
                                                : 'Noty valid email';
                                          },
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Email",
                                              hintStyle: TextStyle(
                                                  fontFamily: "Nunito"),
                                              prefixIcon:
                                                  Icon(Icons.mail_outline)),
                                        ),
                                      )
                                    : TextField(
                                        controller: emailAdd,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          border: new UnderlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.blue)),
                                          hintText: "Email",
                                          hintStyle:
                                              TextStyle(fontFamily: "Nunito"),
                                          prefixIcon: Icon(Icons.mail_outline),
                                        ),
                                      ),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Focus(
                              onFocusChange: (hasFocus) {
                                if (hasFocus) {
                                  setState(() {
                                    b = true;
                                    a = false;
                                    c = false;
                                  });
                                }
                              },
                              child: b
                                  ? Material(
                                      elevation: 5.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: TextField(
                                        autofocus: true,
                                        obscureText: true,
                                        controller: password,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          hintStyle:
                                              TextStyle(fontFamily: "Nunito"),
                                          prefixIcon: Icon(Icons.lock),
                                        ),
                                      ),
                                    )
                                  : TextField(
                                      obscureText: true,
                                      readOnly: true,
                                      controller: password,
                                      decoration: InputDecoration(
                                        border: new UnderlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.blue)),
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(fontFamily: "Nunito"),
                                        prefixIcon: Icon(Icons.lock),
                                      ),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Focus(
                              onFocusChange: (hasFocus) {
                                if (hasFocus) {
                                  setState(() {
                                    c = true;
                                    a = false;
                                    b = false;
                                  });
                                }
                              },
                              child: c
                                  ? Material(
                                      elevation: 5.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: TextField(
                                        autofocus: true,
                                        controller: domain,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Domain",
                                          hintStyle:
                                              TextStyle(fontFamily: "Nunito"),
                                          prefixIcon: Icon(Icons.link),
                                        ),
                                      ),
                                    )
                                  : TextField(
                                      showCursor: true,
                                      readOnly: true,
                                      controller: domain,
                                      decoration: InputDecoration(
                                        border: new UnderlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.blue)),
                                        hintText: "Domain",
                                        hintStyle:
                                            TextStyle(fontFamily: "Nunito"),
                                        prefixIcon: Icon(Icons.link),
                                      ),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0, right: 5.0, top: 20.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: ButtonTheme(
                                // minWidth: 150,
                                height: 50,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(100.0),
                                ),
                                child: RaisedButton(
                                  color: Color(0xff1a73e9),
                                  onPressed: () async {
                                    var utilityBasic = UtilityBasicS();

                                    var net = await utilityBasic.checknetwork();

                                    pr = new ProgressDialog(context,
                                        type: ProgressDialogType.Normal);
                                    pr.style(message: 'Please Wait...');
                                    pr.show();
                                    if (net == true) {
                                      var url =
                                          "http://api.lcsbridge.xyz/login?email=${emailAdd.text}&password=${password.text}&domain=${domain.text}";
                                      var response = await http.get(url);

                                      loginRes = json.decode(response.body);
                                      if (loginRes["title"] == "Error") {
                                        var keyss =
                                            loginRes["message"].keys.toList();

                                        if (pr.isShowing()) pr.hide();
                                        utilityBasic.toastfun(
                                            "${loginRes["message"][keyss[0]]}");
                                      } else {
                                        await prefs.setString("APIToken",
                                            "${loginRes["data"]["api_token"]}");
                                        await prefs.setint("CompanyID",
                                            loginRes["data"]["company_id"]);

                                        await prefs.setString("Domain",
                                            "${loginRes["data"]["companies"][0]["domain"]}");
                                        await prefs.setString("CODE",
                                            "${loginRes["data"]["companies"][0]["code"]}");
                                        await prefs.setString("CompanyLOGO",
                                            "${loginRes["data"]["companies"][0]["logo"]}");
                                        await prefs.setString("userEmail",
                                            "${loginRes["data"]["email"]}");
                                        await prefs.setString("userName",
                                            "${loginRes["data"]["name"]}");

                                        await prefs.setString("CompnayImage",
                                            "${loginRes["data"]["image"]}");

                                        apiToken =
                                            await prefs.getString("APIToken");
                                        companyID =
                                            await prefs.getInt("CompanyID");
                                        loginCode =
                                            await prefs.getString("CODE");
                                        userEmail =
                                            await prefs.getString("userEmail");
                                        userName =
                                            await prefs.getString("userName");

                                        companyLogo = await prefs
                                            .getString("CompanyLOGO");
                                        compnayImage = await prefs
                                            .getString("compnayImage");
                                        domainCode =
                                            await prefs.getString("Domain");
                                        await prefs.setint("loggedIN", 1);
                                        if (pr.isShowing()) pr.hide();

                                        loggedIN =
                                            await prefs.getInt("loggedIN");
                                        setState(() {});
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DashBoardNew()),
                                        );
                                      }
                                    } else {
                                      if (pr.isShowing()) pr.hide();
                                      utilityBasic.toastfun(
                                          "Please check your Net connections");
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "LOGIN",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Nunito",
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Image.asset("assets/images/next.png")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(),
                    GestureDetector(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewPrivacyPolicy(
                                      sett: 1,
                                      viewLink:
                                          "https://lcsbridge.com/privacy-policy.php",
                                    )));
                      },
                      child: Text("Privacy Policy",
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Nunito",
                          )),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewPrivacyPolicy(
                                      sett: 2,
                                      viewLink:
                                          "https://lcsbridge.com/security.php",
                                    )));
                      },
                      child: Text("Security",
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Nunito",
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dashboardAPICALL() async {
    Response response;
    Dio dio = new Dio();

    response = await dio.get(
        "http://api.lcsbridge.xyz/dashboard?api_token='$apiToken'&company_id='$companyID'",
        queryParameters: {
          "api_token": apiToken,
          "company_id": companyID,
        });

    dashboardRes = response.data;
    jobSummary = dashboardRes["jobSummary"];
    dailySummary = dashboardRes["dailySummary"];
    monthlyCount = dashboardRes["monthlyCount"];
    invoiceSummary = dashboardRes["invoiceSummary"];
    setState(() {});
  }
}

var jobSummary, dailySummary, monthlyCount, invoiceSummary;

var loginRes;
String apiToken = "";
var companyID;
String loginCode = "";
String domainCode = "";
String userEmail = "", userName = "", companyLogo = "", compnayImage = "";

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10), () {
      prefss();
    });
  }

  prefss() async {
    await prefs.setint("loggedIN", 2);
    loggedIN = await prefs.getInt("loggedIN");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Image.asset("assets/images/Landing.png"),
    );
  }
}
