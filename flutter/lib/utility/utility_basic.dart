import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import '../feedback_ex.dart';
// import '../main.dart';


class Utility_Basic {
  void versions() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionName = packageInfo.version;
    versionCode = packageInfo.buildNumber;
  }

  void toastfun(String ss) {
    Fluttertoast.showToast(
        msg: "" + ss,
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.white,
        backgroundColor: Colors.black,
        gravity: ToastGravity.CENTER);
  }

  void more_fun() async {
    const url = 'https://play.google.com/store/apps/developer?id=Nithra';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void rate_app() async {
    // LaunchReview.launch(androidAppId: "ml.naanyaru.second",
/*  LaunchReview.launch(
      androidAppId: "nithra.tamil.gk.quiz.pothuarivu.vinadi.vina",
      iOSAppId: "");*/

    const url =
        'https://play.google.com/store/apps/details?id=nithra.tamil.gk.quiz.pothuarivu.vinadi.vina';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
