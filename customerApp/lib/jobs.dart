import 'dart:convert';

import 'package:animated/feedBackForm.dart';
import 'package:animated/fileupload.dart';
import 'package:animated/loginPage.dart';
import 'package:animated/main.dart';
import 'package:animated/utility_basics.dart';
import 'package:animated/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Jobs extends StatefulWidget {
  final rowID;
  final id;
  final bool comp;

  Jobs({Key key, @required this.rowID, @required this.id, this.comp})
      : super(key: key);

  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  bool setFeedCard = true;
  bool abc = true;

  @override
  void initState() {
    super.initState();
    ratinG = 3.5;
    fn();
  }

  fn() async {
    try {
      var response = await http.get(
          "https://api.lcsbridge.com/tracking/job/${widget.id}?api_token=$apiToken&company_id=$companyID&domain=$domain");

      setState(() {
        if (response.statusCode == 500) {
          customToast(context, "For this ${widget.rowID} status code is 500");
          jobDetails.clear();
        } else {
          jobDetails = json.decode(response.body);
        }
      });
    } catch (e) {
      if (e.response.statusCode == 401) {
       SharedPreferences prefs = await SharedPreferences.getInstance();
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
      } else if (e.response.statusCode == 500) {
        customToast(
            context, "For this ${widget.rowID} Response status code is 500");

        setState(() {
          jobDetails = {};
        });
      }
    }
  }

  bool setViewMore = false;
  bool setEndAnimation = false;
  bool setSeeAll = false;
  bool setEndAnimationSeeAll = false;
  bool setList = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, size: 20.0)),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        title: Transform.translate(
          offset: Offset(-20, 0),
          child: Container(
            color: Colors.white,
            child: Text("$loggedName",
                overflow: TextOverflow.ellipsis,
                // softWrap: false,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: "Gilory-Medium",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo)),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: jobDetails == null
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: jobDetails["data"]["files"].length == 0 ||
                          jobDetails["data"]["status"].length == 0
                      ? const EdgeInsets.only(bottom: 50.0)
                      : const EdgeInsets.only(bottom: 0),
                  child: Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      primary: true,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: BouncingScrollPhysics(),
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          "${jobDetails["data"]["job"]["row_no"]}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Gilory-Medium",
                                            letterSpacing: 2.0,
                                          )),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Visibility(
                                    visible: widget.comp,
                                    child: Container(
                                      decoration: new BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.white.withOpacity(0.01),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(10, 10),
                                          ),
                                        ],
                                      ),
                                      child: Material(
                                          elevation: 7.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Text(
                                                      "Rate us about this shipment",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Gilory-Medium",
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  Test(),
                                                  RaisedButton(
                                                    mouseCursor: MouseCursor
                                                        .uncontrolled,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0)),
                                                    color: abc
                                                        ? Colors.indigo
                                                        : Colors.grey,
                                                    onPressed: () async {
                                                      setState(() {
                                                        abc = false;
                                                      });
                                                      await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FeedBackCard(
                                                                      rowID: widget
                                                                          .rowID,
                                                                      id: widget
                                                                          .id)));
                                                    },
                                                    child: Text("Submit",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Gilory-Medium",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 18.0),
                                  child: Container(
                                    height: 170,
                                    decoration: new BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.indigo.withOpacity(0.01),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(5, 5),
                                        ),
                                      ],
                                    ),
                                    child: Material(
                                      elevation: 7.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: Colors.indigo,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0,
                                              right: 15.0,
                                              top: 10.0,
                                              bottom: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          dotsInJobs(true),
                                                          SizedBox(height: 8),
                                                          dotsInJobs(false),
                                                          SizedBox(height: 8),
                                                          dotsInJobs(false),
                                                          SizedBox(height: 8),
                                                          dotsInJobs(false),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          dotsInJobs(false),
                                                          SizedBox(height: 8),
                                                          dotsInJobs(false),
                                                          SizedBox(height: 8),
                                                          dotsInJobs(false),
                                                          SizedBox(height: 8),
                                                          dotsInJobs(true),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(width: 20.0),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          jobDetails["data"]["job"]
                                                                          [
                                                                          "pol"] ==
                                                                      null ||
                                                                  jobDetails["data"]
                                                                              ["job"]
                                                                          [
                                                                          "pol"] ==
                                                                      ""
                                                              ? "POL"
                                                              : "${jobDetails["data"]["job"]["pol"]}"
                                                                  .toUpperCase(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Gilory-Medium",
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .white)),
                                                      Text(
                                                          jobDetails["data"]["job"]
                                                                          [
                                                                          "awb_bill_no"] ==
                                                                      null ||
                                                                  jobDetails["data"]
                                                                              ["job"]
                                                                          [
                                                                          "awb_bill_no"] ==
                                                                      ""
                                                              ? "AWB NO"
                                                              : "${jobDetails["data"]["job"]["awb_bill_no"]}",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Gilory-Medium",
                                                              fontSize: 15.0,
                                                              color: Colors
                                                                  .white)),
                                                      Text(
                                                          jobDetails["data"]["job"]
                                                                          [
                                                                          "pod"] ==
                                                                      null ||
                                                                  jobDetails["data"]
                                                                              ["job"]
                                                                          [
                                                                          "pod"] ==
                                                                      ""
                                                              ? "POD"
                                                              : "${jobDetails["data"]["job"]["pod"]}"
                                                                  .toUpperCase(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Gilory-Medium",
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .white)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                      jobDetails["data"]["job"]
                                                                  ["etd"] ==
                                                              null
                                                          ? "ETD"
                                                          : "${jobDetails["data"]["job"]["etd"]}",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Gilory-Medium",
                                                          fontSize: 15.0,
                                                          color: Colors.white)),
                                                  Container(
                                                    width: 100.0,
                                                    child: Text(
                                                        "${jobDetails["data"]["job"]["carrier"]}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Gilory-Medium",
                                                            fontSize: 15.0,
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                  Text(
                                                      jobDetails["data"]["job"]
                                                                  ["eta"] ==
                                                              null
                                                          ? "ETA"
                                                          : "${jobDetails["data"]["job"]["eta"]}",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Gilory-Medium",
                                                          fontSize: 15.0,
                                                          color: Colors.white)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                jobDetails["data"]["services"].values.length ==
                                        0
                                    ? SizedBox.shrink()
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(top: 18.0),
                                        child: Container(
                                          height: 50.0,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: jobDetails["data"]
                                                      ["services"]
                                                  .values
                                                  .length,
                                              itemBuilder: (context, i) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0,
                                                          bottom: 8.0,
                                                          right: 8.0),
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color:
                                                                  Colors.white,
                                                              spreadRadius: 5.0,
                                                              offset:
                                                                  Offset(5, 5)),
                                                        ],
                                                        color:
                                                            Color(0xffF4F4F4),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      height: 20.0,
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              "${jobDetails["data"]["services"].values.toList()[i]}",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Gilory-Medium",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color: Colors
                                                                    .black,
                                                              )))),
                                                );
                                              }),
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 18.0),
                                  child: Container(
                                    decoration: new BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Material(
                                          elevation: 7.0,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: AnimatedContainer(
                                            duration: Duration(milliseconds: 1),
                                            onEnd: () {
                                              setState(() {
                                                setEndAnimation = true;
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: ListView(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: MediaQuery.of(context)
                                                                            .size
                                                                            .width >
                                                                        400
                                                                    ? 220.0
                                                                    : 120,
                                                                child: Text(
                                                                  jobDetails["data"]["job"]["commodity"] ==
                                                                              null ||
                                                                          jobDetails["data"]["job"]["commodity"] ==
                                                                              ""
                                                                      ? "COMMODITY"
                                                                      : "${jobDetails["data"]["job"]["commodity"]}"
                                                                          .toUpperCase(),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "Gilory-Medium",
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                "COMMODITY",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Gilory-Medium",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 10.0),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                jobDetails["data"]["job"]["client_reference"] ==
                                                                            null ||
                                                                        jobDetails["data"]["job"]["client_reference"] ==
                                                                            ""
                                                                    ? "CLIENT REF/PO NO"
                                                                    : "${jobDetails["data"]["job"]["client_reference"]}"
                                                                        .toUpperCase(),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Gilory-Medium",
                                                                ),
                                                              ),
                                                              Text(
                                                                "CLIENT REF/PO NO",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Gilory-Medium",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 10.0),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                jobDetails["data"]["job"]["weight"] ==
                                                                            null ||
                                                                        jobDetails["data"]["job"]["weight"] ==
                                                                            ""
                                                                    ? "WEIGHT"
                                                                    : "${jobDetails["data"]["job"]["weight"]}",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Gilory-Medium",
                                                                ),
                                                              ),
                                                              Text(
                                                                "WEIGHT",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Gilory-Medium",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: setViewMore &&
                                                              setEndAnimation,
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                  height: 10.0),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      jobDetails["data"]["job"]["volume"] == null ||
                                                                              jobDetails["data"]["job"]["volume"] == ""
                                                                          ? "VOLUME"
                                                                          : "${jobDetails["data"]["job"]["volume"]}",
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            "Gilory-Medium",
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "VOLUME",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Gilory-Medium",
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 10.0),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          200.0,
                                                                      child:
                                                                          Text(
                                                                        jobDetails["data"]["job"]["carrier"] == "" ||
                                                                                jobDetails["data"]["job"]["carrier"] == null
                                                                            ? "SHIPPER"
                                                                            : "${jobDetails["data"]["job"]["carrier"]}",
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              "Gilory-Medium",
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "SHIPPER",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Gilory-Medium",
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 10.0),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      jobDetails["data"]["job"]["posting_date"] == null ||
                                                                              jobDetails["data"]["job"]["posting_date"] == ""
                                                                          ? "POSTING DATE"
                                                                          : "${jobDetails["data"]["job"]["posting_date"]}",
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            "Gilory-Medium",
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "POSTING DATE",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Gilory-Medium",
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 10.0),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      jobDetails["data"]["job"]["bayan_no"] == null ||
                                                                              jobDetails["data"]["job"]["bayan_no"] == ""
                                                                          ? "BAYAN NO"
                                                                          : "${jobDetails["data"]["job"]["bayan_no"]}",
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            "Gilory-Medium",
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "BAYAN NO",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Gilory-Medium",
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 10.0),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      jobDetails["data"]["job"]["vessel_flt_no"] == null ||
                                                                              jobDetails["data"]["job"]["vessel_flt_no"] == ""
                                                                          ? "VESSEL"
                                                                          : "${jobDetails["data"]["job"]["vessel_flt_no"]}",
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            "Gilory-Medium",
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "VESSEL",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Gilory-Medium",
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            setState(() {
                                                              setViewMore =
                                                                  !setViewMore;
                                                              setEndAnimation =
                                                                  !setEndAnimation;
                                                            });
                                                          },
                                                          child: Text(
                                                            setViewMore
                                                                ? "View Less"
                                                                : "View More",
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontFamily:
                                                                    "Gilory-Medium",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .indigo),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                                jobDetails["data"]["files"].length == 0
                                    ? SizedBox(height: 10)
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(top: 18.0),
                                        child: Container(
                                          height: 90.0,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: jobDetails["data"]
                                                      ["files"]
                                                  .length,
                                              itemBuilder: (context, i) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0, right: 8.0),
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          new BoxShadow(
                                                            color: Colors.white,
                                                            blurRadius: 2.0,
                                                            spreadRadius: 2.0,
                                                          ),
                                                        ],
                                                        color:
                                                            Color(0xffEBEBEB),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                                height: 95.0,
                                                                width: 65.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                child: jobDetails["data"]["files"][i]
                                                                            [
                                                                            "type"] ==
                                                                        "pdf"
                                                                    ? Image
                                                                        .asset(
                                                                        "assets/fileTypes/pdf.png",
                                                                        scale:
                                                                            0.5,
                                                                      )
                                                                    : Image
                                                                        .asset(
                                                                        "assets/fileTypes/jpg.png",
                                                                        // scale: 0.025,
                                                                        scale:
                                                                            0.50,
                                                                      )),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "${jobDetails["data"]["files"][i]["service"]}",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Gilory-Medium",
                                                                        fontSize:
                                                                            15.0),
                                                                  ),
                                                                  SizedBox(height: 5.0),
                                                                  Text(
                                                                    "${jobDetails["data"]["files"][i]["title"]}",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Gilory-Medium",
                                                                        fontSize:
                                                                            12.0),
                                                                  ),SizedBox(height: 5.0),
                                                                  Text(
                                                                    "${jobDetails["data"]["files"][i]["size"]}",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Gilory-Medium",
                                                                        fontSize:
                                                                            13.0),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                );
                                              }),
                                        ),
                                      ),
                                jobDetails["data"]["status"].length == 0
                                    ? SizedBox.shrink()
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(top: 18.0),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: new BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            boxShadow: [],
                                          ),
                                          child: Material(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            elevation: 7.0,
                                            child: AnimatedContainer(
                                              duration:
                                                  Duration(milliseconds: 100),
                                              onEnd: () {
                                                setState(() {
                                                  setEndAnimationSeeAll = true;
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: ListView(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          setSeeAll =
                                                              !setSeeAll;
                                                          setEndAnimationSeeAll =
                                                              !setEndAnimationSeeAll;
                                                        });
                                                      },
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                          setSeeAll
                                                              ? "See Less"
                                                              : "See All",
                                                          style: TextStyle(
                                                              fontSize: 16.0,
                                                              fontFamily:
                                                                  "Gilory-Medium",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .indigo),
                                                        ),
                                                      ),
                                                    ),
                                                    jobDetails["data"]
                                                                    ["status"]
                                                                .length ==
                                                            0
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom:
                                                                        60.0),
                                                            child: SizedBox(
                                                                height: 10.0),
                                                          )
                                                        : ListView.builder(
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0),
                                                            primary: true,
                                                            shrinkWrap: true,
                                                            itemCount: setSeeAll
                                                                ? jobDetails["data"]
                                                                        [
                                                                        "status"]
                                                                    .length
                                                                : (jobDetails["data"]["status"].length >
                                                                            0 &&
                                                                        jobDetails["data"]["status"].length <
                                                                            2
                                                                    ? 1
                                                                    : 2),
                                                            itemBuilder:
                                                                (context, i) {
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            20.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          "${jobDetails["data"]["status"][i]["status"]}",
                                                                          style: TextStyle(
                                                                              fontFamily: "Gilory-Medium",
                                                                              color: Colors.blueGrey[900],
                                                                              fontSize: 18.0),
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              setSeeAll = !setSeeAll;
                                                                              setEndAnimationSeeAll = !setEndAnimationSeeAll;
                                                                              setList = !setList;
                                                                            });
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            setSeeAll
                                                                                ? ""
                                                                                : "",
                                                                            style: TextStyle(
                                                                                fontSize: 16.0,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.indigo),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5.0),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          "${jobDetails["data"]["status"][i]["posting_date"]}",
                                                                          style: TextStyle(
                                                                              color: Colors.blueGrey[900],
                                                                              fontFamily: "Gilory-Medium",
                                                                              fontSize: 15.0),
                                                                        ),
                                                                        SizedBox(),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: jobDetails["data"]["status"].length == 0
              ?Color(0xff4f48ff)
              : Color(0xff4f48ff),
          icon: Icon(Icons.add),
          label: Text("Upload File",
              style:
                  TextStyle(color: Colors.white, fontFamily: "Gilory-Medium")),
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FileUpload(rowID: widget.rowID, id: widget.id)));
          }),
    );
  }
}
