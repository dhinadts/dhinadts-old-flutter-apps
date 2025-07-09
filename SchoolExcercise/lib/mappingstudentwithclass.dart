/* import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school/db/utility_basics.dart';
import 'package:school/main.dart';
import 'package:http/http.dart' as http;

import 'ScreenUtil.dart';
import 'otpverify.dart';
import 'staffdashboard.dart';

class MappingStudentsWIthClass1 extends StatefulWidget {
  @override
  MappingStudentsWIthClass1Reg createState() {
    return new MappingStudentsWIthClass1Reg();
  }
}

class MappingStudentsWIthClass1Reg extends State<MappingStudentsWIthClass1> {
  String isClassradio = "";
  int ict = 0;
  var listtt = new List();

  var searchTextController = new TextEditingController();
  ScrollController _scrollController = new ScrollController();
  int lastid = 0;
  TextEditingController classC = new TextEditingController();
  var utilitybasic = Utility_Basic();

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollViewController;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("MappingStudentsWIthClass"),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Text(
                      "Class -Section:",
                      style: TextStyle(fontSize: 20),
                    )),
                Expanded(
                    flex: 1,
                    child: TextField(
                      controller: new TextEditingController.fromValue(
                          new TextEditingValue(
                              text: classC.text,
                              selection: new TextSelection.collapsed(
                                  offset: classC.text.length))),
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 18),
                      onChanged: (value) async {
                        classC.text = value;
                        itemsClassSection1.clear();

                        await filterAll(value);
                        setState(() {});
                      },
                    ))
              ],
            ),
          ),
          itemsClassSection1.length != 0
              ? Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Text(
                            "",
                            style: TextStyle(fontSize: 20),
                          )),
                      Expanded(
                          flex: 1,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: itemsClassSection1.length,
                              itemBuilder: (context, i) {
                                return GestureDetector(
                                    child: ListTile(
                                      title: Text(
                                          "${itemsClassSection1[i]["class"]}-${itemsClassSection1[i]["section"]}"),
                                    ),
                                    onTap: () async {
                                      classC.text =
                                          "${itemsClassSection1[i]["class"]}-${itemsClassSection1[i]["section"]}";
                                      classSectionID =
                                          itemsClassSection1[i]["id"];
                                      setState(() {
                                        itemsClassSection1.clear();
                                      });
                                      print(classSectionID);
                                    });
                              }))
                    ],
                  ),
                )
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Select Students",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: (TextAlign.left)),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 18.0, left: 18.0, right: 18.0, bottom: 8.0),
            child: TextField(
              onChanged: (value) async {
                searchTextController.text = value;
                searchTextController.selection = TextSelection.fromPosition(
                    TextPosition(offset: searchTextController.text.length));

                
                if (value.isEmpty) {
                  listtt.clear();
                  getapi();
                  setState(() {});
                } else {
                  listtt.clear();
                  await searchapi(value);
                }

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
                            setState(() {
                              checkBoxArray[index]["chackBool"] =
                                  !checkBoxArray[index]["chackBool"];
                            });

                            if (checkBoxArray[index]["checkValue"] == true) {
                              setState(() {
                                checkBoxArray[index]["chackBool"] = true;
                                checkBoxArray[index]["checkValue"] = 1;
                              });
                            } else {
                              setState(() {
                                checkBoxArray[index]["chackBool"] = false;
                                checkBoxArray[index]["checkValue"] = 0;
                              });
                            }
                            print(checkBoxArray);
                            setState(() {
                              listtt.clear();
                            });
                          },
                          child: Card(
                            child: ListTile(
                              leading: Image.network(
                                    listtt[index]["profile"],
                                    height: ScreenUtil().setHeight(200),
                                    width: ScreenUtil().setWidth(200),
                                  ),
                                  title: Text("${listtt[index]["view_txt"]}"),
                                  trailing:Checkbox(
                                      value: checkBoxArray[index]["chackBool"],
                                      onChanged: (value) async {
                                        if (value == true) {
                                          setState(() {
                                            checkBoxArray[index]["chackBool"] =
                                                true;
                                            checkBoxArray[index]["checkValue"] =
                                                1;
                                          });
                                        } else {
                                          setState(() {
                                            checkBoxArray[index]["chackBool"] =
                                                false;
                                            checkBoxArray[index]["checkValue"] =
                                                0;
                                          });
                                        }
                                        print(checkBoxArray);
                                      }),

                            ),
                            
                            /* Row(
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
                                Expanded(
                                  flex: 1,
                                  child: Checkbox(
                                      value: checkBoxArray[index]["chackBool"],
                                      onChanged: (value) async {
                                        if (value == true) {
                                          setState(() {
                                            checkBoxArray[index]["chackBool"] =
                                                true;
                                            checkBoxArray[index]["checkValue"] =
                                                1;
                                          });
                                        } else {
                                          setState(() {
                                            checkBoxArray[index]["chackBool"] =
                                                false;
                                            checkBoxArray[index]["checkValue"] =
                                                0;
                                          });
                                        }
                                        print(checkBoxArray);
                                      }),
                                ),
                              ],
                            ), */
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
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ButtonTheme(
                    minWidth: ScreenUtil().setWidth(400),
                    height: ScreenUtil().setHeight(130),
                    child: RaisedButton(
                      onPressed: () async {
                        classC.clear();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      color: appcolor,
                      child: Text(
                        "  CANCEL  ",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(50)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ButtonTheme(
                    minWidth: ScreenUtil().setWidth(400),
                    height: ScreenUtil().setHeight(130),
                    child: RaisedButton(
                      onPressed: () async {
                        var temp = checkBoxArray;
                        var items2 = new List();
                        for (var i = 0; i < temp.length; i++) {
                          if (temp[i]["chackBool"] == true) {
                            items2.add({
                              "stuID": temp[i]["stuID"],
                              "view_txt": temp[i]["view_txt"],
                              "profile": temp[i]["profile"]
                            });
                          }
                        }
                        print(items2);
                        Dialog errorDialog = Dialog(
                            child: Container(
                                height: 300.0,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: items2.length,
                                  itemBuilder: (context, i) {
                                    return Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.network(
                                            items2[i]["profile"],
                                            height: ScreenUtil().setHeight(200),
                                            width: ScreenUtil().setWidth(200),
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(
                                                '${items2[i]["view_txt"]}')),
                                      ],
                                    );
                                  },
                                )));
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) => errorDialog,
                          barrierDismissible: false,
                        );

                        /* var response = await http.post(
                                      "http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php",
                                      body: jsonEncode({
                                        "action": "mapp_staff_subject",
                                        "schoolid": 1, //schoolID,
                                        "mapclassid": classSectionID,
                                        "mapstaffid": [
                                          
                                        ],
                                        "mapsubjectid": [
                                         
                                        ],
                                        "mapis_classteacher": [
                                         
                                        ],
                                      }));

                                  print(
                                      'Response status: ${response.statusCode}');
                                  print('Response body: ${response.body}');
                                  var temp = json.decode(response.body);
                                  print('temp: $temp');
                                  print("status");
                                  utilitybasic.toastfun(temp[0]["status"]); */
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      color: appcolor,
                      child: Text(
                        "  SAVE  ",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(50)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // itemsClassSection.clear();
    listtt.clear();

    // query.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getclass();
    getapi();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        lastid = listtt.length;

        getapi();
      }
    });
  }

  var classSelection1, subjectSelection, staffSelection = new List();

  Future<void> getclass() async {
    var url = 'http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php';

    var response = await http.post(url,
        body: jsonEncode({
          'action': 'get_class',
          "schoolid": 1,
        }));

    print(response.body);
    classSelection1 = json.decode(response.body);
    print("countrySelection :: $classSelection1");
    print(classSelection1[0]["class"]);

    setState(() {});
  }

  filterAll(String value) {
    for (var i = 0; i < classSelection1.length; i++) {
      if (classSelection1[i]["class"] == value) {
        itemsClassSection1.add({
          "class": classSelection1[i]["class"],
          "section": classSelection1[i]["section"],
          "id": classSelection1[i]["id"]
        });
      }
    }

    setState(() {});
    print(itemsClassSection1);
    print(itemsClassSection1.length);
    print(itemsClassSection1[1]["section"]);
  }

  Future<void> getapi() async {
    

    var response = await http.post(
        "http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php",
        body: jsonEncode({
          'action': 'student_list',
          'schoolid': 1,
          'limit': lastid,
          'search': "",
        }));

    print("reeeees ${response}");
    var abcd = json.decode(response.body);
//      print("ABCD $abcd");
    print("FIRST:::: ${abcd}");
    if (!abcd[0]["status"].toString().contains("Failed")) {
      listtt.addAll(abcd);
      
    }
    print("FIRSTl:::: ${listtt.length}");
    for (var i = 0; i < abcd.length; i++) {
      checkBoxArray.add({
        "chackBool": false,
        "checkValue": 0,
        "stuID": abcd[i]["studentid"],
        "view_txt": abcd[i]["view_txt"],
        "profile": abcd[i]["profile"]
      });
    }
    setState(() {
        
      });
  }

  Future<void> searchapi(String value) async {
    listtt.clear();
    var response = await http.post(
        "http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php",
        body: jsonEncode({
          'action': 'student_list',
          'schoolid': 1,
          'limit': listtt.length,
          'search': "${searchTextController.text}",
        }));

    var abcd = json.decode(response.body);
//      print("ABCD $abcd");
    print("Secomd:::: ${abcd}");
    if (!abcd[0]["status"].toString().contains("Failed")) {
      listtt.addAll(abcd);
    }

    for (var i = 0; i < abcd.length; i++) {
      if (checkBoxArray[i]["checkValue"] == 1) {
        checkBoxArray.add({
          "chackBool": true,
          "checkValue": 1,
          "stuID": abcd[i]["studentid"],
          "view_txt": abcd[i]["view_txt"],
          "profile": abcd[i]["profile"]
        });
      }
    }

    setState(() {});
  }

  searchAPI(String value) {
    for (var i = 0; i < listtt.length; i++) {
      if (listtt[i]["view_txt"].toString().contains(value)) {}
    }
  }/*  */

  var itemsClassSection1 = new List();
  var checkBoxArray = new List();
 
  var classSectionID;
}
 */