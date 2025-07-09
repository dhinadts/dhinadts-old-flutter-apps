import 'package:flutter/material.dart';

class ViewGeneral extends StatefulWidget {
  ViewGeneral({Key key}) : super(key: key);

  @override
  _ViewGeneralState createState() => _ViewGeneralState();
}

class _ViewGeneralState extends State<ViewGeneral> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(title: Text("View Notice Board")),
body: SafeArea(child: Column(children: <Widget>[
  
  Text("Date"),

],))

    );
  }
}