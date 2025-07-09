import 'dart:convert';

import 'package:animated/jobs.dart';
import 'package:animated/loginPage.dart';
import 'package:animated/utility_basics.dart';
import 'package:animated/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

var boolSet = new List();

// ignore: must_be_immutable
class JobsList extends StatefulWidget {
  var jobSList;

  JobsList({Key key, @required this.jobSList}) : super(key: key);

  @override
  _JobsListState createState() => _JobsListState();
}

class _JobsListState extends State<JobsList> with TickerProviderStateMixin {
  TabController _nestedTabController;
  TextEditingController searchC = new TextEditingController();
  String searchItem = "";
  var searchedList1 = []; // = new List();

  var searchedList2 = []; // = new List();
  String val = "";

  @override
  void initState() {
    super.initState();
    ratinG = 3.5;
    _nestedTabController = new TabController(length: 2, vsync: this);
    fn();
  }

  fn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiToken = prefs.getString("apiToken");
    companyID = prefs.getInt("companyID");
    domain = prefs.getString("domain");

    try {
      var url =
          "https://api.lcsbridge.com/tracking/jobs?api_token=$apiToken&company_id=$companyID&domain=$domain";
      var response = await http.get(
        url,
      );

      jobSList = json.decode(response.body);

      pending = jobSList["data"]["pending"];
      completed = jobSList["data"]["completed"];
    } catch (e) {
      if (e.response.statusCode == 401) {
        //  SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("apiToken", null);
        await prefs.setInt("companyID", null);
        await prefs.setString("domain", null);
        await prefs.setInt("LoggedIN", null);
        await prefs.setString("LoggedName", null);
        usernameC.clear();
        passwordC.clear();
        domainC.clear();
        branchCodeC.clear();

        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
      jobSList = null;
      setState(() {});
    }
    setState(() {});
  }

  searchFN(String value) async {
    searchedList1.clear();
    searchedList2.clear();
    if (pending.length != 0) {
      for (var i = 0; i < pending.length; i++) {
        var data = pending[i];
        if (data["row_no"].toUpperCase().contains(value.toUpperCase())) {
          setState(() {
            searchedList1.add(data);
          });
        }
      }
    }
    if (completed != null) {
      for (var i = 0; i < completed.length; i++) {
        var data = completed[i];

        if (data["row_no"].toString().contains(value.toUpperCase())) {
          setState(() {
            searchedList2.add(data);
          });
        }
      }
    }
    if (searchedList2.length == 0) {
      setState(() {
        searchedList2.add("No items");
      });
    }
    if (searchedList1.length == 0) {
      setState(() {
        searchedList1.add("No items");
      });
    }
  }

  @override
  void dispose() {
    /* if (jobSList.isNotEmpty) {
      jobSList.clear();
    } */
    super.dispose();
    /*  if(!mounted){
      return ;
    } */
    jobSList = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: MediaQuery.of(context).size.width <= 420
                        ? const EdgeInsets.only(
                            left: 40.0, top: 15.0, bottom: 0.0)
                        : const EdgeInsets.only(
                            left: 45.0, top: 15.0, bottom: 0.0),
                    child: Text(
                      "Jobs",
                      style: TextStyle(
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Gilory-Medium",
                          fontSize: 20.0,
                          color: Color(0xff202020)),
                    ),
                  )),
              SizedBox(height: 10.0),
              TabBar(
                  labelStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Gilory-Medium"),
                  controller: _nestedTabController,
                  indicatorColor: Color(0xff4f48ff),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 5.0,
                  labelColor: Colors.black,
                  labelPadding: EdgeInsets.only(left: 12.0, right: 12.0),
                  unselectedLabelColor: Color(0xff828282),
                  unselectedLabelStyle:
                      TextStyle(fontSize: 16, fontFamily: "Gilory-Medium"),
                  isScrollable: false,
                  indicatorPadding: EdgeInsets.only(left: 12.0, right: 12.0),
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                          pending == null
                              ? "Pending"
                              : "Pending - ${pending.length}",
                          style: TextStyle(
                              fontFamily: "Gilory-Medium", fontSize: 16)),
                    ),
                    Tab(
                      child: Text(
                          completed == null
                              ? "Completed"
                              : "Completed - ${completed.length}",
                          style: TextStyle(
                              fontFamily: "Gilory-Medium", fontSize: 16)),
                    ),
                  ]),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffe2e2e2),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xfff6f6f6),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: new TextEditingController.fromValue(
                          new TextEditingValue(
                              text: searchC.text,
                              selection: new TextSelection.collapsed(
                                  offset: searchC.text.length))),
                      onChanged: (value) async {
                        searchC.text = value;
                        searchC.selection = TextSelection.fromPosition(
                            TextPosition(offset: searchC.text.length));

                        val = value;

                        if (val.length > 0) {
                          searchedList1.clear();
                          searchedList2.clear();
                          print("pending:: $pending");
                          if (pending != null) {
                            for (var i = 0; i < pending.length; i++) {
                              var data = pending[i];

                              if (data["row_no"]
                                  .toString()
                                  .toUpperCase()
                                  .contains(value.toString().toUpperCase())) {
                                setState(() {
                                  searchedList1.add(data);
                                });
                              }
                            }
                          }
                          if (completed != null) {
                            for (var i = 0; i < completed.length; i++) {
                              var data = completed[i];

                              if (data["row_no"]
                                  .toString()
                                  .contains(value.toString().toUpperCase())) {
                                setState(() {
                                  searchedList2.add(data);
                                });
                              }
                            }
                          }
                          if (searchedList2.length == 0) {
                            setState(() {
                              searchedList2.add("No items");
                            });
                          }
                          if (searchedList1.length == 0) {
                            setState(() {
                              searchedList1.add("No items");
                            });
                          }

                          setState(() {});
                        } else {
                          setState(() {
                            searchedList1.clear();
                            searchedList2.clear();
                          });
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Search by job number",
                          hintStyle: TextStyle(
                              fontFamily: "Gilory-Medium",
                              fontSize: 13.0,
                              color: Color(0xff828282)),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          )),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBarView(
                      controller: _nestedTabController,
                      children: <Widget>[
                        searchedList1.length != 0
                            ? tabs(pending: searchedList1, comp: false)
                            : tabs(pending: pending, comp: false),
                        searchedList2.length != 0
                            ? tabs(pending: searchedList2, comp: true)
                            : tabs(pending: completed, comp: true),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchListed({
    BuildContext context,
    var searchLIST,
    bool comp,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: searchLIST.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, i) {
        return searchLIST[0] == "No items"
            ? Center(child: Text("No items"))
            : InkWell(
                onTap: () async {
                  try {
                    var response = await http.get(
                        "https://api.lcsbridge.com/tracking/job/${searchLIST[i]["row_no"]}?api_token=$apiToken&company_id=$companyID&domain=$domain");

                    if (response.statusCode == 500) {
                      customToast(context,
                          "For this ${searchLIST[i]["row_no"]} status code is 500");
                      jobDetails.clear();
                    } else {
                      jobDetails = json.decode(response.body);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Jobs(
                                  rowID: searchLIST[i]["row_no"],
                                  id: searchLIST[i]["id"],
                                  comp: comp)));
                    }
                  } catch (e) {
                    if (e.response.statusCode == 401) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString("apiToken", null);
                      await prefs.setInt("companyID", null);
                      await prefs.setString("domain", null);
                      await prefs.setInt("LoggedIN", null);
                      await prefs.setString("LoggedName", null);
                      usernameC.clear();
                      passwordC.clear();
                      domainC.clear();
                      branchCodeC.clear();
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    } else if (e.response.statusCode == 500) {
                      customToast(context,
                          "For this ${searchLIST[i]["row_no"]} Response status code is 500");
                      jobDetails = {};
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 5.0, left: 8.0, right: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("${searchLIST[i]["row_no"]} - ",
                                  style: TextStyle(
                                      color: Color(0xff757575),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Gilory-Medium",
                                      fontSize: 17.0)),
                              Text(
                                  searchLIST[i]["awb_bill_no"] == "" ||
                                          pending[i]["awb_bill_no"] == null
                                      ? "AWB NO"
                                      : "${searchLIST[i]["awb_bill_no"]}",
                                  style: TextStyle(
                                      color: Color(0xff757575),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Gilory-Medium",
                                      fontSize: 12.0)),
                            ],
                          ),
                          if ((searchLIST[i]["pol"] == null ||
                                  searchLIST[i]["pol"] == "") &&
                              (searchLIST[i]["pod"] != null ||
                                  searchLIST[i]["pod"] != ""))
                            Text(
                              "POL-${searchLIST[i]["pod"]}",
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: "Gilory-Medium",
                                fontSize: 12.0,
                              ),
                            )
                          else if ((searchLIST[i]["pod"] == null ||
                                  searchLIST[i]["pod"] == " ") &&
                              (searchLIST[i]["pol"] != null ||
                                  searchLIST[i]["pol"] != " "))
                            Text(
                              "${searchLIST[i]["pol"]}-POD",
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: "Gilory-Medium",
                                fontSize: 12.0,
                              ),
                            )
                          else if ((searchLIST[i]["pod"] == null ||
                                  searchLIST[i]["pod"] == "") &&
                              (searchLIST[i]["pol"] == null ||
                                  searchLIST[i]["pol"] == ""))
                            Text(
                              "POL-POD",
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: "Gilory-Medium",
                                fontSize: 12.0,
                              ),
                            )
                          else
                            Text(
                              "${searchLIST[i]["pol"]}-${searchLIST[i]["pod"]}",
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: "Gilory-Medium",
                                fontSize: 12.0,
                              ),
                            ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if ((searchLIST[i]["status"] == null ||
                                  searchLIST[i]["status"] == "") &&
                              (searchLIST[i]["status_date"] != null ||
                                  searchLIST[i]["status_date"] != ""))
                            Text(
                              "STATUS-${searchLIST[i]["status_date"]}",
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: "Gilory-Medium",
                                fontSize: 12.0,
                              ),
                            )
                          else if ((searchLIST[i]["status"] == null ||
                                  searchLIST[i]["status"] == " ") &&
                              (searchLIST[i]["status_date"] != null ||
                                  searchLIST[i]["status_date"] != " "))
                            Text(
                              "${searchLIST[i]["status"]} - DATE",
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: "Gilory-Medium",
                                fontSize: 12.0,
                              ),
                            )
                          else if ((searchLIST[i]["status"] == null ||
                                  searchLIST[i]["status"] == "") &&
                              (searchLIST[i]["status_date"] == null ||
                                  searchLIST[i]["status_date"] == ""))
                            Text(
                              "STATUS - DATE",
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: "Gilory-Medium",
                                fontSize: 12.0,
                              ),
                            )
                          else
                            Text(
                              "${searchLIST[i]["status"]} - ${searchLIST[i]["status_date"]}",
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: "Gilory-Medium",
                                fontSize: 12.0,
                              ),
                            ),
                          /* if ((searchLIST[i]["status"] == null ||
                                  searchLIST[i]["status"] == "") &&
                              (searchLIST[i]["status_date"] == null))
                            Text("STATUS - DATE",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Gilory-Medium",
                                    color: Color(0xFF313131)))
                          else if ((searchLIST[i]["status"] != null) &&
                              (searchLIST[i]["status_date"] == null))
                            Text("${searchLIST[i]["status"]} - DATE",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Gilory-Medium",
                                    color: Color(0xFF313131)))
                          else if ((searchLIST[i]["status"] == null) &&
                              (searchLIST[i]["status_date"] != null))
                            Text("STATUS - ${searchLIST[i]["status_date"]}",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Gilory-Medium",
                                    color: Color(0xFF313131)))
                          else
                            Text(
                                "${searchLIST[i]["status"]} - ${searchLIST[i]["status_date"]}",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Gilory-Medium",
                                    color: Color(0xFF313131))), */
                          Text(
                              searchLIST[i]["eta"] == null
                                  ? "ETA ETA"
                                  : "ETA ${searchLIST[i]["eta"]}",
                              style: TextStyle(
                                  fontFamily: "Gilory-Medium",
                                  fontSize: 12,
                                  color: Color(0xFF313131)))
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Divider(
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }
}

Widget tabs({var pending, bool comp}) {
  return pending == null || pending[0] == "No items" || pending.length == 0
      ? Center(child: Text(("No Items")))
      : ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: pending.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Jobs(
                            rowID: pending[i]["row_no"],
                            id: pending[i]["id"],
                            comp: comp)));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 5.0, left: 8.0, right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("${pending[i]["row_no"]} - ",
                                style: TextStyle(
                                    color: Color(0xff757575),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Gilory-Medium",
                                    fontSize: 17.0)),
                            Text(
                                pending[i]["awb_bill_no"] == "" ||
                                        pending[i]["awb_bill_no"] == null
                                    ? "AWB NO"
                                    : "${pending[i]["awb_bill_no"]}",
                                style: TextStyle(
                                    color: Color(0xff757575),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Gilory-Medium",
                                    fontSize: 12.0)),
                          ],
                        ),
                        if ((pending[i]["pol"] == null ||
                                pending[i]["pol"] == " ") &&
                            (pending[i]["pod"] != null ||
                                pending[i]["pod"] != " "))
                          Text(
                            "POL-${pending[i]["pod"]}",
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: "Gilory-Medium",
                              fontSize: 12.0,
                            ),
                          )
                        else if ((pending[i]["pod"] == null ||
                                pending[i]["pod"] == " ") &&
                            (pending[i]["pol"] != null ||
                                pending[i]["pol"] != " "))
                          Text(
                            "${pending[i]["pol"]}-POD",
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: "Gilory-Medium",
                              fontSize: 12.0,
                            ),
                          )
                        else if ((pending[i]["pod"] == null ||
                                pending[i]["pod"] == "") &&
                            (pending[i]["pol"] == null ||
                                pending[i]["pol"] == ""))
                          Text(
                            "POL-POD",
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: "Gilory-Medium",
                              fontSize: 12.0,
                            ),
                          )
                        else
                          Text(
                            "${pending[i]["pol"]}-${pending[i]["pod"]}",
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: "Gilory-Medium",
                              fontSize: 12.0,
                            ),
                          ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if ((pending[i]["status"] == "" ||
                                pending[i]["status"] == null) &&
                            (pending[i]["status_date"] == "" ||
                                pending[i]["status_date"] == null))
                          Text(
                            "STATUS - DATE",
                            style: TextStyle(
                              color: Color(0xFF313131),
                              fontFamily: "Gilory-Medium",
                              fontSize: 12.0,
                            ),
                          )
                        else if ((pending[i]["status"] == "" ||
                            pending[i]["status"] == null))
                          Text(
                            "STATUS - ${pending[i]["status_date"]}",
                            style: TextStyle(
                              color: Color(0xFF313131),
                              fontFamily: "Gilory-Medium",
                              fontSize: 12.0,
                            ),
                          )
                        else if ((pending[i]["status_date"] == "" ||
                            pending[i]["status_date"] == null))
                          Text(
                            "${pending[i]["status"]} - DATE",
                            style: TextStyle(
                              color: Color(0xFF313131),
                              fontFamily: "Gilory-Medium",
                              fontSize: 12.0,
                            ),
                          )
                        else
                          Text(
                            "${pending[i]["status"]} - ${pending[i]["status_date"]}",
                            style: TextStyle(
                              color: Color(0xFF313131),
                              fontFamily: "Gilory-Medium",
                              fontSize: 12.0,
                            ),
                          ),
                        Text(
                            pending[i]["eta"] == null
                                ? "ETA ETA"
                                : "ETA ${pending[i]["eta"]}",
                            style: TextStyle(
                                fontFamily: "Gilory-Medium",
                                fontSize: 12,
                                color: Color(0xFF313131)))
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Divider(
                      color: Colors.grey[400],
                    )
                  ],
                ),
              ),
            );
          },
        );
}
