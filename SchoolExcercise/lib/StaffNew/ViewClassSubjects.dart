import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:school/main.dart';
import 'package:school/staffdashboard.dart';

class ViewCLassSubjects extends StatefulWidget {
  ViewCLassSubjects({Key key}) : super(key: key);

  @override
  _ViewCLassSubjectsState createState() => _ViewCLassSubjectsState();
}

class _ViewCLassSubjectsState extends State<ViewCLassSubjects> {
  @override
  void initState() {
    super.initState();
    displayList();
  }

  displayList() async {
    var url = "http://13.127.33.107/upload/dhanraj/homework/api/staffapi.php";
    Dio dio = new Dio();
    Response response;
    FormData formData = new FormData.fromMap({
      "action": "view_class_sub",
      "schoolid": schoolID.toString(),
      "staffid": staffID.toString(),
      "acyid": academicYear.toString(),
    });

    response = await dio.post(url, data: formData);
    print('Response body: ${response.data}');
    displayListItem = jsonDecode(response.data);
    print('temp: $displayListItem');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text("View Class & Subjects")),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Text("CLASS",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center)),
              Expanded(
                  flex: 1,
                  child: Text("SECTION",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center)),
              Expanded(
                  flex: 1,
                  child: Text("SUBJECT",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center)),
            ],
          ),
          Divider(),
          displayListItem == null
              ? SizedBox()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: displayListItem.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: Text("${displayListItem[i]["class"]}",
                                    // style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center)),
                            Expanded(
                                flex: 1,
                                child: Text("${displayListItem[i]["section"]}",
                                    // style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center)),
                            Expanded(
                                flex: 1,
                                child: Text("${displayListItem[i]["subjects"]}",
                                    // style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center)),
                          ],
                        ),
                        Divider()
                      ],
                    );
                  })
        ]))),
      ),
    );
  }
}
