// import 'package:dictionary/example1.dart';
// import 'package:dictionary/grid_data.dart';
// import 'package:dictionary/otherApps/aathisudi/aathisudimain.dart';
// import 'package:dictionary/otherApps/home_needs.dart';
// import 'package:dictionary/otherApps/homophones/homophonesMain.dart';
// import 'package:dictionary/otherApps/importantWords/swords.dart';
// import 'package:dictionary/otherApps/news.dart';
// import 'package:dictionary/otherApps/proverbs/proverbMain.dart';
// import 'package:dictionary/otherApps/thirukkural/thirukkural.dart';
// import 'package:dictionary/otherApps/wordcategories/wordsbycat.dart';
// import 'package:dictionary/wordsearchresult.dart';
// import 'package:flutter/material.dart';
// import 'main.dart';

// var engWords = new List();

// class SearchBarAct extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Flutter Demo',
//       theme: new ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: new SearchBarPage(title: 'Searching in Dictionary'),
//     );
//   }
// }

// class SearchBarPage extends StatefulWidget {
//   SearchBarPage({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   _SearchBarPageState createState() => new _SearchBarPageState();
// }

// class _SearchBarPageState extends State<SearchBarPage> {
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
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text(widget.title),
//       ),
//       body: Container(
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 onChanged: (value) {
//                   filterSearchResults(value);
//                 },
//                 controller: editingController,
//                 decoration: InputDecoration(
//                     // labelText: "Search",
//                     hintText: "Search",
//                     suffixIcon: Icon(Icons.keyboard_voice),
//                     suffix: GestureDetector(
//                       child: Icon(Icons.close),
//                       onTap: () {
//                         editingController.clear();
//                         setState(() {
//                                   items.clear();

//                         });

//                       },
//                     ),
                    
//                     prefixIcon: Icon(Icons.search),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(0.0)))),
//               ),
//             ),
//             Expanded(
//                 child: items.length != 0
//                     ? ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: items
//                             .length, // == 0 ? items.length = 0 : items.length,
//                         itemBuilder: (context, index) {
//                           /* if (items.isEmpty) {
//                     return Center(
                      
//                       child: Column(
//                         children: <Widget>[
//                           Text("data"),
//                           Text("data"),
//                           Text("data"),
//                         ],
//                       )
//                     );
//                   } else { */
//                           return GestureDetector(
//                             child: ListTile(
//                               title: Text('${items[index]}'),
//                             ),
//                             onTap: () async {
//                               print("${items[index]}");
//                               int id = 0;
//                               /* String query1 =
//                           'select * from Dictionary where engword = "${items[index]}"'; // union
//                       String query2 =
//                           'select * from Dic_Unicode where engword = "${items[index]}"'; // union */
//                               /* if (query1.isNotEmpty) {
//                         id = query1['id'] as int;
//                       } else if (query2.isNotEmpty) {
//                         id = query2['id'] as int;
//                       } else {
//                         id = 0;
//                       } */

//                               print(index);
//                               print(engWords[index]);

//                               Navigator.of(context).push(
//                                   MaterialPageRoute<Null>(
//                                       builder: (BuildContext context) {
//                                 return WordSearchRes1(
//                                   id: pageNo,
//                                     title: '${items[index]}');
//                               }));
//                             },
//                           );
//                         })
//                     : GridView.count(
//                         crossAxisCount: 3,
//                         children: <Widget>[
//                           GestureDetector(
//                             onTap: () {
//                               print("pressed");
//                             },
//                             child: Grid_design(
//                               title: 'Phrases and Idioms',
//                               image: 'images/winner.png',
//                             ),
//                           ),
//                           Grid_design(
//                             title: 'Conversations உரையாடல்கள்',
//                             image: 'images/winner.png',
//                           ),
//                           Grid_design(
//                             title: 'இன்று',
//                             image: 'images/winner.png',
//                           ),
//                           Grid_design(
//                             title: 'கதைகள் / கட்டுரைகள்',
//                             image: 'images/winner.png',
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => News()),
//                               );
//                             },
//                             child: Grid_design(
//                               title: 'செய்திகள்',
//                               image: 'images/winner.png',
//                             ),
//                           ),
//                           Grid_design(
//                             title: 'Online Test',
//                             image: 'images/winner.png',
//                           ),

//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => ImpWords()),
//                               );
//                             },
//                             child: Grid_design(
//                               title: 'Important Words',
//                               image: 'images/winner.png',
//                             ),
//                           ),

//                           // ImpWords
//                           // AathiSudi

//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => AathiSudi()),
//                               );
//                             },
//                             child: Grid_design(
//                               title: 'ஆத்திச்சூடி',
//                               image: 'images/winner.png',
//                             ),
//                           ),

//                           // Proverb
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => Proverb()),
//                               );
//                             },
//                             child: Grid_design(
//                               title: 'பழமொழிகள்',
//                               image: 'images/winner.png',
//                             ),
//                           ),

//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => HomeNeeds()),
//                               );
//                             },
//                             child: Grid_design(
//                               title: 'Home Needs',
//                               image: 'images/winner.png',
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => Thirukkural()),
//                               );
//                             },
//                             child: Grid_design(
//                               title: 'திருக்குறள்',
//                               image: 'images/winner.png',
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => WordCategory()),
//                               );
//                             },
//                             child: Grid_design(
//                               title: 'Word Categories',
//                               image: 'images/winner.png', //
//                             ),
//                           ),

//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => HomoPhones()),
//                               );
//                             },
//                             child: Grid_design(
//                               title: 'Homophones',
//                               image: 'images/winner.png',
//                             ),
//                           ),

//                           /*  Grid_design(
//                                     title: 'Homophones',
//                                     image: 'images/winner.png',
//                                   ), */
//                         ],
//                       )),
//           ],
//         ),
//       ),
//     );
//   }
// }
