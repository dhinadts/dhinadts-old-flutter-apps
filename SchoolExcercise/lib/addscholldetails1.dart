/* import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school/adminDashBoard.dart';

import 'package:school/adminregister.dart';
import 'package:school/db/utility_basics.dart';
import 'package:school/main.dart';

import 'ScreenUtil.dart';
import 'otpverify.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

var utilitybasic = Utility_Basic();

TextEditingController schNameC = new TextEditingController();
TextEditingController regCodeC = new TextEditingController();
TextEditingController nameAdminC = new TextEditingController();
TextEditingController designationC = new TextEditingController();
TextEditingController emailAdminC = new TextEditingController();
TextEditingController mobileAdminC = new TextEditingController();
TextEditingController addressC = new TextEditingController();
TextEditingController cityC = new TextEditingController();
TextEditingController stateC = new TextEditingController();
TextEditingController distC = new TextEditingController();
TextEditingController countryC = new TextEditingController();

var countrySelected = "India";
bool countryS = false;
bool stateS = false;
bool cityS = false;
var countrySelected1 = "India";
var citySelected1 = "Tamil Nadu";
var stateSelected1 = 'Chennai';
var countrySelection = new List();
var countryID, stateID, cityID;

var items = new List();
var items1 = new List();
var items2 = new List();

var idItems = new List();
var codeItems = new List();
var dummyListData = List();
List cityDummy = List();
List stateDummy = List();
List ids = List();
List codes = List();

class AddSchoolDetails1 extends StatefulWidget {
  @override
  AddSchoolDetailsReg createState() {
    return new AddSchoolDetailsReg();
  }
}

class AddSchoolDetailsReg extends State<AddSchoolDetails1> {
  @override
  void initState() {
    super.initState();

    searchCountry();
  }

  @override
  void dispose() {
    super.dispose();
    items.clear();
    items1.clear();
    items2.clear();
    // query.clear();
  }

  searchCountry() async {
    // var url = "http://13.127.33.107//upload/dhanraj/homework/api/json.php";
    var url = 'http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php';

    var response = await http.post(url,
        body: jsonEncode({
          'action': 'get_master',
        }));

    print(response.body);
    countrySelection = json.decode(response.body);
    print("countrySelection :: $countrySelection");
    print(countrySelection[0]["state"][0]["state_name"]);

    for (int i = 0; i < countrySelection.length; i++) {
      dummyListData.add(countrySelection[i]["country_name"]);
    }
    setState(() {});
    // searchCity(countrySelected);
    // searchState(countrySelected1, citySelected1);
  }

  searchC(String value) {
    dummyListData.forEach((item) {
      if (item.startsWith(value.toUpperCase())) {
        items.add(item);
      }
    });

    setState(() {});
  }

  searchCity(String countrySelected1) async {
    for (var i = 0; i < countrySelection.length; i++) {
      if (countrySelection[i]["country_name"] == countrySelected1) {
        for (var j = 0; j < countrySelection[i]["state"].length; j++) {
          cityDummy.add(countrySelection[i]["state"][j]['state_name']);
        }
      }
    }
    setState(() {});
  }

  searchCityC(String value) {
    cityDummy.forEach((item) {
      if (item.startsWith(value.toUpperCase())) {
        items1.add(item);
      }
    });
    setState(() {});
  }

  searchState(String countrySelected1, String citySelected1) async {
    for (var i = 0; i < countrySelection.length; i++) {
      if (countrySelection[i]["country_name"] == countrySelected1) {
        for (var j = 0; j < countrySelection[i]["state"].length; j++) {
          if (countrySelection[i]["state"][j]['state_name'] == citySelected1) {
            for (var k = 0;
                k < countrySelection[i]["state"][j]['city'].length;
                k++) {
              stateDummy
                  .add(countrySelection[i]["state"][j]['city'][k]['city_name']);
            }
          }
        }
      }
    }
    setState(() {});
  }

  searchStateC(String value) {
    stateDummy.forEach((item) {
      if (item.startsWith(value.toUpperCase())) {
        items2.add(item);
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: dummyListData.length == 0
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: appcolor,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "Add School Details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(60)),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "School Name",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          Padding(
                            padding: EdgeInsets.only(left: 100.0),
                            child: Container(
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      new Border.all(style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextField(
                                    controller: schNameC,
                                    keyboardType: TextInputType.multiline,
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 18),
                                  )),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Registration Code",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          Padding(
                            padding: EdgeInsets.only(left: 100.0),
                            child: Container(
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      new Border.all(style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextField(
                                    controller: regCodeC,
                                    keyboardType: TextInputType.text,
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 18),
                                  )),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Enter your Name",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          Padding(
                            padding: EdgeInsets.only(left: 100.0),
                            child: Container(
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      new Border.all(style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextField(
                                    controller: nameAdminC,
                                    keyboardType: TextInputType.text,
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 18),
                                  )),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Designation",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          Padding(
                            padding: EdgeInsets.only(left: 100.0),
                            child: Container(
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      new Border.all(style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextField(
                                    controller: designationC,
                                    keyboardType: TextInputType.text,
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    maxLines: 1,
                                    style: TextStyle(fontSize: 18),
                                  )),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Email",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          Padding(
                            padding: EdgeInsets.only(left: 100.0),
                            child: Container(
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      new Border.all(style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextField(
                                    controller: emailAdminC,
                                    keyboardType: TextInputType.text,
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    maxLines: 1,
                                    style: TextStyle(fontSize: 18),
                                  )),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Mobile No",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          Padding(
                            padding: EdgeInsets.only(left: 100.0),
                            child: Container(
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      new Border.all(style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "+91",
                                        style: TextStyle(fontSize: 18),
                                      )),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextField(
                                        controller: mobileAdminC,
                                        keyboardType: TextInputType.number,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 18),
                                      )),
                                ),
                              ]),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Address",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          Padding(
                            padding: EdgeInsets.only(left: 100.0),
                            child: Container(
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      new Border.all(style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextField(
                                    controller: addressC,
                                    keyboardType: TextInputType.text,
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 18),
                                  )),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Country",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 100.0,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 50.0,
                                decoration: new BoxDecoration(
                                    color: Colors.white,
                                    border: new Border.all(
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: DropdownButton(
                                    elevation: 0,
                                    isExpanded: true,
                                    isDense: true,
                                    value: countrySelected1 == ""
                                        ? () => {
                                              countrySelected1 =
                                                  dummyListData[0],
                                              countryID = 1,
                                              setState(() {
                                                countrySelected1 =
                                                    dummyListData[0];
                                              }),
                                              searchCity(countrySelected1),
                                            }
                                        : countrySelected1,
                                    onChanged: (newValue) {
                                      setState(() {
                                        countrySelected1 = newValue;
                                      });
                                      for (int i = 0;
                                          i < countrySelection.length;
                                          i++) {
                                        if (countrySelection[i]
                                                ['country_name'] ==
                                            countrySelected1) {
                                          countryID =
                                              countrySelection[i]['country_id'];
                                          print("countryID:");
                                          print(countryID);

                                          setState(() {});
                                          searchCity(countrySelected1);
                                        }
                                      }
                                    },
                                    items: dummyListData.map((location) {
                                      return DropdownMenuItem(
                                        child: new Text(location),
                                        value: location,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "State",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 100.0,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 50.0,
                                decoration: new BoxDecoration(
                                    color: Colors.white,
                                    border: new Border.all(
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: DropdownButton(
                                    elevation: 0,
                                    isExpanded: true,
                                    isDense: true,
                                    value: citySelected1 == ""
                                        ? cityDummy[0]
                                        : citySelected1,
                                    onChanged: (newValue) {
                                      setState(() {
                                        citySelected1 = newValue;
                                      });

                                      for (var i = 0;
                                          i < countrySelection.length;
                                          i++) {
                                        if (countrySelection[i]
                                                ["country_name"] ==
                                            countrySelected1) {
                                          for (var j = 0;
                                              j <
                                                  countrySelection[i]["state"]
                                                      .length;
                                              j++) {
                                            if (countrySelection[i]["state"][j]
                                                    ['state_name'] ==
                                                citySelected1) {
                                              print(countrySelection[i]["state"]
                                                  [j]['state_id']);
                                              stateID = countrySelection[i]
                                                  ["state"][j]['state_id'];

                                              print("StateId: $stateID");
                                            }
                                          }
                                        }
                                      }
                                      searchState(
                                          countrySelected1, citySelected1);
                                      setState(() {});
                                    },
                                    items: cityDummy.map((location) {
                                      return DropdownMenuItem(
                                        child: new Text(location),
                                        value: location,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "City",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 100.0,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 50.0,
                                decoration: new BoxDecoration(
                                    color: Colors.white,
                                    border: new Border.all(
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: DropdownButton(
                                    elevation: 0,
                                    isExpanded: true,
                                    isDense: true,
                                    value: stateSelected1 == ""
                                        ? stateDummy[0]
                                        : stateSelected1,
                                    onChanged: (newValue) {
                                      setState(() {
                                        stateSelected1 = newValue;
                                      });
                                      for (var i = 0;
                                          i < countrySelection.length;
                                          i++) {
                                        if (countrySelection[i]
                                                ["country_name"] ==
                                            countrySelected1) {
                                          for (var j = 0;
                                              j <
                                                  countrySelection[i]["state"]
                                                      .length;
                                              j++) {
                                            if (countrySelection[i]["state"][j]
                                                    ['state_name'] ==
                                                citySelected1) {
                                              for (var k = 0;
                                                  k <
                                                      countrySelection[i]
                                                                  ["state"][j]
                                                              ['city']
                                                          .length;
                                                  k++) {
                                                if (countrySelection[i]["state"]
                                                            [j]['city'][k]
                                                        ['city_name'] ==
                                                    stateSelected1) {
                                                  cityID = countrySelection[i]
                                                          ["state"][j]['city']
                                                      [k]['cityid'];

                                                  print("cityID:: $cityID");
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }

                                      setState(() {});
                                    },
                                    items: stateDummy.map((location) {
                                      return DropdownMenuItem(
                                        child: new Text(location),
                                        value: location,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
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
                                        schNameC.clear();
                                        regCodeC.clear();
                                        nameAdminC.clear();
                                        designationC.clear();
                                        emailAdminC.clear();
                                        mobileAdminC.clear();
                                        addressC.clear();
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
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
                                        print(
                                            'address : ${addressC.text}, state : ${stateC.text}, district : ${distC.text}, city : ${cityC.text}, country : ${countryC.text}, ');
                                        var number = mobileAdminC.text;

                                        print(number.length);
                                        if (number.length < 10 ||
                                            number.length > 10) {
                                          utilitybasic.toastfun(
                                              "Phone Number should be 10 digits");
                                        } else {
                                          schoolID =
                                              await prefs.getInt("SchoolID");
                                          print("schoolid: $schoolID");

                                          var response = await http.post(
                                              "http://13.127.33.107//upload/dhanraj/homework/api/json_raw.php",
                                              body: jsonEncode({
                                                'action': 'school_reg',
                                                'schoolid': schoolID,
                                                'school_name': schNameC.text,
                                                'reg_code': regCodeC.text,
                                                'name': nameAdminC.text,
                                                'email': emailAdminC.text,
                                                'designation':
                                                    designationC.text,
                                                'mobile': mobileAdminC.text,
                                                'address': addressC.text,
                                                'state': stateID,
                                                'district': distC.text,
                                                'city': cityID,
                                                'country': countryID
                                              }));

                                          print(
                                              'Response status: ${response.statusCode}');
                                          print(
                                              'Response body: ${response.body}');
                                          var temp = json.decode(response.body);
                                          print('temp: $temp');
                                          print("status");
                                          // print(temp[0]['status']);

                                          if (temp[0]["status"] == "sucess") {
                                            await prefs.setint("LoggedIn", 1);
                                            await prefs.setint(
                                                "SchoolID", schoolId);
                                            // await prefs.setint("SchoolID", schoolId);

                                            nameLoggedAdmin = temp[0]["name"];

                                            await prefs.setString(
                                                "LoggedName", nameLoggedAdmin);
                                            view_link = temp123[0]["view_link"];
                                            await prefs.setString(
                                                "SchoolLink", view_link);
                                            utilitybasic.toastfun(
                                                "School Registration is successful");

                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdminDashBoard()), //AddStaffDetails()),
                                            );
                                          } else if (temp[0]["status"] ==
                                              "existing_school") {
                                            await prefs.setint("LoggedIn", 1);
                                            await prefs.setint(
                                                "SchoolID", schoolId);
                                            // await prefs.setint("SchoolID", schoolId);
                                            nameLoggedAdmin = temp[0]["name"];
                                            schoolName = temp[0]["school_name"];
                                            acylable = temp[0]["acylable"];
                                            acyid = temp[0]["acyid"];

                                            utilitybasic
                                                .toastfun(temp[0]["status"]);
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdminDashBoard()), //AddStaffDetails()),
                                            );
                                          } else {}
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

/* 

items2.length != 0
                              ? Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 20),
                                          )),
                                      Expanded(
                                        flex: 1,
                                        child: items2.length != 0
                                            ? ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: items2.length,
                                                itemBuilder: (context, i) {
                                                  // recentWords.add(items[index]);
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      stateSelected1 =
                                                          items2[i];
                                                      for (var i = 0;
                                                          i <
                                                              countrySelection
                                                                  .length;
                                                          i++) {
                                                        if (countrySelection[i][
                                                                "country_name"] ==
                                                            countrySelected1) {
                                                          for (var j = 0;
                                                              j <
                                                                  countrySelection[
                                                                              i]
                                                                          [
                                                                          "state"]
                                                                      .length;
                                                              j++) {
                                                            if (countrySelection[
                                                                            i][
                                                                        "state"][j]
                                                                    [
                                                                    'state_name'] ==
                                                                citySelected1) {
                                                              for (var k = 0;
                                                                  k <
                                                                      countrySelection[i]["state"][j]
                                                                              [
                                                                              'city']
                                                                          .length;
                                                                  k++) {
                                                                if (countrySelection[i]["state"][j]
                                                                            [
                                                                            'city'][k]
                                                                        [
                                                                        'city_name'] ==
                                                                    stateSelected1) {
                                                                  cityID = countrySelection[i]["state"]
                                                                              [
                                                                              j]
                                                                          [
                                                                          'city'][k]
                                                                      [
                                                                      'cityid'];
                                                                  stateC.text =
                                                                      stateSelected1;
                                                                  print(
                                                                      "cityID:: $cityID");
                                                                }
                                                              }
                                                            }
                                                          }
                                                        }
                                                      }

                                                      setState(() {
                                                        items2.clear();
                                                        cityS = true;
                                                      });
                                                    },
                                                    child: ListTile(
                                                      title: Text(items2[i]),
                                                    ),
                                                  );
                                                },
                                              )
                                            : Text(
                                                "",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox(),

 */

/* 
                                      Dialog errorDialog = Dialog(
                                          child: Container(
                                              height: 300.0,
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    TextField(
                                                        controller: countryC,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        onChanged:
                                                            (value) async {
                                                          searchC(value);

                                                          setState(() {});
                                                        }),
                                                    Expanded(
                                                      flex: 1,
                                                      child: items.length != 0
                                                          ? ListView.builder(
                                                              shrinkWrap: true,
                                                              itemCount:
                                                                  items.length,
                                                              itemBuilder:
                                                                  (context, i) {
                                                                // recentWords.add(items[index]);
                                                                return GestureDetector(
                                                                  onTap: () {},
                                                                  child: Text(
                                                                      items[i]),
                                                                );
                                                              },
                                                            )
                                                          : Text(
                                                              "",
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                            ),
                                                    )
                                                  ])));
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            errorDialog,
                                        barrierDismissible: true,
                                      );
                                      countryC.clear();
                                      setState(() {}); */

/* Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "District",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: distC,
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ), */

/* Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Expanded(
                          flex: 1,
                          child: TextField(
                            controller: schNameC,
                            keyboardType: TextInputType.multiline,
                            maxLines: 2,
                            style: TextStyle(fontSize: 18),
                          )),
                    ), */

/*  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "School Name",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: schNameC,
                                keyboardType: TextInputType.multiline,
                                maxLines: 2,
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ), */

/* 
                     Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Registration Code",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: regCodeC,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ), */

/* 
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Enter your Name",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: nameAdminC,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ), */

/* 
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Designation",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: designationC,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ), */

/* 
                                        Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Email",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: emailAdminC,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ),
 */

/* 
 Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Address",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: addressC,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ), */

/*  Padding(
                            padding: EdgeInsets.only(left: 100.0),
                            child: Container(
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      new Border.all(style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextField(
                                    controller:
                                        new TextEditingController.fromValue(
                                            new TextEditingValue(
                                                text: cityC.text,
                                                selection:
                                                    new TextSelection.collapsed(
                                                        offset: cityC
                                                            .text.length))),
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) async {
                                      cityC.text = value;
                                      items1.clear();

                                      await searchCityC(value);
                                      setState(() {});
                                    },
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 18),
                                  )),
                            ),
                          ), */
/*  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "State",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: /* stateS == false */
                                  // ?
                                  TextField(
                                controller: new TextEditingController.fromValue(
                                    new TextEditingValue(
                                        text: cityC.text,
                                        selection: new TextSelection.collapsed(
                                            offset: cityC.text.length))),
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 18),
                                onChanged: (value) async {
                                  cityC.text = value;
                                  items1.clear();

                                  await searchCityC(value);
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  hintText: stateS == false
                                      ? countrySelected
                                      : citySelected1,
                                  suffix: Padding(
                                    padding: EdgeInsets.only(top: 30.0),
                                  ),
                                  suffixIcon: GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.search,
                                        size: 25.0,
                                      ),
                                    ),
                                    onTap: () async {},
                                  ),
                                ),
                              )
                              // : Text(citySelected1),
                              )
                        ],
                      ),
                    ), */
/*    items1.length != 0
                              ? Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            "City",
                                            style: TextStyle(fontSize: 20),
                                          )),
                                      Expanded(
                                        flex: 1,
                                        child: items1.length != 0
                                            ? ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: items1.length,
                                                itemBuilder: (context, i) {
                                                  // recentWords.add(items[index]);
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      citySelected1 = items1[i];
                                                      cityC.text =
                                                          citySelected1;
                                                      for (var i = 0;
                                                          i <
                                                              countrySelection
                                                                  .length;
                                                          i++) {
                                                        if (countrySelection[i][
                                                                "country_name"] ==
                                                            countrySelected1) {
                                                          for (var j = 0;
                                                              j <
                                                                  countrySelection[
                                                                              i]
                                                                          [
                                                                          "state"]
                                                                      .length;
                                                              j++) {
                                                            if (countrySelection[
                                                                            i][
                                                                        "state"][j]
                                                                    [
                                                                    'state_name'] ==
                                                                citySelected1) {
                                                              print(countrySelection[
                                                                          i][
                                                                      "state"][j]
                                                                  ['state_id']);
                                                              stateID = countrySelection[
                                                                          i][
                                                                      "state"][j]
                                                                  ['state_id'];

                                                              print(
                                                                  "StateId: $stateID");
                                                            }
                                                          }
                                                        }
                                                      }

                                                      searchState(
                                                          countrySelected1,
                                                          citySelected1);

                                                      setState(() {
                                                        items1.clear();
                                                        stateS = true;
                                                      });
                                                    },
                                                    // child: Text(items1[i]),
                                                    child: ListTile(
                                                      title: Text(items1[i]),
                                                    ),
                                                  );
                                                },
                                              )
                                            : Text(
                                                "",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox(), */

/* items.length != 0
                              ? Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            "",
                                            style: TextStyle(fontSize: 20),
                                          )),
                                      Expanded(
                                        flex: 1,
                                        child: items.length != 0
                                            ? ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: items.length,
                                                itemBuilder: (context, i) {
                                                  // recentWords.add(items[index]);
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      countrySelected1 =
                                                          items[i];

                                                      for (int i = 0;
                                                          i <
                                                              countrySelection
                                                                  .length;
                                                          i++) {
                                                        if (countrySelection[i][
                                                                'country_name'] ==
                                                            countrySelected1) {
                                                          countryID =
                                                              countrySelection[
                                                                      i][
                                                                  'country_id'];
                                                          print(countryID);
                                                          countryC.text =
                                                              countrySelected1;

                                                          setState(() {
                                                            items.clear();
                                                            countryS = true;
                                                          });
                                                          searchCity(
                                                              countrySelected1);
                                                        }
                                                      }
                                                    },
                                                    // child: Text(items[i]),
                                                    child: ListTile(
                                                      title: Text(items[i]),
                                                    ),
                                                  );
                                                },
                                              )
                                            : Text(
                                                "",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox(), */
 */