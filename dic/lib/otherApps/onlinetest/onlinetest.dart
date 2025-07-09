import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

String url2;
final onlineTestURL = 'https://www.nithra.mobi/quiz/getquiz.php';

class OnlineTest {
  final String type;

  OnlineTest({
    this.type,
  });

  factory OnlineTest.fromJson(Map<String, dynamic> json) {
    return OnlineTest(
      type: json['type'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["type"] = type;
    return map;
  }
}

class TodayE {
  final date;
  final String type;

  TodayE({this.date, this.type});

  factory TodayE.fromJson(Map<String, dynamic> json) {
    return TodayE(
      date: json['date'],
      type: json['type'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["date"] = date;
    map["type"] = type;
    return map;
  }
}

Future<OnlineTest> createOnlineTest(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    print(OnlineTest.fromJson(json.decode(response.body)));
    return OnlineTest.fromJson(json.decode(response.body));
  });
}

class OnlineTestWord extends StatelessWidget {
  final Future<OnlineTest> post;

  OnlineTestWord({Key key, this.post}) : super(key: key);

  TextEditingController bodyControler = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: "WEB SERVICE",
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('OnlineTest'),
          ),
          body: new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new Column(
              children: <Widget>[
                new RaisedButton(
                  onPressed: () async {
                    var now1 = DateTime.now();
                    print(new DateFormat("dd\/MM\/yyyy")
                        .format(now1)); // => 21-04-2019
                    OnlineTest newOnlineTest = new OnlineTest(
                      type: 'VOT',
                    );

                    var response = await http.post(onlineTestURL,
                        body: newOnlineTest.toMap());

                    // OnlineTest p = await createOnlineTest(CREATE_OnlineTest_URL,
                    //     body: newOnlineTest.toMap());
                    //  print(p.title);
                    print("rrrr $response ");
                    print("${json.decode(response.body)}");
                    test1 = json.decode(response.body);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TestsPage()),
                    );
                  },
                  child: const Text("OnlineTest Date"),
                ),
              ],
            ),
          )),
    );
  }
}

var test1;

class TestsPage extends StatefulWidget {
  @override
  TestsPageState createState() => TestsPageState();
}

class TestsPageState extends State<TestsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Align(
            // alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.all(10.0), // (10.0),
              padding: const EdgeInsets.all(10.0),
              height: 50,
              width: 150,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "OnlineTest",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              decoration: new BoxDecoration(
                  border: new Border.all(style: BorderStyle.solid),
                  /* top: new BorderSide(),
                        bottom: new BorderSide(),
                        left: new BorderSide(),
                        right: new BorderSide(),),  */
                  borderRadius: BorderRadius.circular(12)),
            ),
            alignment: Alignment(-0.5, -0.2),
          ),
          // actions: <Widget>[
          //   Text(" "),
          // ],
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
        body: 
            Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: new ListView.builder(
                    itemCount: test1.length,
                    itemBuilder: (context, i) {
                      return new ListTile(
                        title: GestureDetector(
                          onTap: () async {
                            url2 = url1 + test1[i]['testname'];
                            testTitle = test1[i]['testname'];
                            print(url2);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TestPages()),
                            );
                          },
                          child: Container(
                              child: new ListTile(
                                title: new Text(test1[i]['testname']),
                              ),
                              decoration: new BoxDecoration(
                                  border: new Border(
                                top: new BorderSide(),
                                bottom: new BorderSide(),
                                left: new BorderSide(),
                                right: new BorderSide(),
                              )) 
                              ),

                          /* ListTile(
                    title: Text(
                      test1[i]['testname'],
                    ),
                  ), */
                        ),
                      );
                    },
                  ),
                )));
  }
}

var testTitle;

String url1 = "https://www.nithra.mobi/quiz/showquiz.php?tname=";

class TestPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var title = testTitle;
    return new Scaffold(
        /* appBar: AppBar(
          title: Text(testTitle),
        ), */
        body: WebviewScaffold(
          url: url2,
        ));
  }
}
