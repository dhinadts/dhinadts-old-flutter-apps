/* import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school/main.dart';

import 'ScreenUtil.dart';
import 'addstaff.dart';

class AdminDashboard extends StatefulWidget {
  @override
  AdminDashboardDetails createState() {
    return new AdminDashboardDetails();
  }
}

class AdminDashboardDetails extends State<AdminDashboard> {
  String isClassradio = "";
  int ict = 0;


  @override
  void initState() {
    
    super.initState();
getLoggedIn();
  }

  getLoggedIn() async {
    loggedIn = await prefs.getInt("LoggedIn");
    print(loggedIn);
    setState(() {});
    // lastId = await prefs.getInt("lastID");
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollViewController;
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
          padding: const EdgeInsets.only(top:10.0),
          child: SingleChildScrollView(

            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddStaffDetails()),
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
                                  "Add Admin / Staff",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
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
                                "assets/vuas.png",
                                height: ScreenUtil().setHeight(170),
                                width: ScreenUtil().setWidth(170),
                              ),
                              Text("View / Update \nAdmin - Staff",
                                  style: TextStyle(color: Colors.white, fontSize: 20))
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
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddStaffDetails()),
                        );
                      },
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
                                    "assets/acs.png",
                                    height: ScreenUtil().setHeight(170),
                                    width: ScreenUtil().setWidth(170),
                                  ),
                                ),
                                Text(
                                  "Add Class & Sections",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontSize: 20),
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
                        color: Color(0xFF20CB9C),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.asset(
                                "assets/vusp.png",
                                height: ScreenUtil().setHeight(170),
                                width: ScreenUtil().setWidth(170),
                              ),
                              Text("View / Update \nSchool Profile",
                                  style: TextStyle(color: Colors.white, fontSize: 20))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
 */