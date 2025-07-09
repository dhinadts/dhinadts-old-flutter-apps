// // tenkurals from adhikaram

// import 'package:dictionary/ScreenUtil.dart';
// import 'package:dictionary/searchbaract.dart';
// import 'package:flutter/material.dart';

// import 'main.dart';

// var engWords = new List();

// class WordSearchRes extends StatefulWidget {
//   final String title;
//   final int id;

//   WordSearchRes({Key key, @required this.title, @required this.id})
//       : super(key: key);

//   @override
//   _WordSearchResState createState() => _WordSearchResState();
// }

// class _WordSearchResState extends State<WordSearchRes> {
//   TextEditingController editingController = TextEditingController();
//   /* String dictionary = "select engword from Dic_Unicode";
//   String secondDictionary = "select engword from Dictionary "; */
//   String completeDictionary =
//       "select engword from Dictionary union select engword from Dic_Unicode";

//   var items = new List();

//   @override
//   void initState() {
//     // items.addAll(engWords);
//     super.initState();
//     query123();
//   }

//   query123() async {
//     dictionaryWords = await db.anyQuery(completeDictionary, dbName);
//     for (var i = 0; i < dictionaryWords.length; i++) {
//       engWords.add(dictionaryWords[i]["EngWord"]);
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   void filterSearchResults(String query) {
//     List dummySearchList = List();
//     dummySearchList.addAll(engWords);
//     if (query.isNotEmpty) {
//       List dummyListData = List();
//       dummySearchList.forEach((item) {
//         if (item.startsWith(query)) {
//           dummyListData.add(item);
//         }
//       });
//       setState(() {
//         items.clear();
//         items.addAll(dummyListData);
//       });
//       return;
//     } else {
//       setState(() {
//         items.clear();

//         items.addAll(engWords);
//         items.clear();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomPadding: false,
//         // resizeToAvoidBottomInset: true,
//         // extendBody: true,
//         /*  appBar: AppBar(
//         leading: Builder(
//           builder: (BuildContext context) {
//             return IconButton(
//               icon: const Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             );
//           },
//         ),
//         title: TextField(
//                 onChanged: (value) {
//                   // filterSearchResults(value);
//                 },
//                 // controller: ,
//                 decoration: InputDecoration(
//                     // labelText: "Search",
//                     hintText: "Search",
//                     suffixIcon: Icon(Icons.keyboard_voice),
//                     suffix: GestureDetector(
//                       child: Icon(Icons.close),
//                       onTap: () {
                        
//                       },
//                     ),
                    
//                     prefixIcon: Icon(Icons.search),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(0.0)))),
//               ),

//       ), */

//         /* AppBar(
//         primary: true,
//         leading: Builder(
//           builder: (BuildContext context) {
//             return IconButton(
//               icon: const Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             );
//           },
//         ),
//         title: Text('${widget.title}'),
//       ), */
//         body: SafeArea(
//           child: Container(
//               // color: Colors.blue,
//               child: Column(children: <Widget>[
//             TextField(
//               onChanged: (value) {
//                 filterSearchResults(value);
//               },
//               // controller: ,
//               decoration: InputDecoration(
//                   // labelText: "Search",
//                   hintText: widget.title,
//                   suffixIcon: Icon(Icons.keyboard_voice),
//                   suffix: GestureDetector(
//                     child: Icon(Icons.close),
//                     onTap: () {
//                       editingController.clear();
//                       setState(() {
//                         items.clear();
//                       });
//                     },
//                   ),
//                   prefixIcon: GestureDetector(
//                     child: Icon(Icons.arrow_back_ios),
//                     onTap: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(1.0)))),
//             ),
//             Expanded(
//                 child: items.length != 0
//                     ? ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: items
//                             .length, // == 0 ? items.length = 0 : items.length,
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                             child: ListTile(
//                               title: Text('${items[index]}'),
//                             ),
//                             onTap: () async {
//                               print("${items[index]}");
//                               int id = 0;

//                               print(index);
//                               print(engWords[index]);

//                               Navigator.of(context).push(
//                                   MaterialPageRoute<Null>(
//                                       builder: (BuildContext context) {
//                                 return WordSearchRes(
//                                     id: id, title: '${items[index]}');
//                               }));
//                             },
//                           );
//                         })
//                     : Card(
//                         child: Row(
//                           children: <Widget>[
//                             Container(
//                               width: 300.0,
//                               child: Column(
//                                 children: <Widget>[
//                                   Text(
//                                     "${widget.title}",
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                         fontSize: 25,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   Text(
//                                     "${widget.title}",
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                         fontSize: 25,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   Text(
//                                     "${widget.title}",
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                         fontSize: 25,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   Text(
//                                     "${widget.title}",
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                         fontSize: 25,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               width: 50,
//                               child: Column(
//                                 children: <Widget>[
//                                   IconButton(
//                                     icon: Icon(Icons.favorite),
//                                     onPressed: () {},
//                                   ),
//                                   IconButton(
//                                     icon: Icon(Icons.share),
//                                     onPressed: () {},
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       )),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               mainAxisSize: MainAxisSize.max,
//               children: <Widget>[
//                 RaisedButton(
//                   color: Colors.pink,
//                   child: Text("Prev"),
//                   onPressed: () async {
//                     var query =
//                         'SELECT id from dic_unicode where engword= "${widget.title}"';
//                     var id1 = await db.anyQuery(query, dbName);
//                     int a = id1[0]['id'] - 1;
//                     print("id::: ${id1[0]['id']} and a = $a");
//                     var query1 =
//                         'SELECT engword from dic_unicode where id = "$a"';
//                     var prev = await db.anyQuery(query1, dbName);
//                     String titlePrev = prev[0]['EngWord'];
//                     print("titlePrev:: $titlePrev");
//                     /* Navigator.of(context).push(
//                       MaterialPageRoute<Null>(builder: (BuildContext context) {
//                     return WordSearchRes(id: a, title: titlePrev);
//                   })); */
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => WordSearchRes(
//                                 id: a,
//                                 title: titlePrev,
//                               )),
//                     );
//                   },
//                 ),
//                 Text("|"),
//                 GestureDetector(
//                   child: FlatButton(child: Text("Copy"), onPressed: null),
//                   onTap: () {},
//                 ),
//                 Text("|"),
//                 GestureDetector(
//                   child: Text("Pronounce"),
//                   onTap: () {},
//                 ),
//                 Text("|"),
//                 RaisedButton(
//                   color: Colors.pink,
//                   child: Text("Next"),
//                   onPressed: () async {
//                     var query =
//                         'SELECT id from dic_unicode where engword= "${widget.title}"';
//                     var id1 = await db.anyQuery(query, dbName);
//                     int a = id1[0]['id'] + 1;
//                     print("id::: ${id1[0]['id']} and a = $a");
//                     var query1 =
//                         'SELECT engword from dic_unicode where id = "$a"';
//                     var prev = await db.anyQuery(query1, dbName);
//                     String titlePrev = prev[0]['EngWord'];
//                     print("titlePrev:: $titlePrev");
//                     Navigator.of(context).push(MaterialPageRoute<Null>(
//                         builder: (BuildContext context) {
//                       return WordSearchRes(id: a, title: titlePrev);
//                     }));
//                   },
//                 ),
//               ],
//             ),
//           ])),
//         ));
//   }
// }
