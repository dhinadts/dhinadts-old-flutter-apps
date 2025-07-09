import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:school/main.dart';

class ViewNoticeBoard extends StatefulWidget {
  ViewNoticeBoard({Key key}) : super(key: key);

  @override
  _ViewNoticeBoardState createState() => _ViewNoticeBoardState();
}

class _ViewNoticeBoardState extends State<ViewNoticeBoard> {
  TextEditingController seachNotice = new TextEditingController();
  var searchedItem = new List();
  @override
  void initState() {
    super.initState();
    defaultFn();
  }

  @override
  void dispose() {
    super.dispose();
    searchedItem.clear();
  }

  defaultFn() async {
    var url = "http://13.127.33.107/upload/dhanraj/homework/api/android.php";
    Dio dio = new Dio();
    Response response;

    FormData formData = new FormData.fromMap({
      "action": "get_notice_board",
      "schoolid": "$schoolID", // .toString(),
      // "staffid": "$staffID", // .toString(),
      "acyid": "$academicYear", // .toString(),
      // "classid": "$classIDConfirm"
      "type": "2"
    });
    response = await dio.post(url, data: formData);
    print('Response body: ${response.data}');
    noticeBoardList = jsonDecode(response.data);
    print(noticeBoardList);

    setState(() {});
  }

  var noticeBoardList = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("View Notice Board")),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: seachNotice,
                decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                ),
                onChanged: (String value) {
                  if (noticeBoardList == null) {
                  } else {
                    for (var i = 0; i < noticeBoardList.length; i++) {
                      /* if (noticeBoardList[i]["title"].contains(value) ||
                          noticeBoardList[i]["description"].contains(value)) { */
                      if (value == noticeBoardList[i]["title"] ||
                          value == noticeBoardList[i]["description"]) {
                        searchedItem.add(noticeBoardList[i]);
                      }
                    }
                  }
                  setState(() {});
                },
              ),
              searchedItem == null
                  ? SizedBox()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchedItem.length,
                      itemBuilder: (context, i) {
                        return Expanded(
                            child: Card(
                                child: Text("${searchedItem[i]["title"]}")));
                      }),
              noticeBoardList == null
                  ? SizedBox()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: noticeBoardList.length,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Card(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "Title: ${noticeBoardList[i]["title"]}",
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "Description: ${noticeBoardList[i]["description"]}",
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "Start Date: ${noticeBoardList[i]["startdate"]}",
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "End Date: ${noticeBoardList[i]["enddate"]}",
                                  textAlign: TextAlign.left,
                                ),
                                RaisedButton(
                                    child: Text("EDIT"), onPressed: () {}),
                              ]),
                        );
                      }),
            ],
          ),
        )));
  }
}
