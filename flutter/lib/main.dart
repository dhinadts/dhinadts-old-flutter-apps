
import 'package:dhina/SimpleSlider1.dart';
import 'package:dhina/cate2pgview.dart';
import 'package:dhina/db/dbhelper.dart';
import 'package:dhina/pages/newDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:splashscreen/splashscreen.dart';


double dummy = 15.0;

// void main() => runApp(new MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Thirukkural',
//       theme: new ThemeData(
//         primarySwatch: Colors.blueGrey,
//       ),
//       home: SplashScreenPage(title: 'Thirukkural'),
//        routes: {

//         'Home': (context) => MyApp12345(),

//       },
//       debugShowCheckedModeBanner: false,
//     );
//   }

// }

List<Map<String, dynamic>> newData1;
var newData;
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
class SplashScreenPage extends StatefulWidget {
  SplashScreenPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        // Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage('assets/spalsh_image.jpg'),
        //         fit: BoxFit.cover
        //     ) ,
        //   ),
        //   child: Center(
        //     child: CircularProgressIndicator(
        //       valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
        //     ),
        //   ),
        // );

        new SplashScreen(
            seconds: 5,
            navigateAfterSeconds: 'Home', //route
            // title: new Text(
            //   'Nithra Edu Solutions',
            //   style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            // ),
            image: new Image.asset('assets/front.png'),
            //backgroundColor: Colors.white,
            //styleTextUnderTheLoader: new TextStyle(fontSize: 0),
            loaderColor: Colors.blue,
            photoSize: 150.0);
  }
}
// Widget build(BuildContext context) {
//   return new Row(
//     children: <Widget>[
//       Text("data"),
//       Text("data"),
//     ],
//   )
// }

var dbhelp = DatabaseHelper();
var db = DatabaseHelper();
var payloadNo=1;

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() => runApp(new HomePageMain());

class HomePageMain extends StatefulWidget {
  HomePageMain({Key key}) : super(key: key);


  @override
  _HomePageMainState createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMain> {
  var payloadString;

  

  

  @override
  Widget build(BuildContext context) {
// String noti = "LocalNoti(payload: payloadString, payload_kural_no: payloadNo,)";
    return new MaterialApp(
      title: 'Thirukkural',
      theme: new ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyApp12345(),  // SplashScreenPage(title: 'Thirukkural'), //
      routes: {
        'Home': (context) => MyApp12345(),
      },
      // initialRoute: noti,
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  void initState() {
    // todo: implement initState
    @override
    Future<String> _loadAStudentAsset() async {
      newData = await rootBundle.loadString('assets/complete1.json');
      // await db.db_move();
    }
    // flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    // var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    // var iOS = new IOSInitializationSettings();
    // var initSetttings = new InitializationSettings(android, iOS);
    // flutterLocalNotificationsPlugin.initialize(initSetttings,
    //     onSelectNotification: onSelectNotification);
    //             _showDailyAtTime();
getFontSize() async {
    dummy = await prefs.getDouble("FontSizeDummy"); 
  }

    dbmove() async {
      await db.db_move();
      newData1 =
          await db.any_query("select * from complete1", "modi_kural_comp.db");
      // newData1 = await db.any_query("select * from complete1", "modi_kural_comp.db");
      ResultFav = await db.any_query(
          'SELECT * from complete', //1 where isfav=1',
          //1 where isfav=1',
          "modi_kural_comp.db");
    }

    //   loadDb() async {

    // }

    super.initState();
    

    dbmove();
    getFontSize();
    
    // final _random = new Random();
    // var values = newData1.toList();
    // var element = values[_random.nextInt(values.length)];
    // payloadNo = element['kural_no'];
    // payloadString = element['kural_tamil1'];
    //  flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    // var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    // var iOS = new IOSInitializationSettings();
    // var initSetttings = new InitializationSettings(android, iOS);
    // flutterLocalNotificationsPlugin.initialize(initSetttings,
    //     onSelectNotification: onSelectNotification);
    //     _showDailyAtTime();
// showNotification();
    // dbhelp.db_move();
    _loadAStudentAsset();
//              _showDailyAtTime();

  }
  // Future onSelectNotification(String payload) {
  //   debugPrint("payload : $payload");
  //   return Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => MyApp444(
  //                           value: payloadNo - 1,
  //                           currentPageValue: payloadNo - 1,
  //                           fontSize1: 0,
  //                         )),
  //               );
  // }
  // Future<void> _showDailyAtTime() async {
  //   final _random = new Random();
  //   var values = newData1.toList();
  //   var element = values[_random.nextInt(values.length)];
  //   payloadNo = element['kural_no'];
  //   // print("element: $element");
  //   print("Random Kural No: ${element['kural_no']}");
  //   var time = new Time(12, 00, 0);
  //   var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
  //       'repeatDailyAtTime channel id',
  //       'repeatDailyAtTime channel name',
  //       'repeatDailyAtTime description');
  //   var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  //   var platformChannelSpecifics = new NotificationDetails(
  //       androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.showDailyAtTime(
  //       0,
  //       'தினம் ஒரு குறள்',
  //       'இன்றைய குறள்',
  //       time,
  //       platformChannelSpecifics, payload: "MainFunction"  );// element['kural_tamil1']);
  // }
}
