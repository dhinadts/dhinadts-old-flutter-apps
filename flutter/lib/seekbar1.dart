// import 'package:flutter/material.dart';
// import 'package:dhina/db/sharedpref.dart';

// import 'main_pages/starting4.dart';
// // void main() => runApp(MyApp());

// var prefs = Shared_Preference();
// var fontSize1 = 0;
// double valueHolder = 0.0;

// class MyAppSeek extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//             appBar: AppBar(title: Text('Slider Seekbar in Flutter')),
//             body: Center(child: SliderWidget())));
//   }
// }

// class SliderWidget extends StatefulWidget {
//   @override
//   SiderWidgetState createState() => new SiderWidgetState();
// }

// class SiderWidgetState extends State {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Column(children: [
//       AlertDialog(
//         title: Text(
//           "Alert Dialog",
//           textAlign: TextAlign.center,
//         ),
//         content: new Slider(
//           value: valueHolder.toDouble(),
//           min: 0,
//           max: 10,
//           divisions: 2,
//           activeColor: Colors.green,
//           inactiveColor: Colors.grey,
//           label: '${valueHolder.round()}',
//           onChanged: (double newValue) {
//             setState(()  {
//               valueHolder = newValue.round() as double;
//               print("Changed newValue: ${newValue.round()}");
//               prefs.setdouble("fontSize1", valueHolder);
              
//             });
//           },
//           // semanticFormatterCallback: (double newValue) {
//           //   print("newValue: $newValue");
//           //   return '${newValue.round()}';
//           // }
//         ),
//         contentPadding: EdgeInsets.all(60.0),
//         // shape: CircleBorder(),
//         //   Container(
//         //     margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
//         //     child:

//         //     Slider(
//         //         value: valueHolder.toDouble(),
//         //         min: 1,
//         //         max: 100,
//         //         divisions: 100,
//         //         activeColor: Colors.green,
//         //         inactiveColor: Colors.grey,
//         //         label: '${valueHolder.round()}',
//         //         onChanged: (double newValue) {
//         //           setState(()   {
//         //             valueHolder = newValue.round();
//         //             print("Changed newValue: ${newValue.round()}");
//         //             prefs.setint("fontSize1", newValue.round());

//         //             print(fontSize1);
//         //           });
//         //         },
//         //         // semanticFormatterCallback: (double newValue) {
//         //         //   print("newValue: $newValue");
//         //         //   return '${newValue.round()}';
//         //         // }
//         //     )),
//         // Text('$valueHolder', style: TextStyle(fontSize: 22),)
//       )
//     ]));
//   }
// }
