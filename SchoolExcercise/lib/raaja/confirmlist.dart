import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school/ScreenUtil.dart';
import 'package:school/assignhomework.dart';
import 'package:http/http.dart' as http;
import 'package:school/main.dart';
import 'package:school/staffdashboard.dart';
import 'package:toast/toast.dart';

import 'studentlistmap.dart';

class Confirmlist extends StatefulWidget {
  @override
  AddStaffDetailsReg createState() {
    return new AddStaffDetailsReg();
  }
}

class AddStaffDetailsReg extends State<Confirmlist> {
  String isClassradio = "";
  int ict = 0;
  var listtt = new List();
  var searchTextController = new TextEditingController();
  ScrollController _scrollController = new ScrollController();
  int lastid = 0;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Confirmation List"),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "   ${temp.length} Students are Selected for ${classC.text} Class to Press Ok to Confirm.",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(40)),
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
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AssignHomework()),
                            );
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
                                    child:
                                        Text('${listtt[index]["view_txt"]}')),
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
          RaisedButton(
            onPressed: () async {
              submitapi();

              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StaffDashboard()),
              );
            },
            child: Text("Confirm"),
          )
        ],
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    getapi();
  }

  Future<void> getapi() async {
    var response = await http.post(
        "http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php",
        body: jsonEncode({
          'action': 'get_confirm_list',
          'schoolid': schoolID,
          'confirm_ids': temp,
        }));

    print("reeeees $response");
    var abcd = json.decode(response.body);
//      print("ABCD $abcd");
    print("FIRST:::: $abcd");
    if (!abcd[0]["status"].toString().contains("Failed")) {
      listtt.addAll(abcd);
    }
    print("FIRSTl:::: ${listtt.length}");

    setState(() {});
  }

  Future<void> submitapi() async {
    //list.clear();

    var response = await http.post(
        "http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php",
        body: jsonEncode({
          'action': 'mapp_student_class',
          'schoolid': schoolID,
          'checkedid': temp,
          'acyear': academicYear,
          'mapclassid': classSectionID,
        }));

    print("reeeees ${response.body}");
    var abcd = json.decode(response.body);
//      print("ABCD $abcd");
    print("FIRST:::: $abcd");
    if (!abcd[0]["status"].toString().contains("Failed")) {
      print("sucess");
      Toast.show("Submited ", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
}
