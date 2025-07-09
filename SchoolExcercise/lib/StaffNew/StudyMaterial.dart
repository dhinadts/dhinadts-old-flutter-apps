import 'package:flutter/material.dart';
import 'package:school/ScreenUtil.dart';
import 'package:school/StaffNew/ProvidingStudyMaterial.dart';
import 'package:school/StaffNew/ViewStudyMaterial.dart';

class StudyMaterial extends StatefulWidget {
  StudyMaterial({Key key}) : super(key: key);

  @override
  _StudyMaterialState createState() => _StudyMaterialState();
}

class _StudyMaterialState extends State<StudyMaterial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Study Material")),
        body: SafeArea(
            child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProvidingStudyMaterial()),
                );
              },
              child: SizedBox(
                height: ScreenUtil().setHeight(450),
                width: ScreenUtil().setWidth(500),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Color(0xFFFFBA31),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/vuas.png",
                            height: ScreenUtil().setHeight(170),
                            width: ScreenUtil().setWidth(170),
                          ),
                        ),
                        Text(
                          "Add Study Material",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewStudyMaterial()),
                );
              },
              child: SizedBox(
                height: ScreenUtil().setHeight(450),
                width: ScreenUtil().setWidth(500),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Color(0xFFFFBA31),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/vuas.png",
                            height: ScreenUtil().setHeight(170),
                            width: ScreenUtil().setWidth(170),
                          ),
                        ),
                        Text(
                          "View Study Material",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}