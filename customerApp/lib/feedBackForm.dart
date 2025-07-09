import 'package:animated/loginPage.dart';
import 'package:animated/utility_basics.dart';
import 'package:animated/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class FeedBack extends StatefulWidget {
  FeedBack({
    Key key,
    this.title,
  }) : super(key: key);

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
    seleCt = groupValues.suggesstion;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 20.0),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Transform.translate(
          offset: Offset(-20.0, 0),
          child: Text("Feedback",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: "Gilory-Medium",
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
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
                              flex: 1,
                              child: RadioListTile(
                                  title: Transform.translate(
                                    offset: Offset(-12.0, 0),
                                    child: Text(
                                      "Bug",
                                      style: TextStyle(
                                          fontFamily: "Gilory-Medium",
                                          fontSize: 15.0),
                                    ),
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
                              flex: 1,
                              child: RadioListTile(
                                  title: Transform.translate(
                                    offset: Offset(-12.0, 0),
                                    child: Text(
                                      "Suggestion",
                                      style: TextStyle(
                                          fontFamily: "Gilory-Medium",
                                          fontSize: 15.0),
                                    ),
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
                          child: Container(
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),

                              color: Colors.white,
                              border: new Border.all(
                                  style: BorderStyle.solid,
                                  color: Color(0xffdadce0)),
                              // borderRadius: BorderRadius.circular(50.0)
                            ),
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
                                  // labelText: "Feedback",
                                  hintText: 'Subject',
                                  hintStyle: TextStyle(
                                    fontFamily: "Gilory-Medium",
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              border: new Border.all(
                                  style: BorderStyle.solid,
                                  color: Color(0xffdadce0)),
                            ),
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
                                // labelText: "Feedback",
                                hintText: 'Feedback',
                                hintStyle: TextStyle(
                                  fontFamily: "Gilory-Medium",
                                ),
                                //  border: OutlineInputBorder()
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
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
                      color: Color(0xff4f48ff),
                      textColor: Colors.white,
                      onPressed: submitForm,
                      child: Text('Submit Feedback', style: submitButton()),
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

  submitForm() async {
    String urlFeedBack =
        "https://api.lcsbridge.com/tracking/feedback?api_token=$apiToken&company_id=$companyID&domain=$domain&type=$radioValues&title=${subjectController.text}&description=${feedbackController.text}&rating=$ratinG";

    if (feedbackController.text == "" || feedbackController.text.isEmpty) {
      customToast(context, "Please type feedback");
    } else {
      try {
        await Dio().get(urlFeedBack, queryParameters: {
          "api_token": apiToken,
          "company_id": companyID,
          "domain": domain,
          "type": radioValues,
          "title": subjectController.text,
          "description": feedbackController.text,
          "rating": ratinG,
        });
        customToast(context, "Your feedback Sent successfully");

        radioValues = 1;
        print("Success");

        subjectController.clear();
        feedbackController.clear();
        ratinG = 3.0;
        setState(() {});
      } catch (e) {
        customToast(context, "Something went wrong");
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
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      }
    }
  }
}

class FeedBackCard extends StatefulWidget {
  FeedBackCard({
    Key key,
    @required this.rowID,
    @required this.id,
  }) : super(key: key);

  final String rowID;
  final int id;

  @override
  _FeedBackCardState createState() => _FeedBackCardState();
}

class _FeedBackCardState extends State<FeedBackCard> {
  final _formKey1 = GlobalKey<FormState>();
  final _scaffoldKey1 = GlobalKey<ScaffoldState>();
  var nameController, emailController, mobileNoController;

  TextEditingController feedbackController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey1,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 20.0),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Transform.translate(
          offset: Offset(-20.0, 0),
          child: Text("Feedback - ${widget.rowID}",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: "Gilory-Medium",
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
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
                  key: _formKey1,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Align(alignment: Alignment.center, child: Test()),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              border: new Border.all(
                                  style: BorderStyle.solid,
                                  color: Color(0xffdadce0)),
                            ),
                            child: TextFormField(
                              controller: subjectController,
                              maxLines: 1,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter Valid Feedback';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  // labelText: "Subject",
                                  hintText: 'Subject',
                                  hintStyle: TextStyle(
                                    fontFamily: "Gilory-Medium",
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              border: new Border.all(
                                  style: BorderStyle.solid,
                                  color: Color(0xffdadce0)),
                            ),
                            child: TextFormField(
                              controller: feedbackController,
                              maxLines: 5,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter Valid Feedback';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  hintText: 'Feedback',
                                  hintStyle: TextStyle(
                                    fontFamily: "Gilory-Medium",
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
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
                      color: Color(0xff4f48ff),
                      textColor: Colors.white,
                      onPressed: () {
                        submitForm1(widget.id);
                      },
                      child: Text('Submit Feedback', style: submitButton()),
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

  void submitForm1(int id) async {
    String urlFeedBack =
        "https://api.lcsbridge.com/tracking/feedback?api_token=$apiToken&company_id=$companyID&domain=$domain&title=${subjectController.text}&description=${feedbackController.text}&rating=$ratinG&job_id=$id";
   
    if (feedbackController.text == "" || feedbackController.text.isEmpty) {
      customToast(context, "Please type feedback");
    } else {
      try {
        await Dio().get(urlFeedBack, queryParameters: {
          "api_token": apiToken,
          "company_id": companyID,
          "domain": domain,
          // "type": radioValues,
          "title": subjectController.text,
          "description": feedbackController.text,
          "rating": ratinG,
          "job_id": "${widget.id}"
        }).then((response) async {
          if (response.statusCode == 302) {
            var url = response.headers['location'];
            await http.get(url).then((response) async {
              customToast(context, "Your feedback Sent successfully");
              print("Success");
              subjectController.clear();
              feedbackController.clear();
              ratinG = 3.5;
              setState(() {});
            });
          } else {
            print("Success..1");

            subjectController.clear();
            feedbackController.clear();
            ratinG = 3.5;
            customToast(context, "Your feedback Sent successfully");
            setState(() {});
          }
        });
      } catch (e) {
        customToast(context, "Something went wrong");
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
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      }
    }
  }
}
