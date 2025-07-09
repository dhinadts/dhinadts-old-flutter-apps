// import 'dart:convert';

// import 'package:flutter/material.dart';

// import 'package:dictionary/main.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// var convCat1;
// var topicname;
// var index;
// String convCatList1 = "SELECT DISTINCT categoryname from conversation ";

// class Conversations extends StatefulWidget {
//   @override
//   ConversationsState createState() => ConversationsState();
// }

// class ConversationsState extends State<Conversations> {
//   // String queryAthikaram = "SELECT DISTINCT catname from thirukuralnew";

//   @override
//   void initState() {
//     super.initState();
//     // athikaramQ();
//     converCatQ();
//   }

//   converCatQ() async {
//     // athikaram = await db.anyQuery(queryAthikaram, dbName);
//     convCat1 = await db.anyQuery(convCatList1, dbName);
//     // detailedCat = await db.anyQuery(detailQuery, dbName);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomPadding: false,
//         appBar: AppBar(
//           title: Text("Conversation"),
//           actions: <Widget>[],
//           leading: Builder(
//             builder: (BuildContext context) {
//               return IconButton(
//                 icon: const Icon(Icons.arrow_back_ios),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               );
//             },
//           ),
//         ),
//         body: Padding(
//           padding: EdgeInsets.only(bottom: 50),
//           child: new ListView.builder(
//             itemCount: convCat1.length,
//             itemBuilder: (context, i) {
//               return new ListTile(
//                 title: Text(
//                   convCat1[i]['categoryname'],
//                   style: new TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 trailing: GestureDetector(
//                   child: Icon(Icons.arrow_right),
//                   onTap: () async {
//                     String query =
//                         'select topicname from conversation where categoryname ="${convCat1[i]['categoryname']}"';
//                     topicname = await db.anyQuery(query, dbName);
//                     await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => new Conversations2(
//                               title: convCat1[i]['categoryname']),
//                         ));
//                   },
//                 ),
//               );
//               //   children: // null,
//               //   /* for(var im =0; im<convCat.length; im++) */
//               //        _getChildren(convCat[i]['categoryname']),
//               //       //  onExpansionChanged: summa(convCat[i]['categoryname']),
//               //   // _buildExpandableContent(convCat[i]['categoryname']),
//               // );
//             },
//           ),
//         ));
//   }

//   summa(var s) async {
//     print("S::" + s);
//     var query = 'select topicname from conversation where categoryname ="$s"';
//     topicname = await db.anyQuery(query, dbName);
//     print("topicname:: " + topicname);
//   }

//   List<Widget> _getChildren(var s) {
//     List<Widget> children = [];
//     print("category:: " + s);
//     summa(s);
//     // var query = 'select topicname from conversation where categoryname ="$s"';
//     // topicname =  db.anyQuery(query, dbName);
//     for (var i = 0; i < topicname.length; i++) {
//       children.add(
//         new ListTile(
//           title: new Text(
//             "${topicname[i]["topicname"]}",
//             // "$i",
//             style: new TextStyle(fontSize: 18.0),
//           ),
//         ),
//       );
//     }
//     return children;
//   }

//   // _buildExpandableContent(String catName) async {
//   _buildExpandableContent(var s) {
//     List<Widget> columnContent = [];
//     //  List<Widget> columnContent = new List<Widget>();

//     var query = 'select topicname from conversation where categoryname ="$s"';
//     // var  topicname = new List();
//     topicname = db.anyQuery(query, dbName);
//     var len = topicname.length;
//     for (var i = 0; i < topicname.length; i++) {
//       columnContent.add(
//         new ListTile(
//           title: new Text(
//             "${topicname[i]["topicname"]}",
//             //  "$i",
//             style: new TextStyle(fontSize: 18.0),
//           ),
//           // leading: new Icon(vehicle.icon),
//         ),
//       );
//       // columnContent = new Text("1234567890") as List<Widget>;
//       return columnContent;
//     }

//     List<Text> createChildrenTexts(String catName) {
//       String query =
//           'select topicname from conversation where categoryname ="$catName"';
//       topicname = db.anyQuery(query, dbName);
//       var len = topicname.length;
//       // for (var i = 0; i < len; i++) {
//       //   columnContent.add(
//       //     new ListTile(
//       //       title: new Text(
//       //         // "${topicname[i]['topicname']}",
//       //         "$i",
//       //         style: new TextStyle(fontSize: 18.0),
//       //       ),
//       //       // leading: new Icon(vehicle.icon),
//       //     ),
//       //   );
//       // columnContent = new Text("1234567890") as List<Widget>;
//       //        return columnContent;
//       return topicname
//           .map((text) => Text(
//                 text,
//                 style: TextStyle(color: Colors.blue),
//               ))
//           .toList();
//     }
//   }
// }

// class Conversations2 extends StatelessWidget {
//   final String title;

//   Conversations2({Key key, @required this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomPadding: false,
//         appBar: AppBar(
//           title: Text("$title"),
//           actions: <Widget>[],
//           leading: Builder(
//             builder: (BuildContext context) {
//               return IconButton(
//                 icon: const Icon(Icons.arrow_back_ios),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               );
//             },
//           ),
//         ),
//         body: Padding(
//           padding: EdgeInsets.only(bottom: 50),
//           child: new ListView.builder(
//             itemCount: topicname.length,
//             itemBuilder: (context, i) {
//               return new ListTile(
//                 title: Text(
//                   topicname[i]['topicname'],
//                   style: new TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 trailing: GestureDetector(
//                   child: Icon(Icons.arrow_right),
//                   onTap: () async {
//                     var webView = await db.anyQuery(
//                         'SELECT * FROM conversation  where topicname = "${topicname[i]['topicname']}"',
//                         dbName);
//                     await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => new ConversationswebView(
//                               webView: webView[0]['conversation_ss'],
//                               title: webView[0]['topicname']),
//                         ));
//                   },
//                 ),
//               );
              
//             },
//           ),
//         ));
//   }
// }

// class ConversationswebView extends StatelessWidget {
//   final String webView;
//   final String title;
//   ConversationswebView({Key key, @required this.webView, @required this.title})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("${this.title}"),
//           leading: Builder(
//             builder: (BuildContext context) {
//               return IconButton(
//                 icon: const Icon(Icons.arrow_back_ios),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               );
//             },
//           ),
//         ),
//         body: new WebviewScaffold(
//           scrollBar: false,
//           url: new Uri.dataFromString(this.webView,
//                   encoding: Encoding.getByName('utf-8'), mimeType: 'text/html')
//               .toString(),
//         ));
//   }
// }
