/* import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:school/adminDashBoard.dart';

import 'package:school/db/utility_basics.dart';
import 'package:school/main.dart';

import 'ScreenUtil.dart';
import 'package:http/http.dart' as http;

var utilitybasic = Utility_Basic();

class MappingStudentsWIthClass extends StatefulWidget {
  @override
  MappingStudentsWIthClassReg createState() {
    return new MappingStudentsWIthClassReg();
  }
}

class MappingStudentsWIthClassReg extends State<MappingStudentsWIthClass> {
  
  
  TextEditingController classC = new TextEditingController();
  TextEditingController sectionsC = new TextEditingController();
  var itemSubject = new List();
    var selectedValues1 = new List();



    @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

searchInitial() async {
    var url = 'http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php';

    var response = await http.post(url,
        body: jsonEncode({
          'action': 'get_class',
          "schoolid": schoolID,
        }));

    print(response.body);
    classSelection = json.decode(response.body);
    print("countrySelection :: $classSelection");
    print(classSelection[0]["class"]);

    var response2 = await http.post(url,
        body: jsonEncode({
          'action': 'get_student',
          "schoolid": schoolID,
        }));
    print(response2.body);
    staffSelection = json.decode(response2.body);
    print("staffSelection :: $staffSelection");
    print(staffSelection[0]["sid"]);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Mapping Students WIth Class",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: ScreenUtil().setSp(60)),
        ),
      ),
      body: Container(
        color: appcolor,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              /* Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Add Class & Sections",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(60)),
                ),
              ), */
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Text(
                          "Academic Year",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    /* Container(decoration: BoxDecoration()),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "From :",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: fromAcadYear,
                                decoration: InputDecoration(
                                  hintText: "dd/yyyy",
                                ),
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "To :",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: toAcadYear,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "dd/yyyy",
                                ),
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ), */
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Class - Section: ",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: classC,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Students: ",
                                style: TextStyle(fontSize: 20),
                              )),
                           Expanded(
                              flex: 1,
                              child: MultiSelect(
                                    autovalidate: false,
                                    titleText: "subject",
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select one or more option(s)';
                                      }
                                    },
                                    errorText:
                                        'Please select one or more option(s)',
                                    dataSource: itemSubject,
                                    textField: 'subject',
                                    valueField: 'id',
                                    filterable: true,
                                    required: true,
                                    value: null,
                                    onSaved: (value) {},
                                    change: (values) {
                                      selectedValues1 = values;
                                      print(selectedValues1);
                                    },
                                  ),) 
                        ],
                      ),
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
                                  var response = await http.post(
                                      "http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php",
                                      body: jsonEncode({
                                        "action": "add_academic_year",
                                        "schoolid": schoolID,
                                        "afrom": "2020-05",
                                        "ato": "2021-05",
                                      }));

                                  print(
                                      'Response status: ${response.statusCode}');
                                  print('Response body: ${response.body}');
                                  var temp = json.decode(response.body);
                                  print('temp: $temp');
                                  print("status");
                                  utilitybasic.toastfun(temp[0]["status"]);
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdminDashBoard()),
                                  );
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
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ButtonTheme(
                        minWidth: ScreenUtil().setWidth(400),
                        height: ScreenUtil().setHeight(130),
                        child: RaisedButton(
                          onPressed: () async {},
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          color: appcolor,
                          child: Text(
                            "  View  ",
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
          ),
        ),
      ),
    );
  }
}
 */