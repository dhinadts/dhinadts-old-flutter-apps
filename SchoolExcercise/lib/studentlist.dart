import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'ScreenUtil.dart';

class StudentList extends StatefulWidget {
  @override
  AddStaffDetailsReg createState() {
    return new AddStaffDetailsReg();
  }
}

class AddStaffDetailsReg extends State<StudentList> {
  String isClassradio = "";
  int ict = 0;
  var listtt = new List();
  var searchTextController = new TextEditingController();
  ScrollController _scrollController = new ScrollController();
  int lastid =0;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 18.0, left: 18.0, right: 18.0, bottom: 8.0),
                child: TextField(
                  onChanged: (value) {
                    searchTextController.text = value;
                    searchTextController.selection = TextSelection.fromPosition(
                        TextPosition(offset: searchTextController.text.length));
                    searchapi(value);

                    print(
                        'searchTextController.text:: ${searchTextController.text}');
                    print("value:: $value");
                  },
                  controller: new TextEditingController.fromValue(
                      new TextEditingValue(
                          text: searchTextController.text,
                          selection: new TextSelection.collapsed(
                              offset: searchTextController.text.length))),
                  style: TextStyle(),
                  decoration: InputDecoration(
                    hintText: "Search ",
                  ),
                ),
              ),
              Expanded(
                child: listtt.length != 0
                    ? ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.all(0.5),
                  itemCount: listtt.length,
                  itemBuilder: (context, index) {
                    if (index == listtt.length) {
                      return Center(
                          child: Text(
                            "No data",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ));
                    } else {
                      return GestureDetector(
                        onTap: () async {

                        },
                        child: Card(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  listtt[index]["profile"],
                                  height: ScreenUtil().setHeight(200),
                                  width: ScreenUtil().setWidth(200),
                                ),
                              ),
                              Expanded(
                                  child: Text('${listtt[index]["view_txt"]}')),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  FlatButton(
                                    color: Color(0xFFDFFAE8),
                                    textColor: Color(0xFF24C38A),
                                    child: Text(
                                      "  Edit  ",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: ScreenUtil().setSp(30)),
                                    ), onPressed: () {},
                                  ),
                                  /*RaisedButton(
                                      onPressed: () async {},
                                      color: Colors.black12,
                                      child: Text(
                                        "  Edit  ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: ScreenUtil().setSp(25)),
                                      ),
                                    ),*/


                                  FlatButton(
                                    color: Color(0xFFFCE9E9),

                                    child: Text(
                                      "  View  ",
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: ScreenUtil().setSp(30)),
                                    ), onPressed: () {},
                                  ),
                                  /* RaisedButton(
                                      onPressed: () async {},
                                      color: Colors.black12,
                                      child: Text(
                                        "  View  ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: ScreenUtil().setSp(25)),
                                      ),
                                    ),*/
                                  //Text("Edit"),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                )
                    : Center(
                    child: Text("No Profile Founds",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
              ),
            ],
          )),
    );
  }

  @override
  void initState() {
    
    super.initState();

    getapi();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        lastid=listtt.length;

        getapi();


      }
    });
  }

  Future<void> getapi() async {
    var response = await http.post(
        "http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php",
        body: jsonEncode({
          'action': 'student_list',
          'schoolid': 2,
          'limit': lastid,
          'search': "",
        }));

    print("reeeees $response");
    var abcd = json.decode(response.body);
//      print("ABCD $abcd");
    print("FIRST:::: $abcd");
    if(!abcd[0]["status"].toString().contains("Failed")){
      listtt.addAll(abcd);
    }    print("FIRSTl:::: ${listtt.length}");

    setState(() {});
  }

  Future<void> searchapi(String value) async {
    listtt.clear();
    var response = await http.post(
        "http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php",
        body: jsonEncode({
          'action': 'student_list',
          'schoolid': 2,
          'limit': listtt.length,
          'search': "${searchTextController.text}",
        }));

    print("reeeees $response");
    var abcd = json.decode(response.body);
//      print("ABCD $abcd");
    print("FIRST:::: $abcd");
    if(!abcd[0]["status"].toString().contains("Failed")){
      listtt.addAll(abcd);
    }

    setState(() {});
  }
}
