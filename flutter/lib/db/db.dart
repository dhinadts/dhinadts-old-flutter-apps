// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class JSON1 extends StatefulWidget {
//   @override
//   MyAppState createState() => MyAppState();
// }

// class MyAppState extends State<JSON1> {
//   List data;

//   @override
//   void initState() { 
//     super.initState();
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     var data1 = rootBundle.loadString("assets/complete1.json"); // as List;
//     var index = 100;
//         return Scaffold(
//             appBar: AppBar(
//               title: Text("$data1"),
//         ),
//         body: Container(
//           child: Center(
//             // Use future builder and DefaultAssetBundle to load the local JSON file
//             child: FutureBuilder(
//                 future: DefaultAssetBundle.of(context)
//                     .loadString('assets/complete1.json'),
//                 builder: (context, snapshot) {
//                   // Decode the JSON
//                   var newData = json.decode(snapshot.data.toString());

//                   return ListView.builder(
//                     // Build the ListView
//                     itemBuilder: (BuildContext context, int index) {
//                       return Card(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: <Widget>[
//                             // Text("Kural: " + newData[index]['kural_no']),
//                             Text("kural_tamil1: " + newData[index]['kural_tamil1']),
//                             Text("kuralvilakam_tamil: " + newData[index]['kuralvilakam_tamil']),
//                             Text(
//                                 "pal_tamil: " + newData[index]['pal_tamil']),
//                             Text(
//                                 "adhikarm_tamil: " + newData[index]['adhikarm_tamil']),
//                             Text("iyal_tamil: " + newData[index]['iyal_tamil']),
//                             // Text(
//                             //     "adhikarm_no: " + newData[index]['adhikarm_no']),
//                             Text("desc1: " + newData[index]['desc1'])
//                           ],
//                         ),
//                       );
//                     },
//                     itemCount: newData == null ? 0 : newData.length,
//                   );
//                 }),
//           ),
//         ));
//   }
// }
