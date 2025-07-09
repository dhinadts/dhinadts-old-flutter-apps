import 'dart:async';
import 'dart:io';
import 'package:galubetech/db/utility_basics.dart';
import 'package:galubetech/feedBackForm.dart';
import 'package:galubetech/jobs.dart';
import 'package:galubetech/supplierNew.dart';
import 'package:galubetech/widgets.dart';
import 'package:path/path.dart' as path;

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:galubetech/customer.dart';
import 'package:galubetech/dashboardNew.dart';
import 'package:galubetech/jobStatus.dart';
import 'package:galubetech/main.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  int roleFile = 0;
  List<File> files;
  var filePaths = new List();
  var serviceDocS = new List();
  var serviceIDs = new List();
  role roleSelect;

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
    roleSelect = role.insecure;

    callingServiceAPI();
  }

  callingServiceAPI() async {
    var passingPara;
    serviceDocS.add("Select");
    serviceIDs.add(0);
    Response response;
    Dio dio = new Dio();

    response = await dio.get(
        "http://api.lcsbridge.xyz/jobs/upload/form/${widget.id}?api_token='$apiToken'&company_id='$companyID'&domain=$domainCode",
        queryParameters: {
          "api_token": apiToken,
          "company_id": companyID,
          "domain": domainCode,
        });
    if (response.statusCode == 401) {
      await prefs.setint("loggedIN", 2);

      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePageEx()));
    } else {
      passingPara = response.data;
      for (var i = 0; i < passingPara["services"].length; i++) {
        serviceDocS.add(passingPara["services"][i]["description"]);
        serviceIDs.add(passingPara["services"][i]["id"]);
      }

      setState(() {});
    }
    setState(() {});
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
    roleFile = 0;
    roleSelect = role.insecure;
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
      drawer: Drawer(
        child: SafeArea(
          child: Container(
            // color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.grey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                  icon: Icon(Icons.arrow_back),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                            ),
                          ],
                        ),
                        Image.network(
                          companyLogo,
                          height: 80.0,
                          width: 150.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Editing opject");
                          },
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: CircleAvatar(
                                    child: Image.network(
                                  companyLogo,
                                  height: 30.0,
                                  width: 30.0,
                                  color: Colors.white,
                                )),
                                title: Text("$userName"),
                                subtitle: Text("$userEmail"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // SizedBox(height: 10),
                      ListTile(
                        leading: Icon(Icons.dashboard),
                        title: Text("Dashboard",
                            style: TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashBoardNew()));
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text("Customers",
                            style: TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CustomerPage(
                                        cusOrSup: 1,
                                      )));
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.people),
                        title: Text("Suppliers",
                            style: TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SuppliersPage(
                                        cusOrSup: 1,
                                      )));
                        },
                      ),
                      ListTile(
                        onTap: () async {
                          await Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Jobs()));
                        },
                        leading: Icon(Icons.edit),
                        title: Text("Jobs",
                            style: TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                      ListTile(
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JobStatus()));
                        },
                        leading: Icon(Icons.loyalty),
                        title: Text("Status",
                            style: TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                      ListTile(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FeedBack()));
                        },
                        leading: Icon(Icons.feedback),
                        title: Text("Feedback",
                            style: TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                      ListTile(
                        onTap: () async {
                          Response response;
                          Dio dio = new Dio();

                          response = await dio.get(
                              "http://api.lcsbridge.xyz/logout?api_token='$apiToken'&company_id='$companyID'&domain='$domainCode'",
                              queryParameters: {
                                "api_token": apiToken,
                                "company_id": companyID,
                                "domain": domainCode,
                              });
                          await prefs.setint("loggedIN", 2);
                          await prefs.setString("APIToken", null);
                          await prefs.setint("CompanyID", 0);
                          await prefs.setString("Domain", null);
                          await prefs.setString("CODE", null);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePageEx()));
                        },
                        leading: Icon(Icons.input),
                        title: Text("Logout",
                            style: TextStyle(
                                fontFamily: "Nunito",
                                // fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                    ],
                  ),
                  rowPrivacySecurity(context),
                  Image.asset(
                    "assets/images/logo-new.png",
                    height: 40.0,
                    //  width: 150.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return Transform.translate(
              offset: Offset(9, 0),
              child: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Color(0xff5d5d5d),
                ),
                iconSize: 30.0,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Transform.translate(
                  offset: Offset(-5, 0),
                  child: Text("File Upload",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                Transform.translate(
                  offset: Offset(-5, 0),
                  child: Text(" - ${widget.rowID}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
        iconTheme: new IconThemeData(
          color: Colors.black87, /* size: 80.0 */
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
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Document for Service*",
                        style: TextStyle(fontFamily: "Nunito", fontSize: 12.0),
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
                        borderRadius: BorderRadius.circular(6)),
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
                                    fontFamily: "Nunito",
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
                        "Document Title",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: "Nunito",
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
                        borderRadius: BorderRadius.circular(6)),
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
                    // ),
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
                          fontFamily: "Nunito",
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
                          borderRadius: BorderRadius.circular(6)),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              birthDateInString,
                              style: TextStyle(
                                // fontSize: 12.0,
                                fontFamily: "Nunito",
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
                          fontFamily: "Nunito",
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
                          borderRadius: BorderRadius.circular(6)),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              birthDateInString2,
                              style: TextStyle(
                                // fontSize: 12.0,
                                fontFamily: "Nunito",
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "File Privacy",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: "Nunito",
                        ),
                        textAlign: TextAlign.left,
                      )),
                ),

                Transform.translate(
                  offset: Offset(-25, -10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: RadioListTile(
                          value: role.insecure,
                          groupValue: roleSelect,
                          title: Transform.translate(
                              offset: Offset(-20, 0),
                              child: Text("In Secure",
                                  style: TextStyle(
                                      fontFamily: "Nunito", fontSize: 15))),
                          onChanged: (role value) {
                            setState(() {
                              roleSelect = value;
                              roleFile = 0;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: RadioListTile(
                          value: role.secure,
                          groupValue: roleSelect,
                          title: Transform.translate(
                              offset: Offset(-20, 0),
                              child: Text("Secure",
                                  style: TextStyle(
                                      fontFamily: "Nunito", fontSize: 15))),
                          onChanged: (role value) {
                            setState(() {
                              roleSelect = value;
                              roleFile = 1;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),

                DottedBorder(
                  color: Color(0xffdadce0),
                  dashPattern: [5.0, 5.0],
                  strokeWidth: 1,
                  child: Container(
                    height: 320,
                    width: 320.0,
                    child: files == null
                        ? IconButton(
                            icon: Icon(Icons.add,
                                color: Color(0xff6f9bcb), size: 100.0),
                            onPressed: () async {
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

                              // setState(() {});

                              setState(() {});
                            })
                        : GestureDetector(
                            onTap: () async {
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

                              print(files);
                              for (var i = 0; i < files.length; i++) {
                                fileArrays.add(await MultipartFile.fromFile(
                                    files[i].path,
                                    filename: path.basename(files[i].path)));
                              }
                              setState(() {});
                            },
                            child: GridView.count(
                              crossAxisCount: 2,
                              children: List.generate(files.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 100.0,
                                    child: SingleChildScrollView(
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
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
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
                      color: Color(0xff1a73e9),
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                      onPressed: () async {
                        pr = new ProgressDialog(context,
                            type: ProgressDialogType.Normal);
                        pr.style(message: 'Please Wait...');
                        pr.show();
                        var url =
                            "http://api.lcsbridge.xyz/jobs/upload/save/${widget.id}?api_token=$apiToken&company_id=$companyID&domain=$domainCode";
                        Dio dio = new Dio();
                        Response response;
                        FormData formData = new FormData.fromMap({
                          "service_id": "$serviceID",
                          "title": "${docuTitle.text}",
                          "posting_date": "$birthDateInString",
                          "expiry_date": "$birthDateInString2",
                          "privacy": "$roleFile",
                          "file": fileArrays,
                        });
                        try {
                          response = await dio.post(url, data: formData);
                          resPONSE = response.data;
                          if (pr.isShowing()) {
                            pr.hide();
                          }
                          var a = UtilityBasicS();
                          a.toastfun(resPONSE["title"]);
                          setState(() {
                            roleFile = 0;
                            roleSelect = role.insecure;
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
                          callingRefresh();
                          setState(() {});
                        } catch (e) {
                          if (e.response.statusCode == 401) {
                            await prefs.setint("loggedIN", 2);

                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePageEx()));
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
    Response response;
    Dio dio = new Dio();
    try {
      response = await dio.get(
          "http://api.lcsbridge.xyz/jobs/upload/list/${widget.id}?api_token=$apiToken&company_id=$companyID&domain=$domainCode",
          queryParameters: {
            "api_token": apiToken,
            "company_id": companyID,
            "domain": domainCode,
          });

      setState(() {
        uploadedFIles = response.data;
        secured = uploadedFIles["Secured"];
        insecured = uploadedFIles["InSecured"];
        customerFiles = uploadedFIles["Customer"];
      });
    } catch (e) {
      if (e.response.statusCode == 401) {
        await prefs.setint("loggedIN", 2);

        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePageEx()));
      }
    }
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
                  fontFamily: "Nunito",
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
        roleFile = 0;
        roleSelect = role.insecure;
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
      var a = UtilityBasicS();
      a.toastfun(resPONSE["title"]);
    });
  }

  Future<FormData> formData1() async {
    return FormData.fromMap({
      "service_id": serviceID,
      "title": docuTitle.text,
      "posting_date": birthDateInString,
      "expiry_date": birthDateInString2,
      "privacy": roleFile,
      "file": fileArrays,
    });
  }
}

var resPONSE;

enum role { insecure, secure }
