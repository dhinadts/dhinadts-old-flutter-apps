import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ViewPrivacyPolicy extends StatelessWidget {
  final String viewLink;
  final int sett;
  const ViewPrivacyPolicy({
    Key key,
    @required this.viewLink,
    @required this.sett,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Transform.translate(
              offset: Offset(-20, 0),
              child: Text(this.sett == 1 ? "Privacy Policy" : "Security",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: "Gilory-Medium",
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
          ],
        ),
        iconTheme: new IconThemeData(
          color: Colors.black87,
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 20.0),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        color: Colors.white,
        child: WebviewScaffold(
            url: this.viewLink,
            withJavascript: true,
            withZoom: true,
            hidden: true),
      ),
    );
  }
}
