import 'package:flutter/material.dart';
import 'package:school/ScreenUtil.dart';
import 'package:school/StaffNew/MapStudentWithClasses.dart';
import 'package:school/StaffNew/ViewStudents.dart';

class StudentMapView extends StatefulWidget {
  StudentMapView({Key key}) : super(key: key);

  @override
  _StudentMapViewState createState() => _StudentMapViewState();
}

class _StudentMapViewState extends State<StudentMapView> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: AppBar(
           title: Text("Student Map & View")
         ),
         body : SafeArea(
           child: Row(children: <Widget>[
             GestureDetector(
                  onTap: () async {
                   
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MapStudentWithClasses()),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                             Image.asset(
                                "assets/vuas.png",
                                height: ScreenUtil().setHeight(170),
                                width: ScreenUtil().setWidth(170),
                              ),
                            
                            Text(
                              "Map Student with Classes",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
                      MaterialPageRoute(
                          builder: (context) => ViewStudents()),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Image.asset(
                                "assets/vuas.png",
                                height: ScreenUtil().setHeight(170),
                                width: ScreenUtil().setWidth(170),
                              
                            ),
                            Text(
                              "View Students",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
           ],))
       ),
    );
  }
}