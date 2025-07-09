import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:animated/loginPage.dart';
import 'package:animated/utility_basics.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';
import 'package:path/path.dart' as path;

import 'package:http/http.dart' as http;

Color colorCode = Colors.white;

class FileUpload extends StatefulWidget {
  final rowID;
  final int id;
  FileUpload({Key key, @required this.rowID, @required this.id})
      : super(key: key);

  @override
  _FileUploadState createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  List<File> files;
  var filePaths = new List();
  var serviceDocS = new List();
  var serviceIDs = new List();

  var fileArrays = new List();
  var dropDownValueST = "Select";
  int serviceID;

  TextEditingController customContr = new TextEditingController();
  TextEditingController docuTitle = new TextEditingController();
  var formatter = new DateFormat('dd-MM-yyy');
  var now = new DateTime.now();
  var birthDateInString;
  var birthDateInString2;
  DateTime birthDate;

  @override
  void initState() {
    super.initState();
    birthDateInString = formatter.format(now);
    birthDateInString2 = formatter.format(now);
    callingServiceAPI();
  }

  callingServiceAPI() async {
    var passingPara;
    serviceDocS.add("Select");
    serviceIDs.add(0);
    Response response;
    Dio dio = new Dio();
    try {
      response = await dio.get(
          "https://api.lcsbridge.com/tracking/jobs/upload/form/${widget.id}?api_token=$apiToken&company_id=$companyID&domain=$domain",
          queryParameters: {
            "api_token": apiToken,
            "company_id": companyID,
            "domain": domain,
          });
      passingPara = response.data;

      for (var i = 0; i < passingPara["services"].length; i++) {
        serviceDocS.add(passingPara["services"][i]["description"]);
        serviceIDs.add(passingPara["services"][i]["id"]);
      }

      setState(() {});
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
      }
     
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    serviceDocS.clear();
    serviceIDs.clear();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 5000));
    dropDownValueST = "Select";
    serviceDocS.clear();
    serviceIDs.clear();
    serviceID = 0;
    if (files.length > 0) {
      filePaths.clear();
      files.clear();
    }

    callingServiceAPI();

    docuTitle.text = "";

    fileArrays.clear();

    setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 20.0, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Transform.translate(
          offset: Offset(-20, 0),
          child: Text("$loggedName",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: "Gilory-Medium",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo)),
        ),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
            child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 0.0, top: 15.0, bottom: 0.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "FILE UPLOAD - ${widget.rowID}",
                      style: TextStyle(
                          letterSpacing: 1.0,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Gilory-Medium",
                          color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Document for Service*",
                        style: TextStyle(
                            fontFamily: "Gilory-Medium", fontSize: 12.0),
                        textAlign: TextAlign.left,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        border: new Border.all(
                            style: BorderStyle.solid, color: Color(0xffdadce0)),
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: DropdownButton(
                          underline: Container(),
                          elevation: 0,
                          isExpanded: true,
                          isDense: true,
                          value: dropDownValueST,
                          onChanged: (newValue) {
                            setState(() {
                              dropDownValueST = newValue;
                            });
                            for (var i = 0; i < serviceDocS.length; i++) {
                              if (dropDownValueST == serviceDocS[i]) {
                                serviceID = serviceIDs[i];
                              }
                            }
                          },
                          items: serviceDocS.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location,
                                  style: TextStyle(
                                    fontFamily: "Gilory-Medium",
                                  )),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    // ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Document Title*",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: "Gilory-Medium",
                        ),
                        textAlign: TextAlign.left,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: 45.0,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        border: new Border.all(
                            style: BorderStyle.solid, color: Color(0xffdadce0)),
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: TextField(
                        controller: docuTitle,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Posting Date*",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: "Gilory-Medium",
                        ),
                        textAlign: TextAlign.left,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      final datePick = await showDatePicker(
                          context: context,
                          initialDate: new DateTime.now(),
                          firstDate: new DateTime(1900),
                          lastDate: new DateTime(2100));
                      if (datePick != null && datePick != birthDate) {
                        setState(() {
                          birthDate = datePick;
                          birthDateInString =
                              new DateFormat("dd-MM-yyyy").format(birthDate);
                        });
                      }
                    },
                    child: Container(
                      height: 45.0,
                      width: double.infinity,
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          border: new Border.all(
                              style: BorderStyle.solid,
                              color: Color(0xffdadce0)),
                          borderRadius: BorderRadius.circular(50.0)),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              birthDateInString,
                              style: TextStyle(
                                fontFamily: "Gilory-Medium",
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Expiry Date*",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: "Gilory-Medium",
                        ),
                        textAlign: TextAlign.left,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      final datePick = await showDatePicker(
                          context: context,
                          initialDate: new DateTime.now(),
                          firstDate: new DateTime(1900),
                          lastDate: new DateTime(2100));
                      if (datePick != null && datePick != birthDate) {
                        setState(() {
                          birthDate = datePick;
                          birthDateInString2 =
                              new DateFormat("dd-MM-yyyy").format(birthDate);
                        });
                      }
                    },
                    child: Container(
                      height: 45.0,
                      width: double.infinity,
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          border: new Border.all(
                              style: BorderStyle.solid,
                              color: Color(0xffdadce0)),
                          borderRadius: BorderRadius.circular(50.0)),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              birthDateInString2,
                              style: TextStyle(
                                fontFamily: "Gilory-Medium",
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                  child: DottedBorder(
                    color: Color(0xffdadce0),
                    dashPattern: [5.0, 5.0],
                    strokeWidth: 1,
                    borderType: BorderType.RRect,
                    radius: Radius.circular(50.0),
                    child: Container(
                      height: 150.0,
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () async {
                          files = new List<File>();
                          fileArrays.clear();
                          files = await FilePicker.getMultiFile(
                            type: FileType.custom,
                            allowedExtensions: [
                              'jpg',
                              'pdf',
                              'doc',
                              'xls',
                              'xlsx',
                              'docx',
                              'jpeg',
                              'png'
                            ],
                          );

                          for (var i = 0; i < files.length; i++) {
                            fileArrays.add(await MultipartFile.fromFile(
                                files[i].path,
                                filename: path.basename(files[i].path)));
                          }

                          setState(() {});
                        },
                        child: files == null || files.length == 0
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add,
                                      size: 70.0, color: Colors.indigo),
                                  Text(
                                    "Upload Files",
                                    style: TextStyle(
                                      fontFamily: "Gilory-Medium",
                                    ),
                                  )
                                ],
                              )
                            : GridView.count(
                                crossAxisCount: 2,
                                children: List.generate(files.length, (index) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            "${files[index].path}",
                                            height: 90.0,
                                            width: 90.0,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${path.basename(files[index].path)}",
                                            style: TextStyle(fontSize: 15.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                      ),
                    ),
                  ),
                ),
                Material(
                  elevation: 0.0,
                  color: Colors.white,
                  child: ButtonTheme(
                    minWidth: double.infinity,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(100.0),
                    ),
                    child: RaisedButton(
                      color: Color(0xff4f48ff),
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: "Gilory-Medium",
                        ),
                      ),
                      onPressed: () async {
                        if (serviceID == null || serviceID == 0) {
                          customToast(
                              context, "Please select document and service");
                        } else if (docuTitle.text == "") {
                          customToast(context, "Please type document title");
                        } else if (fileArrays.length == 0) {
                          customToast(context, "Minimum one file required");
                        } else {
                          ProgressDialog pr = new ProgressDialog(context,
                              type: ProgressDialogType.Normal);
                          pr.style(message: 'Please Wait...');
                          pr.show();

                          Dio dio = new Dio();
                          Response response;

                          var url =
                              "https://api.lcsbridge.com/tracking/jobs/upload/save/${widget.id}";
                          // ?api_token=$apiToken&company_id=$companyID&domain=$domain

                          FormData formData = new FormData.fromMap({
                            "api_token": apiToken,
                            "company_id": companyID,
                            "domain": domain,
                            "service_id": "$serviceID",
                            "title": "${docuTitle.text}",
                            "posting_date": "$birthDateInString",
                            "expiry_date": "$birthDateInString2",
                            "file": fileArrays,
                          });

                          try {
                            response = await dio.post(url, data: formData);
                            resPONSE = response.data;
                            var filesCount = files.length;

                            if (pr.isShowing()) await pr.hide();
                            await callingRefresh();
                            customToast(context,
                                "$filesCount Files Uploaded successfully for ${widget.rowID}");
                            setState(() {
                              dropDownValueST = "Select";
                              serviceDocS.clear();
                              serviceDocS.add("Select");

                              serviceDocS.clear();
                              serviceIDs.clear();
                              serviceID = 0;
                              docuTitle.text = "";
                              serviceIDs.add(0);
                              if (files.length > 0) {
                                fileArrays.clear();
                                files.clear();
                                filePaths.clear();
                              }
                              callingServiceAPI();
                            });
                            setState(() {});
                          } catch (e) {
                            if (e.response.statusCode == 401) {
                              files.clear();
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

                              if (pr.isShowing()) await pr.hide();

                              customToast(context, "Contact Tech team");
                            }
                          }
                        }
                        setState(() {});
                      },
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
              ],
            ),
          ),
        )),
      ),
    );
  }

  callingRefresh() async {
    var response = await http.get(
        "https://api.lcsbridge.com/tracking/job/${widget.id}?api_token=$apiToken&company_id=$companyID&domain=$domain");

    jobDetails = json.decode(response.body);
  }

  int _state = 0;
  Widget setUpButtonChildForUPLOAD() {
    if (_state == 0) {
      return Container(
        height: 45.0,
        width: 360.0,
        decoration: new BoxDecoration(
          border: new Border.all(
              color: Color(0xff1a73e8), width: 5.0, style: BorderStyle.solid),
          borderRadius: new BorderRadius.circular(100.0),
        ),
        child: new Container(
          height: 35.0,
          width: 200.0,
          decoration: new BoxDecoration(
            border: new Border.all(
                color: Color(0xff1a73e8), width: 5.0, style: BorderStyle.solid),
            borderRadius: new BorderRadius.circular(100.0),
          ),
          child: Container(
            color: Color(0xff1a73e8),
            child: Center(
              child: Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontFamily: "Gilory-Medium",
                ),
              ),
            ),
          ),
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      );
    } else {
      return Icon(Icons.check, color: Colors.black);
    }
  }

  void animateButton() {
    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 11000), () {
      setState(() {
        _state = 0;
      });
    });

    Timer(Duration(milliseconds: 10000), () {
      setState(() {
        dropDownValueST = "Select";
        serviceDocS.clear();
        serviceDocS.add("Select");
        serviceDocS.clear();
        serviceIDs.clear();
        serviceID = 0;
        docuTitle.text = "";
        serviceIDs.add(0);
        if (files.length > 0) {
          fileArrays.clear();
          files.clear();
          filePaths.clear();
        }

        callingServiceAPI();
        setState(() {});
      });
    });
  }

  Future<FormData> formData1() async {
    return FormData.fromMap({
      "service_id": serviceID,
      "title": docuTitle.text,
      "posting_date": birthDateInString,
      "expiry_date": birthDateInString2,
      "file": fileArrays,
    });
  }
}

var resPONSE;
