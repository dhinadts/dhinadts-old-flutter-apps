import 'dart:io';
import 'dart:io' as Io;
import 'package:animated/loginPage.dart';
import 'package:animated/utility_basics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets.dart';
import 'main.dart';

class StateMents extends StatefulWidget {
  const StateMents({Key key}) : super(key: key);

  @override
  _StateMentsState createState() => _StateMentsState();
}

class _StateMentsState extends State<StateMents> {
  // bool startD = false;

  @override
  void dispose() {
    super.dispose();
    // startD = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Material(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 7.0,
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("$loggedName",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Gilory-Medium",
                            fontWeight: FontWeight.w900,
                            fontSize: 24.0)),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text("$cusRowNo",
                        style: TextStyle(
                            fontFamily: "Gilory-Medium",
                            fontWeight: FontWeight.w900,
                            fontSize: 18.0))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Text("450,000",
                        style: TextStyle(
                            fontFamily: "Gilory-Medium",
                            color: Colors.grey[900],
                            fontWeight: FontWeight.w900,
                            fontSize: 38.0)),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("SAR",
                        style: TextStyle(
                            fontFamily: "Gilory-Medium",
                            color: Colors.grey[900],
                            fontWeight: FontWeight.w900,
                            fontSize: 18.0))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    Text("CLICK BELOW TO DOWNLOAD",
                        style: TextStyle(
                            fontFamily: "Gilory-Medium",
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w900,
                            fontSize: 14.0)),
                    // SizedBox(height:10.0,),
                    Text("YOUR STATEMENT",
                        style: TextStyle(
                            fontFamily: "Gilory-Medium",
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w900,
                            fontSize: 14.0)),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: ButtonTheme(
                        height: 50.0,
                        // minWidth: 88,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0)),
                        child: RaisedButton(
                            color: Color(0xff4f48ff),
                            onPressed: () async {
                              var testing =
                                  await Permission.storage.request();

                              if (testing.isGranted == true) {
                                var dir = await getExternalStorageDirectory();
                                String str =
                                    "https://api.lcsbridge.com/tracking/pdf/download?api_token=$apiToken&company_id=$companyID&domain=$domain";

                                if (apiToken == null) {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();

                                  await prefs.setInt("loggedIN", null);

                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginScreen()));
                                } else {
                                  /*  setState(() {
                                    startD = true;
                                  }); */
                                  String fileNameS = "Statement.pdf";
                                  String aaaaa = "${dir.path}" +
                                      Platform.pathSeparator +
                                      "BridgeLCS";
                                  var testdir =
                                      await new Io.Directory('$aaaaa')
                                          .create(recursive: true);
                                  final taskId =
                                      await FlutterDownloader.enqueue(
                                    url: str,
                                    fileName: fileNameS,
                                    savedDir: testdir.path,
                                    showNotification: true,
                                    openFileFromNotification: true,
                                    requiresStorageNotLow: true,
                                  );

                                  /*  setState(() {
                                    startD = false;
                                  });
 */
                                  FlutterDownloader.open(taskId: taskId);
                                  customToast(context,
                                      "Statement downloded successfully");
                                }
                              }
                            },
                            child:
                                /*  startD == true
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "DOWNLOADING",
                                      style: submitButton(),
                                    ),
                                  )
                                :  */
                                Center(
                              child: Text(
                                "DOWNLOAD",
                                style: submitButton(),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
