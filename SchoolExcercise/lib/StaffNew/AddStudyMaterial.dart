import 'package:flutter/material.dart';

class AssigningStudyMaterial extends StatefulWidget {
  AssigningStudyMaterial({Key key}) : super(key: key);

  @override
  _AssigningStudyMaterialState createState() => _AssigningStudyMaterialState();
}

class _AssigningStudyMaterialState extends State<AssigningStudyMaterial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Study Material"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextFormField(), // date
            Row(
              children: <Widget>[
                DropdownButton(items: null, onChanged: null),
                DropdownButton(items: null, onChanged: null),
              ],
            ),
            TextFormField(),
            TextFormField(),
            RaisedButton(child: Text("UPLOAD FILES"), onPressed: null),
            RaisedButton(child: Text("Assign"), onPressed: null)
          ],
        ),
      )),
    );
  }
}
