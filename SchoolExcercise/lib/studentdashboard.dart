import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school/notiBoardStudent.dart';

import 'ScreenUtil.dart';

class StudentDashboard extends StatefulWidget {
  @override
  StudentDashboardDetails createState() {
    return new StudentDashboardDetails();
  }
}

class StudentDashboardDetails extends State<StudentDashboard> {
  String isClassradio = "";
  int ict = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Dashboard"),
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () async {
              /* await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notificationactivity()),
              );*/
            },
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {},
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
                                  "View / Download",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(450),
                      width: ScreenUtil().setWidth(500),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Color(0xFF036EE4),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.asset(
                                "assets/viewhomework.png",
                                height: ScreenUtil().setHeight(170),
                                width: ScreenUtil().setWidth(170),
                              ),
                              Text("View Homework",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {},
                      child: SizedBox(
                        height: ScreenUtil().setHeight(450),
                        width: ScreenUtil().setWidth(500),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Color(0xFFED5751),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    "assets/submithomework.png",
                                    height: ScreenUtil().setHeight(170),
                                    width: ScreenUtil().setWidth(170),
                                  ),
                                ),
                                Text(
                                  "Submit Homework",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
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
                              builder: (context) => NotificationBoardStudent()),
                        );
                      },
                      child: SizedBox(
                        height: ScreenUtil().setHeight(450),
                        width: ScreenUtil().setWidth(500),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Color(0xFF20CB9C),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image.asset(
                                  "assets/noticeboard.png",
                                  height: ScreenUtil().setHeight(170),
                                  width: ScreenUtil().setWidth(170),
                                ),
                                Text("Notice Board",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Color(0xFF7D75FC),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Image.asset(
                              "assets/chatimg.png",
                              height: ScreenUtil().setHeight(170),
                              width: ScreenUtil().setWidth(170),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text("Chat",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
