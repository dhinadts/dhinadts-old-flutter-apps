import 'dart:convert';

import 'package:animated/main.dart';
import 'package:animated/utility_basics.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets.dart';

import 'package:http/http.dart' as http;

TextEditingController usernameC = new TextEditingController();
TextEditingController passwordC = new TextEditingController();
TextEditingController domainC = new TextEditingController();
TextEditingController branchCodeC = new TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final globalScaffoldKey1 = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    /*  usernameC.clear();
    passwordC.clear();
    domainC.clear();
    branchCodeC.clear(); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalScaffoldKey1,
        backgroundColor: Colors.white,
        body: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: EdgeInsets.only(top: 70, bottom: 50),
              child: Image.asset(
                "assets/images/logo-new.png",
                height: 80.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Text(
                  "Login with Username, Password, Company Domain & Branch Code",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 1.0,
                    color: Color(0xff5f5f5f),
                    fontFamily: "Gilory-Medium",
                    fontSize: 20.0,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Material(
                  color: Colors.white,
                  shadowColor: Colors.white,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    height:
                        MediaQuery.of(context).size.height > 600 ? 400 : 300,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          loginTextFields(context, "Username", usernameC, 1),
                          loginTextFields(context, "Password", passwordC, 0),
                          loginTextFields(context, "Domain", domainC, 1),
                          loginTextFields(
                              context, "Branch Code", branchCodeC, 1),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                // border: Border.none,
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              width: double.infinity,
                              child: ButtonTheme(
                                height: 60.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0)),
                                child: RaisedButton(
                                    color: Color(0xff4f48ff),
                                    onPressed: () async {
                                      FocusScope.of(context).requestFocus(new FocusNode());
                                      var utilityBasic = UtilityBasicS();
                                      var net =
                                          await utilityBasic.checknetwork();
                                      ProgressDialog pr = new ProgressDialog(
                                          context,
                                          type: ProgressDialogType.Normal);
                                      pr.style(message: 'Please Wait...');
                                      pr.show();
                                      if (net == true) {
                                        try {
                                          var response = await http.get(
                                              "https://api.lcsbridge.com/tracking/login?username=${usernameC.text}&password=${passwordC.text}&domain=${domainC.text}&code=${branchCodeC.text}");

                                          var loginResponse =
                                              json.decode(response.body);
                                          if (loginResponse["title"] ==
                                              "Error") {
                                            var keyss = loginResponse["message"]
                                                .keys
                                                .toList();

                                            if (pr.isShowing()) pr.hide();
                                            customToast(context,
                                                "${loginResponse["message"][keyss[0]]}");
                                          } else {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            await prefs.setString(
                                                "apiToken",
                                                loginResponse["data"]
                                                    ["api_token"]);
                                            await prefs.setInt(
                                                "companyID",
                                                loginResponse["data"]
                                                    ["company_id"]);
                                            await prefs.setString(
                                                "domain", "${domainC.text}");
                                            await prefs.setInt("LoggedIN", 1);
                                            await prefs.setString("LoggedName",
                                                loginResponse["data"]["name"]);
                                            await prefs.setString(
                                                "RowNO",
                                                loginResponse["data"]
                                                    ["row_no"]);
                                            await prefs.setString(
                                                "CustLogo",
                                                loginResponse["data"]["company"]
                                                    ["logo"]);
                                            await prefs.setString(
                                                "CustName",
                                                loginResponse["data"]["company"]
                                                    ["name"]);
                                            custLogo =
                                                prefs.getString("CustLogo");
                                            custName =
                                                prefs.getString("CustName");

                                            if (pr.isShowing()) pr.hide();
                                            print(loginResponse);

                                            await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyHomePage(index: 0)));
                                          }
                                        } catch (e) {
                                          if (pr.isShowing()) pr.hide();
                                          print(e);

                                          customToast(context,
                                              "Please check your Login Credentials");
                                        }
                                      } else {
                                        if (pr.isShowing()) pr.hide();

                                        customToast(context,
                                            "Please check your net connections");
                                      }
                                    },
                                    child: Text(
                                      "LOGIN",
                                      style: submitButton(),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ));
  }
}
