import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:school/main.dart';
import 'package:school/raaja/confirmlist.dart';
import 'package:toast/toast.dart';


import 'checkdesign.dart';


var temp = new List();
TextEditingController classC = new TextEditingController();
var classSectionID;

class StudentListMap extends StatefulWidget {
  @override
  AddStaffDetailsReg createState() {
    return new AddStaffDetailsReg();
  }
}

class AddStaffDetailsReg extends State<StudentListMap> {
  String isClassradio = "";
  int ict = 0;
  var listtt = new List();
  var searchTextController = new TextEditingController();
  ScrollController _scrollController = new ScrollController();
  int lastid = 0;
  List<Category> list = new List();
  Category products;

  var itemsClassSection1 = new List();
  var classSelection1, subjectSelection, staffSelection = new List();
  var clist = new List();

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

                        await filterAll(value.toUpperCase());
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
          new Expanded(
              child: new ListView(
            controller: _scrollController,
            padding: new EdgeInsets.symmetric(vertical: 8.0),
            children: list.map((Category product) {
              return new Cat_list_design(product);
            }).toList(),
          )),
          RaisedButton(
            onPressed: () async {
              print("idddcsi $classSectionID");
              print(clist.length);
              if (classSectionID != null) {
                if (temp.length != 0) {
                  confirmapi();
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Confirmlist()),
                  );
              /*    Dialog errorDialog = Dialog(
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(
                            10.0 * MediaQuery.of(context).devicePixelRatio))),
                    //this right here
                    child: Container(
                      *//*decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent])),*//*
                      height: ScreenUtil().setHeight(900),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(
                                3.0 * MediaQuery.of(context).devicePixelRatio),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Confirmation',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(
                                3.0 * MediaQuery.of(context).devicePixelRatio),
                            child: SizedBox(
                                child: Text(
                                    "${temp.length} Students are Selected for ${classC.text} Class to Press Ok to Confirm.")),
                          ),
                          Expanded(
                            child: clist.length != 0
                                ? ListView.builder(
                                    controller: _scrollController,
                                    padding: EdgeInsets.all(0.5),
                                    itemCount: clist.length,
                                    itemBuilder: (context, index) {
                                      if (index == clist.length) {
                                        return Center(
                                            child: Text(
                                          "No data",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ));
                                      } else {
                                        return GestureDetector(
                                          onTap: () async {},
                                          child: Card(
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.network(
                                                    clist[index]["profile"],
                                                    height: ScreenUtil()
                                                        .setHeight(200),
                                                    width: ScreenUtil()
                                                        .setWidth(200),
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Text(
                                                        '${clist[index]["view_txt"]}')),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  )
                                : Center(
                                    child: GestureDetector(
                                    onTap: () {
                                      setState(() {});

                                    },
                                    child: Text("No Profile Founds",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(
                                child: Text("Cancel",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0)),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                },
                              ),
                              RaisedButton(
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0),
                                ),
                                onPressed: () async {
                                  submitapi();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => errorDialog,
                    barrierDismissible: false,
                  );*/

                  /* Dialog errorDialog = Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0))),
                      child: Container(
                        height: 300.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              " ${temp
                                  .length} Students are Selected for ${classC
                                  .text} Class to Press Ok to Confirm ",
                              style: TextStyle(fontSize: 15),
                            ),
                            Row(
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () {
                                    confirmapi();
                                  },
                                  child: Text("ok"),
                                ),
                                RaisedButton(
                                  onPressed: () {},
                                  child: Text("Cancel"),
                                )
                              ],
                            )
                          ],
                        ),
                      ));
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) => errorDialog,
                    barrierDismissible: false,
                  );*/
                } else {
                  Toast.show("Choose Atleast 1 Student", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                }
              } else {
                Toast.show("Choose Class Section", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              }
            },
            child: Text("Submit"),
          )
        ],
      )),
    );
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
    print("eter $itemsClassSection1");
    print("rre ${itemsClassSection1.length}");
    // print(itemsClassSection1[1]["section"]);
  }

  Future<void> getclass() async {
    var url = 'http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php';

    var response = await http.post(url,
        body: jsonEncode({
          'action': 'get_class',
          "schoolid": schoolID,
        }));

    print(response.body);
    classSelection1 = json.decode(response.body);
    print("countrySelection :: $classSelection1");
    print(classSelection1[0]["class"]);

    setState(() {});
  }

  @override
  void initState() {
    
    super.initState();
    getclass();
    getapi();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        lastid = listtt.length;

        // getapi();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    temp.clear();
  }

  Future<void> getapi() async {
    // listtt.clear();
    list.clear();

    print("last id $lastid");
    var response = await http.post(
        "http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php",
        body: jsonEncode({
          'action': 'get_student_map_list',
          'schoolid': schoolID,
          'checkedid': temp,
          'limit': lastid,
          'search': "",
        }));

    print("reeeees ${response.body}");
    var abcd = json.decode(response.body);
//      print("ABCD $abcd");
    print("FIRST:::: $abcd");
    if (!abcd[0]["status"].toString().contains("Failed")) {
      listtt.addAll(abcd);
      setState(() {});
      cat();
      print("temp $temp");
    }
    print("FIRSTl:::: ${listtt.length}");
  }



  Future<void> confirmapi() async {
    //  list.clear();

    var response = await http.post(
        "http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php",
        body: jsonEncode({
          'action': 'get_confirm_list',
          'schoolid': schoolID,
          'confirm_ids': temp,
        }));

    print("reeeees ${response.body}");
    var abcd = json.decode(response.body);

    if (!abcd[0]["status"].toString().contains("Failed")) {
      clist.addAll(abcd);
      print("sucess");
      print("confirm $abcd");
      setState(() {});
    }
  }

  Future<List<Category>> cat() async {
    for (int i = 0; i < listtt.length; i++) {
      String studentid = listtt[i]['studentid'];
      String schoolid = listtt[i]['schoolid'];
      String view_txt = listtt[i]['view_txt'];
      String profile = listtt[i]['profile'];
      bool is_checked = listtt[i]['is_checked'];

      print("get set $schoolid , $studentid");

      list.add(new Category(
        studentid: studentid,
        schoolid: schoolid,
        view_txt: view_txt,
        profile: profile,
        is_checked: is_checked,
      ));
    }

    /*setState(() {
      list.map((Category product) {
        Cat_list_design(product);
      }).toList();
    });*/
  }

  Future<void> searchapi(String value) async {
    String cat_id = "0";
    for (Category p in list) {
      if (p.is_checked) {
        print(p.studentid);
        cat_id = "$cat_id,${p.studentid}";
      }
    }
    print("c  $cat_id");

    if (cat_id.length == 0) {
    } else {
      if (cat_id.startsWith(",")) {
        String ind = cat_id.replaceFirst(",", "");

        print("checking $ind");
        cat_id = ind;
        //condition1 = condition.length() - 1;
      }
    }
    print("c2  $cat_id");

    listtt.clear();
    list.clear();

    var response = await http.post(
        "http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php",
        body: jsonEncode({
          'action': 'get_student_map_list',
          'schoolid': schoolID,
          'checkedid': temp,
          // 'limit': listtt.length,
          'search': "${searchTextController.text}",
        }));

    print("reeeees ${response}");
    var abcd = json.decode(response.body);
//      print("ABCD $abcd");
    print("FIRST:::: ${abcd}");
    if (!abcd[0]["status"].toString().contains("Failed")) {
      /*for (var i = 0; i < listtt.length; i++) {
        for (var j = 0; j < temp.length; j++) {
          if (listtt[i]["studentid"] == temp[j]) {
            print("${listtt[i]["studentid"]}");
            products.set_is_checked=true;
          }
        }
      }*/
      listtt.addAll(abcd);
      setState(() {});
      cat();
      print("temp $temp");
    }
  }
}

class Category {
  String studentid;
  String schoolid;
  String view_txt;
  String profile;
  bool is_checked;

  Category(
      {String studentid,
      String schoolid,
      String view_txt,
      String profile,
      bool is_checked}) {
    this.studentid = studentid;
    this.schoolid = schoolid;
    this.view_txt = view_txt;
    this.profile = profile;
    this.is_checked = is_checked;
  }

  set set_is_checked(bool is_checked) {
    this.is_checked = is_checked;
  }
}
