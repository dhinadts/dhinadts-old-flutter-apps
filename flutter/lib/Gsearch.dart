import 'package:dhina/fragments/first_fragment.dart';
import 'package:dhina/newMainpage1.dart';
import 'package:flutter/material.dart';
import 'package:dhina/pages/newDrawer.dart';

import 'package:dhina/db/dbhelper.dart';

var db = DatabaseHelper();
// var searchResult1;
String dropdownValue = result[0]['pal_tamil'];
List<Map<String, dynamic>> pal2iyal, iyal2adhikaram;
String dropdownValue1;
String dropdownValue2;

class GlobalSearch extends StatefulWidget {
  GlobalSearch({Key key}) : super(key: key);

  @override
  _GlobalSearchState createState() => _GlobalSearchState();
}

class _GlobalSearchState extends State<GlobalSearch> {
  TextEditingController inputControler = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
 /*   showDialog(
        context: context,
        builder: (context) {
          var _value;

          return AlertDialog(
            title: Text('எழுத்து மூலம் தேட '),
            content: TextField(
              controller: inputControler,
              decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    // borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                  contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                  hintText: " Text search/உரைத்தேடல் ",
                  labelText: ' search/தேடல்: '),
                  onChanged: (input) =>
                                    _value = input,
            ),
            actions: <Widget>[
                                new FlatButton(
                                  child: new Text('இல்லை'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    // Navigator.of(context).pop();
                                  },
                                ),
                                new FlatButton(
                                  child: new Text('ஆம்'),
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    print(
                                        "text.controller:  ${inputControler.text}");
                                    var abcd =
                                        (inputControler.text);
                                    
                    var kuralWord = (inputControler.text);
                    print(kuralWord);
                    var sql =
                        'SELECT * FROM complete1 WHERE kural_tamil1 like "%$kuralWord%" or kural_thanglish1 like "%$kuralWord%" or kural_thanglish2 like "%$kuralWord%" ';
                    searchResult1 =
                        await db.any_query(sql, "modi_kural_comp.db");

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GlobalSearchingKural()),
                    );
                    // print($iNF1);
                  

                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute<Null>(
                                    //         builder: (BuildContext context) {
                                    //   return new MyApp444(
                                    //     value: ff,
                                    //     fontSize1: a,
                                    //   );
                                    // }));

                                    //Navigator.of(context).pop();

                                    // controller.jumpToPage(ff);
                                    // Navigator.of(context)
                                    //     .pop();
                                  },
                                )
                              ],
          );
        }
*/
 
    // MaterialApp(
    //   // title: "WEB SERVICE",
    //   theme: ThemeData(
    //     primaryColor: Colors.blueGrey,
    //   ),
    //   home: 
      Scaffold(
          resizeToAvoidBottomPadding: false,
          // primary: true,
         appBar: AppBar(
          primary: true,
          // leading: Builder(
          //   builder: (BuildContext context) {
          //     return IconButton(
          //       icon: const Icon(Icons.arrow_back),
          //       onPressed: () {
          //         // Navigator.pop(context);
          //         Navigator.of(context).pop();
          //         Navigator.of(context,
          //                                         rootNavigator: true)
          //                                     .pop(); 
          //       },
          //     );
          //   },
          // ),
          title: const Text('குறள் தேடல்...'),
          actions: <Widget>[
            
          ],
        ),
          // appBar: AppBar(
          //   // backgroundColor: Color(0xFF),
          //   actions: <Widget>[
          //     IconButton(
          //       icon: const Icon(Icons.arrow_back),
          //       onPressed: () {
          //         Navigator.pop(context);
          //       },
          //     ),
          //   ],
          //   title: Text(
          //     'குறள் தேடல்...',
          //     textAlign: TextAlign.center,
          //   ),
            
          // ),
          body: 
          
          
          new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),


            child: 
            


            new Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Text('     '),
                  
                 new TextField(
                  controller: inputControler,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                          // borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                        //fillColor: Colors.green
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 20.0),
                      hintText: " Text search/உரைத்தேடல் ",
                      labelText: ' search/தேடல்: '),
                ),
                
                new Text('     '),
                new RaisedButton(
                  onPressed: () async {
                    var kuralWord = (inputControler.text);
                    print(kuralWord);
                    var sql =
                        'SELECT * FROM complete1 WHERE kural_tamil1 like "%$kuralWord%" or kural_thanglish1 like "%$kuralWord%" or kural_thanglish2 like "%$kuralWord%" ';
                    searchResult1 =
                        await db.any_query(sql, "modi_kural_comp.db");

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GlobalSearchingKural()),
                    );
                    // print($iNF1);
                  },
                  child: const Text("தேடுக..", ),
                ),
                // new Text('அல்லது'),
                // new RaisedButton(
                //     child: Text("வகைவாரியாக தேட"),
                //     onPressed: () async {
                //        result = await db.any_query(
                //             'select DISTINCT pal_tamil from complete1',
                //             'modi_kural_comp.db');
                //         await _onSelectItem1(result[0]['pal_tamil']);
                //         await _onSelectItem2(result[1]['pal_tamil']);
                //         await _onSelectItem3(result[2]['pal_tamil']);
                //      Navigator.of(context).push(MaterialPageRoute<Null>(
                //             builder: (BuildContext context) {
                //           return new TabBarDemo();
                //         }));
                //     },
                //   ),
              ],
            ),

                      

          )

        //  ),

          
         //debugShowCheckedModeBanner: false,
        );
  }
}

_onSelectItem1(String s) async {
  var db = DatabaseHelper();

  result1 = await db.any_query(
      'SELECT DISTINCT iyal_tamil from complete1 WHERE pal_tamil="அறத்துப்பால்"',
      'modi_kural_comp.db');
  // List.generate(result1.length, (i) {
  //   Iyal(
  //     iyal_tamil: result1[i]['iyal_tamil'],
  //   );
  // });
  print(result1.length);
  print(result1);

  // Items I = new Items();
  // I = result as Items;
  // print(I.pal_tamil[0]);
}

_onSelectItem2(String s) async {
  var db = DatabaseHelper();
  result2 = await db.any_query(
      'SELECT DISTINCT iyal_tamil from complete1 WHERE pal_tamil="$s"',
      'modi_kural_comp.db');
  // List.generate(result2.length, (i) {
  //   Iyal(
  //     iyal_tamil: result2[i]['iyal_tamil'],
  //   );
  // });
  print(result2.length);
  print(result2);

  // Items I = new Items();
  // I = result as Items;
  // print(I.pal_tamil[0]);
}

_onSelectItem3(String s) async {
  var db = DatabaseHelper();
  result3 = await db.any_query(
      'SELECT DISTINCT iyal_tamil from complete1 WHERE pal_tamil="$s"',
      'modi_kural_comp.db');
  // List.generate(result3.length, (i) {
  //   Iyal(
  //     iyal_tamil: result3[i]['iyal_tamil'],
  //   );
  // });
  print(result3.length);
  print(result3);

  // Items I = new Items();
  // I = result as Items;
  // print(I.pal_tamil[0]);
}

class GlobalSearchingKural extends StatelessWidget {
  const GlobalSearchingKural({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        // resizeToAvoidBottomInset: true,
        extendBody: true,
        appBar: AppBar(
          primary: true,
          // leading: Builder(
          //   builder: (BuildContext context) {
          //     return IconButton(
          //       icon: const Icon(Icons.arrow_back),
          //       onPressed: () {
          //         // Scaffold.of(context).openDrawer();
          //         //       Navigator.push(
          //         //   context,
          //         //   MaterialPageRoute(builder: (context) => FirstFragment()),
          //         // );
          //         // Navigator.pop(context);
          //         Navigator.of(context, rootNavigator: true).pop();
          //       },
          //       // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          //     );
          //   },
          // ),
          title: Text('குறள்கள்:'),
        ),
        body: ListView.builder(
          itemCount: searchResult1.length,
          itemBuilder: (BuildContext context, int index) {
            return new GestureDetector(
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyApp444(
                              value: (searchResult1[index]['kural_no']) - 1)));
                  //GlobalSearchingNavigation() ));
                  // SearchingKural())); // null = AdhikaramKural()
                },
                child: Card(
                    child: ListTile(
                  leading: Text("${searchResult1[index]['kural_no']}"),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  title: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        // new SingleChildScrollView(
                        //scrollDirection: Axis.vertical,
                        // primary: true,
                        Expanded(
                          child: Text(
                            '${searchResult1[index]['kural_tamil1']}',
                            textScaleFactor: 1.0,
                            softWrap: true,
                            textAlign: TextAlign.start,
                            style: new TextStyle(
                              fontSize: 13,
                              // fontWeight:
                              //     FontWeight.bold
                            ), // textScaleFactor: 1.0,
                          ),
                        )
                      ]),
                )
                ));
          },
        ));

    /*          Card(
                                       child: Text("${searchResult1[index]['kural_tamil1']}",  style: TextStyle(
                                                                                    fontSize: 15,
                                                                                    color: Colors.deepPurpleAccent, //purple[300],
                                                                                    // decoration: TextDecoration.underline,
                                                                                    // decorationColor: Colors.red,
                                                                                    // decorationStyle: TextDecorationStyle.wavy,
                                                                                    // fontWeight: FontWeight.bold,
                                                                                  ),), );
                                    }*/
    //),
  }
}

//                             class GlobalSearchingNavigation extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return

//     null;
//   }
// }
