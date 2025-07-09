import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';



class ViewSchollProfile extends StatefulWidget {
  final String viewLink;
  const ViewSchollProfile({Key key, @required this.viewLink}) : super(key: key);

  @override
  _ViewSchollProfileState createState() => _ViewSchollProfileState();
}

class _ViewSchollProfileState extends State<ViewSchollProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebviewScaffold(
    url: this.widget.viewLink,
    initialChild: Center(child: CircularProgressIndicator()),
    withJavascript: true, 
    withZoom: false, 
    appBar: AppBar(
      elevation: 1
    ),
      ),
    );
  }
}