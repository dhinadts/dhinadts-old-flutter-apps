import 'package:flutter/material.dart';

class AddGeneral extends StatefulWidget {
  AddGeneral({Key key}) : super(key: key);

  @override
  _AddGeneralState createState() => _AddGeneralState();
}

class _AddGeneralState extends State<AddGeneral> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add General"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextFormField(), // date
            TextFormField(),
            Text("Image"),
            RaisedButton(
                child: Text("SELECT CLASS & SECTION"), onPressed: null),
            Row(
              children: <Widget>[
                Text("START DATE"),
                Text("END DATE"),
              ],
            ),
            RaisedButton(child: Text("SAVE"), onPressed: null),
            
          ],
        ),
      )),
    );
  }
}
