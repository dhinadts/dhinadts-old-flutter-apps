import 'package:animated/introSLides.dart';
import 'package:animated/loginPage.dart';
import 'package:animated/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenSample extends StatefulWidget {
  SplashScreenSample({Key key}) : super(key: key);

  @override
  _SplashScreenSampleState createState() => _SplashScreenSampleState();
}

class _SplashScreenSampleState extends State<SplashScreenSample> {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();
  bool setImage = true;

  @override
  void initState() {
    super.initState();
    fn();
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        setImage = false;
      });
    });
  }

  fn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiToken = prefs.getString("apiToken");
    companyID = prefs.getInt("companyID");
    domain = prefs.getString("domain");
    loggedName = prefs.getString("LoggedName");
    loggedIN = prefs.getInt("LoggedIN");
    introSlide = prefs.getInt("IntroSlides");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return introSlide == null ? INtroSlides()  : (setImage == true
        ? new Scaffold(
            key: globalScaffoldKey,
            body: Container(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/screenshot.gif",
                  gaplessPlayback: true,
                )))
        : (loggedIN == null ? LoginScreen() : MyHomePage(index: 0)));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
