import 'package:flutter/material.dart';

class EnterEmailAdd extends StatefulWidget {
  EnterEmailAdd({Key key}) : super(key: key);

  @override
  _EnterEmailAddState createState() => _EnterEmailAddState();
}

class _EnterEmailAddState extends State<EnterEmailAdd> {
  bool d = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(left: 0, right: 0.0, top: 0),
              child: SingleChildScrollView(
                // physics: NeverScrollableScrollPhysics(),

                child: Column(
                  children: <Widget>[
                    Container(
                      // color: Colors.black,
                      child: Image.asset(
                        "assets/images/logo-w.png",
                        height: 100,
                        width: 180,
                      ),
                      width: double.infinity,
                      height: 200
                      /**  35.0 750*/,
                      //  color: Colors.blue,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            colors: [Color(0xff643cfe), Color(0xff00ceff)]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Reset Password",
                          style:
                              TextStyle(fontFamily: "Nunito", fontSize: 20.0)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 10.0),
                      child: Text(
                          "Don't worry! Just fill in your email and we'll help you to reset your password",
                          style: TextStyle(
                            fontFamily: "Nunito",
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 10.0),
                      child: Focus(
                        onFocusChange: (hasFocus) {
                          setState(() {
                            d = true;
                          });
                        },
                        child: d
                            ? Material(
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8.0),
                                    border: InputBorder.none,
                                    hintText: "E-mail Address",
                                    hintStyle:
                                          TextStyle(fontFamily: "Nunito",),
                                  ),
                                ),
                              )
                            : TextField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintText: "E-mail Address",
                                  hintStyle:
                                          TextStyle(fontFamily: "Nunito",),
                                  border: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          width: 2.0, color: Colors.blue)),
                                ),
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ButtonTheme(
                        minWidth: 150,
                        height: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(100.0),
                        ),
                        child: RaisedButton(
                            color: Colors.blue[900],
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResetPassword()),
                              );
                            },
                            child: Text("Send Password Reset Link",
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    color: Colors.white))),
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0.0, top: 0),
          child: SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(),

            child: Column(
              children: <Widget>[
                Container(
                  // color: Colors.black,
                  child: Image.asset(
                    "assets/images/logo-w.png",
                    height: 100,
                    width: 180,
                  ),
                  width: double.infinity,
                  height: 200
                  /**  35.0 750*/,
                  //  color: Colors.blue,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                        colors: [Color(0xff643cfe), Color(0xff00ceff)]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Reset Password",
                      style: TextStyle(fontFamily: "Nunito", fontSize: 20.0)),
                ),
                
                Padding(
                  padding:
                      const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      setState(() {
                        e = true;
                        f = false;
                        g = false;
                      });
                    },
                    child: e
                        ? Material(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: TextField(
                              controller: emailAdd,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8.0),
                                border: InputBorder.none,
                                hintText: "E-mail Address",
                                hintStyle: TextStyle(
                                  fontFamily: "Nunito",
                                ),
                              ),
                            ),
                          )
                        : TextField(
                            controller: emailAdd,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "E-mail Address",
                              hintStyle: TextStyle(
                                fontFamily: "Nunito",
                              ),
                              border: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      width: 2.0, color: Colors.blue)),
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      setState(() {
                        e = false;
                        f = true;
                        g = false;
                      });
                    },
                    child: f
                        ? Material(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: TextField(
                              controller: passWord,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8.0),
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  fontFamily: "Nunito",
                                ),
                              ),
                            ),
                          )
                        : TextField(
                            controller: passWord,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(
                                fontFamily: "Nunito",
                              ),
                              border: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      width: 2.0, color: Colors.blue)),
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      setState(() {
                        e = false;
                        f = false;
                        g = true;
                      });
                    },
                    child: g
                        ? Material(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: TextField(
                              controller: confirmPassword,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8.0),
                                border: InputBorder.none,
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(
                                  fontFamily: "Nunito",
                                ),
                              ),
                            ),
                          )
                        : TextField(
                            readOnly: true,
                            controller: confirmPassword,
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(
                                fontFamily: "Nunito",
                              ),
                              border: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      width: 2.0, color: Colors.blue)),
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ButtonTheme(
                    minWidth: 150,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(100.0),
                    ),
                    child: RaisedButton(
                        color: Colors.blue[900],
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => null),
                          );
                        },
                        child: Text("Reset Password",
                            style: TextStyle(
                                fontFamily: "Nunito", color: Colors.white))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
