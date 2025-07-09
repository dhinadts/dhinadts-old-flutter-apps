import 'package:flutter/material.dart';
import 'package:school/ScreenUtil.dart';
import 'package:school/StaffNew/AssigningHomeWork.dart';
import 'package:school/StaffNew/EvaluteHomeWork.dart';

class HomeWork extends StatefulWidget {
  HomeWork({Key key}) : super(key: key);

  @override
  _HomeWorkState createState() => _HomeWorkState();
}

class _HomeWorkState extends State<HomeWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Homework")),
        body: SafeArea(
            child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AssigningHomeWork()),
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
                          "Map Student with Classes",
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
                  MaterialPageRoute(builder: (context) => EvaluteHomeWork()),
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
                          "View Students",
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
