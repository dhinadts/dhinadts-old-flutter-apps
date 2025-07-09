import 'dart:async';
import 'dart:ui';

import 'package:animated/feedBackForm.dart';
import 'package:animated/loginPage.dart';
import 'package:animated/passwordReset.dart';
import 'package:animated/privacyPolicy.dart';
import 'package:animated/utility_basics.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget loginTextFields(BuildContext context, String hintText,
    TextEditingController controller, int a) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Center(
        child: Material(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
          child: Center(
            child: TextField(
              style: TextStyle(
                  letterSpacing: 1.0,
                  decoration: TextDecoration.none,
                  color: Color(0xff0700b1),
                  fontSize: 18,
                  fontFamily: "Gilory-Medium"),
              controller: controller,
              autofocus: true,
              obscureText: a == 1 ? false : true,
              keyboardType:
                  a == 1 ? TextInputType.emailAddress : TextInputType.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20.0),
                //  alignLabelWithHint: true,
                border: InputBorder.none,
                hintText: "$hintText",
                hintStyle: TextStyle(
                    letterSpacing: 1.0,
                    decoration: TextDecoration.none,
                    color: Color(0xff0700b1),
                    fontSize: 18,
                    fontFamily: "Gilory-Medium"),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget sliderCardsNew(
    Color color, int index, var data, String month, String dateFormat) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              spreadRadius: 7,
              blurRadius: 5,
              color: Colors.white.withOpacity(0.05))
        ]),
        child: Material(
            elevation: 5.0,
            color: color,
            borderOnForeground: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 25.0, bottom: 25.0, left: 35.0, right: 35.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        child: Text(
                            index == 0
                                ? "JOBS SUMMARY"
                                : (index == 1
                                    ? "INVOICE SUMMARY"
                                    : "STATEMENT SUMMARY"),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Gilory",
                              fontSize: 15.0,
                            ))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: 70.0,
                                child:
                                    Text("${data['${data.keys.toList()[0]}']}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Gilory",
                                          fontSize: 18.0,
                                        ))),
                            SizedBox(
                                width: 70.0,
                                child: Text(
                                    "${data.keys.toList()[0]}".toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Gilory-Reg",
                                      fontSize: 12.0,
                                    )))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: 70.0,
                                child:
                                    Text("${data['${data.keys.toList()[1]}']}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Gilory",
                                          fontSize: 18.0,
                                        ))),
                            SizedBox(
                                width: 70.0,
                                child: Text(
                                    "${data.keys.toList()[1]}".toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Gilory-Reg",
                                      fontSize: 12.0,
                                    )))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: 70.0,
                                child:
                                    Text("${data['${data.keys.toList()[2]}']}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Gilory",
                                          fontSize: 18.0,
                                        ))),
                            SizedBox(
                                width: 70.0,
                                child: Text(
                                    "${data.keys.toList()[2]}".toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Gilory-Reg",
                                      fontSize: 12.0,
                                    )))
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 70.0,
                            child: Text("$month".toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Gilory-Medium",
                                  fontSize: 13.0,
                                ))),
                        SizedBox(
                            width: 70.0,
                            child: Text("$dateFormat",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Gilory-Medium",
                                  fontSize: 13.0,
                                ))),
                        Transform.translate(
                          offset: Offset(40.0, 0),
                          child: SizedBox(
                            width: 70.0,
                            child: Image.asset("assets/icons/settings.png",
                                height: 18, width: 30),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))),
      ));
}

Widget dotsInJobs(bool one) {
  return Container(
    height: one ? 7 : 2,
    width: one ? 7 : 2,
    padding: EdgeInsets.all(5.0),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(100)),
  );
}

Widget moreWidget(BuildContext context, Icon icon, String title, int which) {
  return GestureDetector(
    onTap: () async {
      if (which == 1) {
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword()));
      } else if (which == 2) {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewPrivacyPolicy(
                      sett: 1,
                      viewLink: "https://lcsbridge.com/privacy-policy.php",
                    )));
      } else if (which == 3) {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewPrivacyPolicy(
                      sett: 2,
                      viewLink: "https://lcsbridge.com/security.php",
                    )));
      } else if (which == 4) {
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => FeedBack()));
      } else if (which == 5) {
        customToast(context, "You logged out successfully");

        Timer(Duration(seconds: 2), () async {
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
        });
      } else {}
    },
    child: ListTile(
      leading: icon,
      title:
          Transform.translate(offset: Offset(-20.0, 0), child: Text("$title")),
      trailing: Icon(Icons.arrow_forward_ios),
    ),
  );
}

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;

  StarRating(
      {this.starCount = 5,
      this.rating = .0,
      this.onRatingChanged,
      this.color = Colors.red});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        Icons.star_border,
        size: 30.0,
        color: Theme.of(context).buttonColor,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        Icons.star_half,
        size: 30.0,
        color: color ?? Theme.of(context).primaryColor,
      );
    } else {
      icon = new Icon(
        Icons.star,
        size: 30.0,
        color: color ?? Theme.of(context).primaryColor,
      );
    }
    return new InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
        children:
            new List.generate(starCount, (index) => buildStar(context, index)));
  }
}

double ratinG = 3.5;

class Test extends StatefulWidget {
  @override
  _TestState createState() => new _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 10.0),
          new StarRating(
            rating: ratinG,
            color: Colors.indigo,
            onRatingChanged: (rating) {
              setState(() {
                ratinG = rating;
              });
            },
          ),
          SizedBox(width: 10.0),
        ],
      ),
    );
  }
}

TextStyle submitButton() {
  return TextStyle(
      letterSpacing: 1.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontFamily: "Gilory-Medium",
      fontSize: 18.0);
}
