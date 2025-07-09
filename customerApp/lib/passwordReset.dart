import 'dart:convert';

import 'package:animated/loginPage.dart';
import 'package:animated/main.dart';
import 'package:animated/utility_basics.dart';
import 'package:animated/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({Key key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool e = false, f = false, g = false;
  TextEditingController emailAdd = new TextEditingController();
  TextEditingController passWord = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 20.0),
            onPressed: () {
              Navigator.pop(context);
            }),
        iconTheme: new IconThemeData(
          color: Colors.black87,
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      "assets/images/logo-new.png",
                    ),
                    height: 80.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Text("Change Password",
                        style: TextStyle(
                            color: Colors.indigo,
                            fontFamily: "Gilory-Medium",
                            fontSize: 20.0)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: loginTextFields(
                        context, "Current Password", emailAdd, 0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        loginTextFields(context, "New Password", passWord, 0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: loginTextFields(
                        context, "Confirm Password", confirmPassword, 0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Container(
                      width: double.infinity,
                      child: ButtonTheme(
                        height: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(100.0),
                        ),
                        child: RaisedButton(
                            color: Color(0xff4f48ff),
                            onPressed: () async {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              if (emailAdd.text.length == 0 ||
                                  emailAdd.text == "") {
                                customToast(context, "Enter current password");
                              } else if (passWord.text.length == 0 ||
                                  passWord.text == "") {
                                customToast(context, "Enter new password");
                              } else if (confirmPassword.text.length == 0 ||
                                  confirmPassword.text == "") {
                                customToast(context, "Enter confirm password");
                              } else {
                                if (confirmPassword.text == passWord.text) {
                                  Map formData = {
                                    "api_token": "$apiToken",
                                    "company_id": "$companyID",
                                    "domain": "$domain",
                                    "old_password": "${emailAdd.text}",
                                    "password": "${passWord.text}",
                                    "confirm_password":
                                        "${confirmPassword.text}",
                                  };
                                  try {
                                    var url =
                                        "https://api.lcsbridge.com/tracking/password";
                                    var response =
                                        await http.post(url, body: formData);
                                    var passwordResponse =
                                        json.decode(response.body);

                                    if (passwordResponse.keys
                                        .contains("message")) {
                                      customToast(context,
                                          "${passwordResponse["message"]}");
                                    } else {
                                      customToast(context,
                                          "${passwordResponse.values.toList()[0][0]}");
                                    }
                                  } catch (e) {
                                    if (e.response.statusCode == 401) {
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("apiToken", null);
          await prefs.setInt("companyID", null);
          await prefs.setString("domain", null);
          await prefs.setInt("LoggedIN", null);
          await prefs.setString("LoggedName", null);
          usernameC.clear();
          passwordC.clear();
          domainC.clear();
          branchCodeC.clear();

                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    }
                                  }
                                } else {
                                  customToast(context, "Password not matched");
                                }
                              }
                            },
                            child:
                                Text("Reset Password", style: submitButton())),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
