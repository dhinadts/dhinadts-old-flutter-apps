import 'dart:async';
import 'dart:math';
import 'package:dhina/SimpleSlider1.dart';
import 'package:dhina/fragments/first_fragment.dart';
import 'package:dhina/newMainpage1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/cupertino.dart';


import 'main.dart';

//  void main() => runApp(new MaterialApp(home: new MyApp()));

bool _value1 = true;
var abcd = MyApp444();
var payloadNo;
int hh = 06, mm = 30, ss =00;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
class LocalNoti extends StatefulWidget {
  final String payload;
  final int payload_kural_no;
  LocalNoti({Key key, this.payload, this.payload_kural_no}) : super(key: key);
  @override
  _LocalNotiState createState() => _LocalNotiState();
}

class _LocalNotiState extends State<LocalNoti> {
  TextEditingController _hhController = TextEditingController();
  TextEditingController _mmController = TextEditingController();
  TextEditingController _ssController = TextEditingController();

  double _fontSize11 = 0.0;

  void _showFontSizePickerDialog() async {
    // <-- note the async keyword here

    // this will contain the result from Navigator.pop(context, result)
    _fontSize11 = await prefs.getDouble("fontSize1");

    final selectedFontSize = await showDialog<double>(
      context: context,
      builder: (context) => FontSizePickerDialog(initialFontSize: _fontSize11),
    );

    // execution of this code continues when the dialog was closed (popped)

    // note that the result can also be null, so check it
    // (back button or pressed outside of the dialog)
    if (selectedFontSize != null) {
      setState(() {
        _fontSize11 = selectedFontSize;
      });
      a = _fontSize11;
      print(_fontSize11);
      await prefs.setdouble("fontSize1", _fontSize11);
    }
  }

  @override
  void initState() {
    super.initState();
    

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
    _showDailyAtTime();
    showNotification();
    
    
  }

  Future onSelectNotification(String payload) {
    debugPrint("payload : $payload");
    return
        Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyApp444(
                                value: payloadNo - 1,
                                currentPageValue: payloadNo - 1,
                                fontSize1: 0,
                              )),
                    );
      //   showDialog(
      // context: context,
      // builder: (_) => new AlertDialog(
      //   title: new Text('Notification'),
      //   content: new Text('${widget.payload}'),
      //   actions: <Widget>[
      //     FlatButton(
      //         child: Text("Yes"),
      //         onPressed: () {
      //           Navigator.of(context).pop();

      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => MyApp444(
      //                       value: (widget.payload_kural_no) - 1,
      //                       currentPageValue: (widget.payload_kural_no) - 1,
      //                       fontSize1: 0,
      //                     )),
      //           ); // fontSize11),);
      //         }),
      //     FlatButton(
      //         child: Text("No"),
      //         onPressed: () {
      //           // Navigator.of(context, rootNavigator: false).pop();
      //           Navigator.pop(context);

      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => MyApp444(
      //                       value: (widget.payload_kural_no) - 1,
      //                       currentPageValue: (widget.payload_kural_no) - 1,
      //                       fontSize1: 0,
      //                     )),
      //           ); // fontSize11),);
      //           // Navigator.of(context).pop();
      //         }),
      //   ],
      // ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('அமைப்புகள்'),
      ),
      body: Column(children: <Widget>[
        Row(children: <Widget>[
          new RaisedButton(
            onPressed: _showDailyAtTime, //  _showDailyAtTime,
            child: new Text(
              'தினம் ஒரு குறள்',
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          new Checkbox(value: _value1, onChanged: _value1Changed),
        ]),
        /*
        
        RaisedButton(
          child: Text("Notification at 9.00 AM daily"),
          onPressed: _showDailyAtTime,
        ),
        RaisedButton(
          child: Text("setting time manually"),
          onPressed: null, //setingTime
        ),
        Row(children: <Widget>[
          new Flexible(
              child: TextField(
            controller: _hhController,
            decoration: InputDecoration(
              hintText: "hour",
              //border: new OutlineInputBorder(borderRadius: new BorderRadius.circular(25.0),  ),
            ),
          )),
          new Text(" : "),
          new Flexible(
              child: TextField(
            controller: _mmController,
            decoration: InputDecoration(
              hintText: "minutes",
              //border: new OutlineInputBorder(borderRadius: new BorderRadius.circular(25.0),  ),
            ),
          )),
          new Text(" : "),
          new Flexible(
              child: TextField(
            controller: _ssController,
            decoration: InputDecoration(
              hintText: "seconds",
              //border: new OutlineInputBorder(borderRadius: new BorderRadius.circular(25.0),  ),
            ),
          )),
          RaisedButton(
            child: Text("OK"),
            onPressed: () async {
              var abcd = (_hhController.text).toString();

              hh = int.parse(abcd);
              abcd = (_mmController.text).toString();
              mm = int.parse(abcd);
              abcd = (_ssController.text).toString();
              ss = int.parse(abcd);
              setingTime();
            },
          ),
        ]),
        */
        Row(children: <Widget>[
        DropdownButton<int>(
          value: hh,
          // icon: Icon(Icons.arrow_downward),
          hint: Text("hh:"),
          iconSize: 50,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (int newValue) {
            setState(() {
              hh = newValue;
            });
          },
          items: <int>[00, 01, 02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23]
              .map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text("$value"),
            );
          }).toList(),
        ),
        DropdownButton<int>(
          value: mm,
          // icon: Icon(Icons.arrow_downward),
          hint: Text("mm:"),
          iconSize: 50,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (int newValue) {
            setState(() {
              mm = newValue;
            });
          },
          items: <int>[00, 01, 02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59]
              .map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text("$value"),
            );
          }).toList(),
        ),
        DropdownButton<int>(
          value: ss,
          // icon: Icon(Icons.arrow_downward),
          hint: Text("ss:"),
          iconSize: 50,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (int newValue) {
            setState(() {
              ss = newValue;
            });
          },
          items: <int>[00, 01, 02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59]
              .map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text("$value"),
            );
          }).toList(),
        ),
        RaisedButton(
          child: Text("Set It"),
          onPressed: () async {
            
            await setingTime();
          },
        ),
        ]
      ),
       /*
        RaisedButton(
          child: Text("Use Intent"),
          onPressed: () {

        //     var aaaa = NotificationAppLaunchDetails( true, widget.payload

        //     );
        //     print(aaaa.didNotificationLaunchApp);
            
        // android_intent.Intent()
        //           ..setAction(android_action.Action.ACTION_ATTACH_DATA)
        //           // ..setData(payloadNo-1)
        //           ..startActivityForResult().then(
        //                 (payload) => Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => MyApp444(
        //                         value: payloadNo - 1,
        //                         currentPageValue: payloadNo - 1,
        //                         fontSize1: 0,
        //                       )),
        //             ),
        //             onError: (e) =>
        //                 print(e.toString()));
                  
        
        
        //      android_intent.Intent()
        //  ..setAction(android_action.Action.ACTION_SHOW_APP_INFO)
        // ..putExtra(Extra.EXTRA_PACKAGE_NAME, "com.whatsapp")
        // ..startActivity().catchError((e) => print(e));
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => DropDown1()),
            // );
          },
        ),   
        
        RaisedButton(
          child: Text("Font Size Vary"),
          onPressed: _showFontSizePickerDialog,
        ),
        */
        IconButton(
          icon: const Icon(Icons.text_format),
          onPressed: () {
            _showFontSizePickerDialog();
          },
        ),
        /*
        RaisedButton(
          child: Text("Random Kural"),
          onPressed: randomKural,
        ),
        */
      ]),
    );
  }

  showNotification() async {
    final _random = new Random();
    var values = newData1.toList();
    var element = values[_random.nextInt(values.length)];
    payloadNo = element['kural_no'];
    // print("element: $element");
    print("Random Kural No: ${element['kural_no']}");
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'தினம் ஒரு குறள்', element['kural_tamil1'], platform,
        payload: '${element['kural_tamil1']}');
  }

  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }

  Future<void> _showDailyAtTime() async {
    final _random = new Random();
    var values = newData1.toList();
    var element = values[_random.nextInt(values.length)];
    payloadNo = element['kural_no'];
    // print("element: $element");
    print("Random Kural No: ${element['kural_no']}");
    var time = new Time(15, 45, 0);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'தினம் ஒரு குறள்',
        'இன்றைய குறள்',
        time,
        platformChannelSpecifics,
        payload: element['kural_tamil1']);
  }

  void _value1Changed(bool value) {
    setState(() {
      _value1 = value;
    });
    if (_value1 == true) {
      print("$_value1");
      // showNotification();
      _showDailyAtTime();
    } else {
      print("Local Ntification else part");
    }
  }

  Future setingTime() async {
    final _random = new Random();
    var values = newData1.toList();
    var element = values[_random.nextInt(values.length)];
    payloadNo = element['kural_no'];
    // print("element: $element");
    var time = new Time(hh, mm, ss);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'தினம் ஒரு குறள்',
        'இன்றைய குறள்',
        time,
        platformChannelSpecifics,
        payload: element['kural_tamil1']);
  }

  void randomKural() {
    final _random = new Random();
    var values = newData1.toList();
    var element = values[_random.nextInt(values.length)];
    // print("element: $element");
    print("Random Kural No: ${element['kural_no']}");
  }
}

Future<void> _showDailyAtTime() async {
  final _random = new Random();
  var values = newData1.toList();
  var element = values[_random.nextInt(values.length)];
  payloadNo = element['kural_no'];
  // print("element: $element");
  print("Random Kural No: ${element['kural_no']}");
  var time = new Time(15, 45, 0);
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      'repeatDailyAtTime description');
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.showDailyAtTime(
      0, 'தினம் ஒரு குறள்', 'இன்றைய குறள்', time, platformChannelSpecifics,
      payload: element['kural_tamil1']);
}
