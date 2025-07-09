// // import 'dart:async';

// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';

// // void main() => runApp(DateTimePicker());


// // class DateTimePicker extends StatelessWidget {
// //   const DateTimePicker(
// //       {Key key,
// //       this.labelText,
// //       this.selectedDate,
// //       this.selectedTime,
// //       this.selectDate,
// //       this.selectTime})
// //       : super(key: key);

// //   final String labelText;
// //   final DateTime selectedDate;
// //   final TimeOfDay selectedTime;
// //   final ValueChanged<DateTime> selectDate;
// //   final ValueChanged<TimeOfDay> selectTime;

// //   Future<void> _selectDate(BuildContext context) async {
// //     final DateTime picked = await showDatePicker(
// //         context: context,
// //         initialDate: selectedDate,
// //         firstDate: new DateTime(1970, 8),
// //         lastDate: new DateTime(2101));
// //     if (picked != null && picked != selectedDate) selectDate(picked);
// //   }

// //   Future<void> _selectTime(BuildContext context) async {
// //     final TimeOfDay picked =
// //         await showTimePicker(context: context, initialTime: selectedTime);
// //     if (picked != null && picked != selectedTime) selectTime(picked);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final TextStyle valueStyle = Theme.of(context).textTheme.body1;
// //     return new Row(
// //       crossAxisAlignment: CrossAxisAlignment.end,
// //       children: <Widget>[
// //         new Expanded(
// //           flex: 4,
// //           child: new _InputDropdown(
// //             labelText: labelText,
// //             valueText: new DateFormat.yMMMd().format(selectedDate),
// //             valueStyle: valueStyle,
// //             onPressed: () {
// //               _selectDate(context);
// //             },
// //           ),
// //         ),
// //         const SizedBox(width: 12.0),
// //         new Expanded(
// //           flex: 3,
// //           child: new _InputDropdown(
// //             valueText: selectedTime.format(context),
// //             valueStyle: valueStyle,
// //             onPressed: () {
// //               _selectTime(context);
// //             },
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // class _InputDropdown extends StatelessWidget {
// //   const _InputDropdown(
// //       {Key key,
// //       this.child,
// //       this.labelText,
// //       this.valueText,
// //       this.valueStyle,
// //       this.onPressed})
// //       : super(key: key);

// //   final String labelText;
// //   final String valueText;
// //   final TextStyle valueStyle;
// //   final VoidCallback onPressed;
// //   final Widget child;

// //   @override
// //   Widget build(BuildContext context) {
// //     return new InkWell(
// //       onTap: onPressed,
// //       child: new InputDecorator(
// //         decoration: new InputDecoration(
// //           labelText: labelText,
// //         ),
// //         baseStyle: valueStyle,
// //         child: new Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           mainAxisSize: MainAxisSize.min,
// //           children: <Widget>[
// //             new Text(valueText, style: valueStyle),
// //             new Icon(Icons.arrow_drop_down,
// //                 color: Theme.of(context).brightness == Brightness.light
// //                     ? Colors.grey.shade700
// //                     : Colors.white70),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }


// import 'dart:async';
// import 'package:dhina/newMainpage1.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/cupertino.dart';
// //  void main() => runApp(new MaterialApp(home: new MyApp()));
// bool _value1 = true;

// class LocalNoti extends StatefulWidget {
//   final String payload;
//   final int payload_kural_no;
//   LocalNoti({Key key, this.payload, this.payload_kural_no}) : super(key: key);
//   @override
//   _LocalNotiState createState() => _LocalNotiState();
// }

// class _LocalNotiState extends State<LocalNoti> {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//   @override
//   void initState() {
//     super.initState();
//     flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
//     var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
//     var iOS = new IOSInitializationSettings();
//     var initSetttings = new InitializationSettings(android, iOS);
//     flutterLocalNotificationsPlugin.initialize(initSetttings,
//         onSelectNotification: onSelectNotification);
//   }

//   Future onSelectNotification(String payload) {
//     debugPrint("payload : $payload");
//     showDialog(
//       context: context,
//       builder: (_) => new AlertDialog(
//         title: new Text('Notification'),
//         content: new Text('${widget.payload}'),
//         actions: <Widget>[
//           FlatButton(
//               child: Text("Yes"),
//               onPressed: () {
//                 Navigator.of(context).pop();

//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => MyApp444(
//                             value: (widget.payload_kural_no) - 1,
//                             currentPageValue: (widget.payload_kural_no) - 1,
//                             fontSize1: 0,
//                           )),
//                 ); // fontSize11),);
//               }),
//           FlatButton(
//               child: Text("No"),
//               onPressed: () {
//                 // Navigator.of(context, rootNavigator: false).pop();
//                 Navigator.pop(context);

//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => MyApp444(
//                             value: (widget.payload_kural_no) - 1,
//                             currentPageValue: (widget.payload_kural_no) - 1,
//                             fontSize1: 0,
//                           )),
//                 ); // fontSize11),);
//                 // Navigator.of(context).pop();
//               }),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: new AppBar(
//         title: new Text('Flutter Local Notification'),
//       ),
//       body: Column(children: <Widget>[
        
//       Row(children: <Widget>[
//         new RaisedButton(
//           onPressed: showNotification,
//           child: new Text(
//             'தினம் ஒரு குறள்',
//             style: Theme.of(context).textTheme.headline,
//           ),
//         ),
//         new Checkbox(value: _value1, onChanged: _value1Changed),
        
//       ]),
//       RaisedButton(
//           child: Text("Daily"),
//           onPressed: _showDailyAtTime,
//         ),
//       ]),
//     );
//   }

//   showNotification() async {
// /*
//             // daily... 
//             var time = new Time(10, 0, 0);
//             var androidPlatformChannelSpecifics =
//                 new AndroidNotificationDetails('repeatDailyAtTime channel id',
//                     'repeatDailyAtTime channel name', 'repeatDailyAtTime description');
//             var iOSPlatformChannelSpecifics =
//                 new IOSNotificationDetails();
//             var platformChannelSpecifics = new NotificationDetails(
//                 androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//             await flutterLocalNotificationsPlugin.showDailyAtTime(
//                 0,
//                 'show daily title',
//                 'Daily notification shown at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
//                 time,
//                 platformChannelSpecifics);
//               }     */

// /* simple click notification  */
//             var android = new AndroidNotificationDetails(
//                 'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
//                 priority: Priority.High, importance: Importance.Max);
//             var iOS = new IOSNotificationDetails();
//             var platform = new NotificationDetails(android, iOS);
//             await flutterLocalNotificationsPlugin.show(
//                 0, 'Kural', 'Thirukkural Local Notification', platform,
//                 payload: '${widget.payload}'); 
// // periodically
// // Show a notification every minute with the first appearance happening a minute after invoking the method
// // Show a notification every minute with the first appearance happening a minute after invoking the method

//     // var time = Time(15, 50, 0);
//     // var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//     //     'repeatDailyAtTime channel id',
//     //     'repeatDailyAtTime channel name',
//     //     'repeatDailyAtTime description');
//     // var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     // var platformChannelSpecifics = NotificationDetails(
//     //     androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//     //     print("object");
//     // await flutterLocalNotificationsPlugin.showDailyAtTime(
//     //     0,
//     //     'kural',
//     //     'thirullural ${(time.hour)}:${(time.minute)}:${(time.second)}',
//     //     time,
//     //     platformChannelSpecifics, payload: widget.payload);
//   }

//   String _toTwoDigitString(int value) {
//     return value.toString().padLeft(2, '0');
//   }

// Future<void> _showDailyAtTime() async {
//     var time = Time(15, 57, 0);
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'repeatDailyAtTime channel id',
//         'repeatDailyAtTime channel name',
//         'repeatDailyAtTime description');
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.showDailyAtTime(
//         0,
//         'show daily title',
//         'Daily notification shown at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
//         time,
//         platformChannelSpecifics);
//   }


//   void _value1Changed(bool value) {
//     setState(() {
//       _value1 = value;
//     });
//     if (_value1 == true) {
//       print("$_value1");
//       showNotification();
//     } else {
//       print("Local Ntification else part");
//     }
//   }
// }
