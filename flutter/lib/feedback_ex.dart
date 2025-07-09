import 'dart:async';
import 'dart:convert' show utf8;
import 'dart:convert';

import 'package:dhina/pages/home_page.dart';
import 'package:dhina/pages/newDrawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dhina/fragments/privacy_link.dart';
import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

// import 'device.dart';

var url = 'https://www.nithra.mobi/apps/appfeedback.php';
// var url = 'http://localhost:3000/addfeedback';

// print(await http.read('https://www.nithra.mobi/apps/appfeedback.php'));

String inf3;
String summa = "";

DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

fetchDeviceInfo() async {
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo;
    androidInfo = await deviceInfo.androidInfo;
    print("print: ${androidInfo.device}");
    print("print: ${androidInfo.id}");
    print(" version ${androidInfo.version}");
    print("brand    ${androidInfo.brand}");
    print("host    ${androidInfo.host}");
    print("manufacturer    ${androidInfo.manufacturer}");
    print("model    ${androidInfo.model}");
    inf3 = androidInfo.manufacturer + " " + androidInfo.model;
    print("Info: $inf3");
    summa = inf3;
    return inf3;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    inf3 = iosInfo.model;
    print("model    ${iosInfo.model}");

    summa = inf3;

    print('Running on ${iosInfo.utsname.machine}');
  }
}

String versionName;
String versionCode;
String vCode;
versions() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  versionName = packageInfo.version;
  versionCode = packageInfo.buildNumber;
  vCode = versionName + " " + versionCode;
  return versionName;
}

// String iNF1 = androidInfo.manufacturer + " " + androidInfo.model;

class Post {
  final String type = "thirukkural";
  final String vcode; // = "1.0.0";
  final String email;
  final String feedback;
  final String model;

  Post({type, this.vcode, this.model, this.email, this.feedback});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      type: json['type'],
      vcode: json['vcode'],
      email: json['email'],
      feedback: json['feedback'],
      model: json['model'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["type"] = type;
    map["vcode"] = vcode;
    map["email"] = email;
    map["feedback"] = feedback;
    map["model"] = model;
    return map;
  }
}
String headers = "{'Content-Type' : 'application/x-www-form-urlencoded; charset=utf-8'}";
// headers: { 'Content-Type' : 'application/x-www-form-urlencoded; charset=utf-8'},
Future<Post> createPost(String url,  {Map body}) async {
  return http.post(url,  body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    } else {

      print(Post.fromJson(json.decode(response.body)));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return Post.fromJson(json.decode(response.body));
    }
  });
}

class Feedback_ex extends StatelessWidget {
  final Future<Post> post;

  Feedback_ex({Key key, this.post}) : super(key: key);
  // static final CREATE_POST_URL = 'https://www.nithra.mobi/apps/appfeedback.php';
  static final CREATE_POST_URL = 'https://www.nithra.mobi/apps/appfeedback.php'; // var url = 'https://www.nithra.mobi/apps/appfeedback.php';

  TextEditingController titleControler = new TextEditingController();
  TextEditingController bodyControler = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: "WEB SERVICE",
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
      home: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text(
              'உங்கள் கருத்து',
              textAlign: TextAlign.center,
            ),
          ),
          body: new Container(
  //           decoration: BoxDecoration(
  //   gradient: RadialGradient(
  //     center: const Alignment(-0.5, -0.6),
  //     radius: 0.15,
  //     colors: <Color>[
  //       const Color(0xFFEEEEEE),
  //       const Color(0xFF111133),
  //     ],
  //     stops: <double>[0.9, 1.0],
  //   ),
  // ),
constraints: BoxConstraints.expand(),
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: 
            // new Card(
              // height: 500.0,
              // width: 300,
              // child: 
            new Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new TextField(
                  controller: titleControler,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.email),
                      // contentPadding:
                      //     const EdgeInsets.symmetric(vertical: 20.0),
                      hintText: "மின்னஞ்சல்....",
                      labelText: 'மின்னஞ்சல்'),
                ),
                new TextField(
                  controller: bodyControler,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.feedback),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 50.0),
                      hintText: "கருத்து....",
                      labelText: 'கருத்துக்களை பதியவும்'),
                ),
                new Text('     '),
                new GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp2()),
                    );
                  },
                  child: Text("* தனியுரிமைக் கொள்கை", textAlign: TextAlign.center,),
                ),
                new Text('     '),
                new RaisedButton(
                  onPressed: () async {
                    var connectivityResult =
                        await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile ||
                        connectivityResult == ConnectivityResult.wifi) {
                      print("// I am connected to a mobile network.");

                      // HttpClient http = HttpClient();
                      // try {
                      //   // Use darts Uri builder
                      //   var uri =
                      //       Uri.http('localhost:3000', '/');
                      //   var request = await http.getUrl(uri);
                      //   var response = await request.close();
                      //   var responseBody =
                      //       await response.transform(utf8.decoder).join();
                      //       print(responseBody);
                      //   // The dog.ceo API returns a JSON object with a property
                      //   // called 'message', which actually is the URL.
                      // } catch (exception) {
                      //   print(exception);
                      // }
                      await fetchDeviceInfo();
                      await versions();
                      var email = (titleControler.text);
                      var feedback = (bodyControler.text);
                      var em = utf8.encode(email);
                      var fdbc = utf8.encode(feedback);
                      var mod = utf8.encode(summa);
                      var vc = utf8.encode(vCode);
                      Post newPost = new Post(
                        email: email, // em.toString(),
                        feedback: feedback, // fdbc.toString(),
                        model: summa, // mod.toString(),
                        vcode: vCode, // vc.toString(),
                      );
                      var ex = json.encode(newPost.toMap());
                      // var ex1 = utf8.encode(newPost.email);

                      //  Post p = await createPost(CREATE_POST_URL,
                      //      body: newPost.toMap(),);
                      //  print(p.email);
                      // http.Response response = await dio.post(url,
                      //     data: newPost,
                      //     options: new Options(
                      //         contentType: ContentType.parse(
                      //             "application/x-www-form-urlencoded")));
                      // dio.post("/info",
                      //     data: body,
                      // options: new Options(
                      //     contentType: ContentType.parse(
                      //         "application/x-www-form-urlencoded")));

                      //var headers="application/x-www-form-urlencoded";
                      var response = await http.post(
                        url,
                        headers: {
                           "Content-Type": 'application/x-www-form-urlencoded; charset=utf-8',
                           },
                        body:  (newPost.toMap()), //json.decode(ex), // JsonEncoder().convert
                        
                           // "Content-Language": "en-us; charset=windows-1252"
                      //     //    "application/x-www-form-urlencoded; charset=utf-8",
                      //     // //       // "application/x-www-form-urlencoded; charset=utf-8",
                      //     //     'accept': 'application/json',
                      //     // //    'Accept-Language': '*, en',
                      //     //     'Content-Language': 'en'
                      //   },
                      //   // headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' , 'accept': 'application/json' },
                      //   //headers: { 'accept': 'application/json', 'Content-Type': 'application/json'},//"application/x-www-form-urlencoded"},
                      //   // 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
                        encoding: Encoding.getByName("utf-8"),
                       );
                       print('Response status: ${response.statusCode}');
                       print('Response body: ${response.body}');
                      print(utf8.encode(newPost.email));
                      print(newPost.feedback);
                      print("model:" + newPost.model);
                      print("ex.. $ex");
                      
                      print("newPost..$ex,,,, $newPost");
                      Fluttertoast.showToast(
                          msg: "your feedback was sent succussfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.red[100],
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp12345()),
                      );
                      // print($iNF1);
                    }
                    // else if (connectivityResult == ConnectivityResult.wifi) {
                    //   print("// I am connected to a wifi network.");
                    // }
                    else {
                      // no connectivity and check your netwrk connection
                      Fluttertoast.showToast(
                          msg: "உங்கள் இணைய இணைப்பைச் சரிபார்க்கவும்",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.red[100],
                          textColor: Colors.white,
                          fontSize: 16.0);
                      print('No connection');
                    }
                    // String exs = versions();
                  },
                  child: const Text("அனுப்பு"),
                )
              ],
           ) ),
          // )
          ),
      debugShowCheckedModeBanner: false,
    );
  }
}

/*

import 'dart:convert';
import 'package:http/http.dart';


makePostRequest() async {

  final uri = 'http://httpbin.org/post';
  final headers = {'Content-Type': 'application/json'};
  Map<String, dynamic> body = {'id': 21, 'name': 'bob'};
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  Response response = await post(
    uri,
    headers: headers,
    body: jsonBody,
    encoding: encoding,
  );

  int statusCode = response.statusCode;
  String responseBody = response.body;
}

*/
