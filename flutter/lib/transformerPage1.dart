// import 'dart:core' as prefix0;
// import 'dart:core';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:typed_data';

// import 'db/dbhelper.dart';


// int value1;
// var favKural;
// bool _isFavorited = false;
// bool _isfav = false;
// var db = DatabaseHelper();
// double valueHolder = 0.0;
// ByteData bytes; // = await rootBundle.load('assets/valluvar.png');

// List<Map<String, dynamic>> testR;
// List<Map<String, dynamic>> resFav;
// List<Map<String, dynamic>> favArray;
// List<Map<String, dynamic>> summaR;

// var currentPageValue = 0;
// PageController controller = PageController();

// void main() => runApp(new Name1());

// class Name1 extends StatefulWidget {
//   Name1({Key key}) : super(key: key);

//   @override
//   _Name1State createState() => _Name1State();
// }

// class _Name1State extends State<Name1> {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//               resizeToAvoidBottomPadding: false,
// body: Container(
      
//       child: PageView.builder(
//         itemCount: 1330,
        
// //         controller: controller,
// // pageSnapping: true,
// //           scrollDirection: Axis.horizontal,
//           itemBuilder: (BuildContext context, int index) {
//             return Card(
//               child: Column(
//                 // crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   new SizedBox(
//                     height: 80,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         new Text(
//                           "குறள்: ", //${newData1.kural_no}",
//                           style: TextStyle(fontSize: 18),
//                         ),
//                         // new FavoriteWidget(),
//                         IconButton(
//                           autofocus: false,
                          
//                             icon: (_isFavorited == true && _isfav == true
//                                 ? Icon(Icons.star)
//                                 : Icon(Icons.star_border)),
//                             color: Colors.red[500],
//                             onPressed: () async {
//                                   _isFavorited = !_isFavorited;
//                                   _isfav = !_isfav;
//                               }),
//                       ]))]));
//                     }
//       ),
//     ));
//   }

  
// }