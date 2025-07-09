import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:school/ScreenUtil.dart';
import 'package:school/main.dart';

class ViewStaffAdmin extends StatefulWidget {
  ViewStaffAdmin({Key key}) : super(key: key);

  @override
  _ViewStaffAdminState createState() => _ViewStaffAdminState();
}

var url = 'http://13.127.33.107/upload/dhanraj/homework/api/android.php';
var staffList = new List();

class _ViewStaffAdminState extends State<ViewStaffAdmin> {
  @override
  void initState() {
    super.initState();
  getList();
  }

  getList() async {
    FormData formData =
        new FormData.fromMap({"action": "staff_list", "schoolid": 2});
    Response response;
    Dio dio = new Dio();
    response = await dio.post(url, data: formData);
    print('Response body: ${response.data}');
    staffList = jsonDecode(response.data);
    print('temp: $staffList');
    print("status");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('View/Update - Admin/Teacher'),
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            tabs: [
              Tab(
                  child: Container(
                      height: 80,
                      width: 200,
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          border: new Border.all(
                              style: BorderStyle.solid, color: Colors.black45),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text("Teacher",
                              style: TextStyle(color: Colors.black))))

                  // icon: Icon(Icons.directions_car),
                  ),
              Tab(
                  // text: "பொருள்", // icon: Icon(Icons.directions_transit)
                  child: Container(
                      height: 80,
                      width: 200,
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          border: new Border.all(
                              style: BorderStyle.solid, color: Colors.black45),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text("Admin",
                              style: TextStyle(color: Colors.black))))

                  // icon: Icon(Icons.directions_car),
                  ),
              Tab(
                  // text: "இன்பம்", // icon: Icon(Icons.directions_bike)
                  child: Container(
                      height: 80,
                      width: 200,
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          border: new Border.all(
                              style: BorderStyle.solid, color: Colors.black45),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text("Inactive",
                              style: TextStyle(color: Colors.black))))

                  // icon: Icon(Icons.directions_car),
                  ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SearchableListTabs(
              whoisthis: 1,
            ),
            SearchableListTabs(
              whoisthis: 1,
            ),
            SearchableListTabs(
              whoisthis: 1,
            ),
          ],
        ),
      ),
    );
  }
}

var searchdList = new List();

class SearchableListTabs extends StatefulWidget {
  final int whoisthis;
  SearchableListTabs({Key key, @required this.whoisthis}) : super(key: key);

  @override
  _SearchableListTabsState createState() => _SearchableListTabsState();
}

class _SearchableListTabsState extends State<SearchableListTabs> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              /* Expanded(flex: 1, child: Icon(Icons.search)), */
              Expanded(
                flex: 2,
                child: TextField(
                  keyboardType: TextInputType.datetime,
                  style: TextStyle(fontSize: 20, height: 1.5),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: appcolor),
                    ),
                    hintText: "Enter Name or phone",
                    contentPadding: EdgeInsets.all(8.0),
                    suffix: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          staffList.length == 0
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: staffList.length,
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, i) {
                    return Card(
                      child: Container(
                          height: 130,
                          width: ScreenUtil().setWidth(100),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Icon(Icons.image),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text("Name:"),
                                          Text("${staffList[i]["name"]}")
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text("Mobile:"),
                                          Text("${staffList[i]["mobile"]}")
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text("Email:"),
                                          Text("${staffList[i]["email"]}")
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text("Gender:"),
                                          Text("Male")
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text("DOB:"),
                                          Text("01/01/2020")
                                        ],
                                      )
                                    ]),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  isActivated
                                      ? Text("Active",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))
                                      : Text("Inactive"),
                                  Switch(
                                    value: isActivated,
                                    onChanged: (value) {
                                      setState(() {
                                        isActivated = value;
                                        print(isActivated);
                                      });
                                    },
                                    activeTrackColor: Colors.lightBlueAccent,
                                    activeColor: Colors.lightBlueAccent,
                                  ),
                                  Icon(
                                    Icons.remove_red_eye,
                                  ),
                                  Icon(Icons.edit),
                                ],
                              )
                            ],
                          )),
                    );
                  })
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, i) {
                    return Card(
                      child: Text("$i"),
                    );
                  }),
        ],
      ),
    );
  }
}

bool isActivated = false;
