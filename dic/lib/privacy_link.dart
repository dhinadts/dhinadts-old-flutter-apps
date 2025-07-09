import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

// void main() {
//   runApp(new MyApp2());
// }

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var title = 'Webview Demo';
    return new Scaffold(
      // title: title,
      appBar: AppBar(
        title: Text("Privacy Policy"),
      ),/* 
      GradientAppBar(
        gradient: LinearGradient(colors: [Colors.black, Colors.white70]),

       // backgroundColorStart: Colors.black,
       // backgroundColorEnd: Colors.white70,
      ), */
      body: WebviewScaffold(
          url:  "https://www.nithra.mobi/privacy.php",

    ));
  }
}

