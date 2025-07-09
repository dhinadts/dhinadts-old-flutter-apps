import 'dart:core';
import 'dart:core' as prefix0;

import 'package:dhina/cate2pgview.dart';
import 'package:dhina/firstPage.dart';
import 'package:dhina/main_pages/favorite_Displays.dart';
import 'package:dhina/newMainpage1.dart';
import 'package:flutter/material.dart';
import 'package:dhina/db/dbhelper.dart';

import 'package:dhina/db/sharedpref.dart';
import '../Gsearch.dart';
import '../tapOption.dart';

import 'package:dhina/main.dart';


List<Map> x = [];
List<String> items = <String>[];
List<Map<String, dynamic>> result;
List<Map<String, dynamic>> result1, result2, result3;

 
var cursor = 0;
int v =0;
var defCursor = 0;
var db = DatabaseHelper();
var prefs = Shared_Preference();
double a = 0.0, b = 0.0;

var fontSize1 = 0.0; 
// double _fontSize11 =0.0;
class FirstFragment extends StatefulWidget {
  @override
  FirstState createState() {
    return new FirstState();
  }
}

class FirstState extends State<FirstFragment> {
  int cur1;
  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // result = db.any_query(query, dbName)
    //prefs.setInt("cursor", cursor);
    // prefs.setint("fontSize1", a as int);
    cur1 = cursor;
    loaddb();
        // a = prefs.getdouble("fontSize1") as double; //, a ) as double;
      }
    
      @override
      Widget build(BuildContext context) {
    //     // todo: implement build
    //     return null;
    //   }}
    
    // class FirstFragment extends StatelessWidget {
    //   @override
    //   Widget build(BuildContext context) {


        return new Center(
            // return new Container(
    // width: 300.0,
            // padding: const EdgeInsets.only(top: 16.0),SizedBox(
    //   width: 200.0,
    //   height: 300.0,
    //   child: const Card(child: Text('Hello World!')),
    // )
            // )
            child: new SafeArea(
                child: new SizedBox(
          width: 300.0,
          height: 500.0,
          child: new Column(
            // new SizedBox(
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                  color: Color(1000),
                  child: Text('ஆரம்பிக்க'),
                  onPressed: () async {
                    a = await prefs.getDouble("fontSize1"); 
                    newData1 =
        await db.any_query("select * from complete1", "modi_kural_comp.db");
                    await Navigator.of(context).push(
                        MaterialPageRoute<Null>(builder: (BuildContext context) {
                      return new MyApp444(value: 0, currentPageValue: 0, fontSize1: a,);// fontSize11),);
                    }));
                    // await Navigator.of(context).push(
                    //     MaterialPageRoute<Null>(builder: (BuildContext context) {
                    //   return new MyApp4(fontSize1 : fontSize1);
                    // }));
                  }),
              RaisedButton(
                color: Color(1100),
                child: Text('தொடர்க'),
                onPressed: () async {
                //   int v = await prefs.getInt("cursor");
                //   double ab = await prefs.getDouble("fontSize1"); 
                //   if (v == 0) {
                //     Navigator.of(context).push(
                //         MaterialPageRoute<Null>(builder: (BuildContext context) {
                //       return new MyApp44(value: 0, fontSize1: ab,);
                //     }));
                //   } else {
                //     Navigator.of(context).push(
                //         MaterialPageRoute<Null>(builder: (BuildContext context) {
                //       return new MyApp44(value: v, currentPageValue: v, fontSize1: a,);
                //     }));
                //   }
                //   // Navigator.of(context).push(
                //   //     MaterialPageRoute<Null>(builder: (BuildContext context) {
                //   //   return new MyApp44(value: v);
                //   // }));
                // },
                 int v = await prefs.getInt("cursor");
                  a = await prefs.getDouble("fontSize1"); 
                  if (v == 0) {
                    Navigator.of(context).push(
                        MaterialPageRoute<Null>(builder: (BuildContext context) {
                      return new MyApp444(value: 0, currentPageValue: 0, fontSize1: a,);
                    }));
                  } else {
                    Navigator.of(context).push(
                        MaterialPageRoute<Null>(builder: (BuildContext context) {
                      return new MyApp444(value: v, currentPageValue: v, fontSize1: a,);
                    }));
                  }
                  // Navigator.of(context).push(
                  //     MaterialPageRoute<Null>(builder: (BuildContext context) {
                  //   return new MyApp44(value: v);
                  // }));
                },
              ),
              RaisedButton(
                color: Color(1100),
                child: Text('வகைப்பட்டியல்'),
                onPressed: () async {
                  result = await db.any_query(
                      'select DISTINCT pal_tamil from complete1',
                      'modi_kural_comp.db');
                  await _onSelectItem1(result[0]['pal_tamil']);
                  await _onSelectItem2(result[1]['pal_tamil']);
                  await _onSelectItem3(result[2]['pal_tamil']);
                  Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return new TabBarDemo();
                  }));
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                Container(
                  width: 140,
                  child: RaisedButton(
                      color: Color(1100),
                      child: Text('செல்'),
                      onPressed: () {
                        return showDialog(
                          context: context,
                          builder: (context) {
                            prefix0.num _value;
                            return AlertDialog(
                              title: Text('குறள் எண்ணை தட்டவும்'),
                              content: TextFormField(
                                keyboardType: TextInputType
                                    .number, //numberWithOptions(decimal: true),
                                controller: _textFieldController,
                                decoration:
                                    InputDecoration(hintText: "குறள் எண்: "),
                                onSaved: (input) => _value = int.tryParse(input),
                                // textInputAction: controller.jumpTo(value),
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
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    print(
                                        "text.controller:  ${_textFieldController.text}");
                                    var abcd =
                                        (_textFieldController.text).toString();
                                    print("abcd " + abcd);
                                    var ff = int.parse(abcd) - 1;
                                    //               var route = new MaterialPageRoute(
                                    //   builder: (BuildContext context) =>
                                    //       new MyApp44(value: ff, ),
                                    // );
                                    // Navigator.of(context).push(route);
                                    // Navigator.of(context).push(route);
    
                                    Navigator.of(context).push(
                                        MaterialPageRoute<Null>(
                                            builder: (BuildContext context) {
                                      return new MyApp444(value: ff);
                                    }));
    
                                    //Navigator.of(context).pop();
    
                                    // controller.jumpToPage(ff);
                                    // Navigator.of(context)
                                    //     .pop();
                                  },
                                )
                              ],
                            );
                          },
                        );
                      }),
                  ),
                  Container(
                  width: 140,
                    child: RaisedButton(
                    color: Color(1100),
                    child: Text('தேடல்'),
                    onPressed: () async {
                      var kuralNo = "ஆதி";
                      var sql =
                          "SELECT * FROM complete1 WHERE kural_tamil1 like '%$kuralNo%'";
                      // var sql1 = "SELECT * FROM kural where kural_no = $kuralNo";
                      var searchResult =
                          await db.any_query(sql, "modi_kural_comp.db");
                      print(searchResult);
                      Navigator.of(context).push(
                          MaterialPageRoute<Null>(builder: (BuildContext context) {
                        return new GlobalSearch();
                      }));
                    },
                  ),
                  ),
                ]
              ),
              /* Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  
                  RaisedButton(
                      color: Color(1100),
                      child: Text('செல்'),
                      onPressed: () {
                        return showDialog(
                          context: context,
                          builder: (context) {
                            prefix0.num _value;
                            return AlertDialog(
                              title: Text('குறள் எண்ணை தட்டவும்'),
                              content: TextFormField(
                                keyboardType: TextInputType
                                    .number, //numberWithOptions(decimal: true),
                                controller: _textFieldController,
                                decoration:
                                    InputDecoration(hintText: "குறள் எண்: "),
                                onSaved: (input) => _value = int.tryParse(input),
                                // textInputAction: controller.jumpTo(value),
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
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    print(
                                        "text.controller:  ${_textFieldController.text}");
                                    var abcd =
                                        (_textFieldController.text).toString();
                                    print("abcd " + abcd);
                                    var ff = int.parse(abcd) - 1;
                                    //               var route = new MaterialPageRoute(
                                    //   builder: (BuildContext context) =>
                                    //       new MyApp44(value: ff, ),
                                    // );
                                    // Navigator.of(context).push(route);
                                    // Navigator.of(context).push(route);
    
                                    Navigator.of(context).push(
                                        MaterialPageRoute<Null>(
                                            builder: (BuildContext context) {
                                      return new MyApp44(value: ff);
                                    }));
    
                                    //Navigator.of(context).pop();
    
                                    // controller.jumpToPage(ff);
                                    // Navigator.of(context)
                                    //     .pop();
                                  },
                                )
                              ],
                            );
                          },
                        );
                      }),
                  RaisedButton(
                    color: Color(1100),
                    child: Text('தேடல்'),
                    onPressed: () async {
                      var kuralNo = "ஆதி";
                      var sql =
                          "SELECT * FROM complete1 WHERE kural_tamil1 like '%$kuralNo%'";
                      // var sql1 = "SELECT * FROM kural where kural_no = $kuralNo";
                      var searchResult =
                          await db.any_query(sql, "modi_kural_comp.db");
                      print(searchResult);
                      Navigator.of(context).push(
                          MaterialPageRoute<Null>(builder: (BuildContext context) {
                        return new GlobalSearch();
                      }));
                    },
                  ),
                ],
              ), */
              RaisedButton(
                color: Color(1100),
                child: Text('நித்ரா தமிழ் நாட்காட்டி'),
                onPressed: () async {
                //   ResultFav = await db.any_query('SELECT * from complete1 where isfav=1', 
                //    //1 where isfav=1', 
                //    "modi_kural_comp.db");
                //   Navigator.of(context).push(
                //       MaterialPageRoute<Null>(builder: (BuildContext context) {
                //     return new Favorite11(); // HomePage1();
                //   }));
                // OpenAppstore.launch(androidAppId: "com.facebook.katana&hl=ko", iOSAppId: "284882215");

                },
              ),
              RaisedButton(
                child: Text('Favourites'),
                color: Color(5400),
                onPressed: () async {
                  // BackupKurals = await db.any_query("SELECT kural_no ", dbName)
                  ResultFav = await db.any_query('SELECT * from complete', //1 where isfav=1', 
                   //1 where isfav=1', 
                   "modi_kural_comp.db");
                  Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return new Favorite11(); // HomePage1();
                  }));
                },
              ),
              RaisedButton(
                child: Text('FavouritesSample'),
                color: Color(5400),
                onPressed: () async {
                  // BackupKurals = await db.any_query("SELECT kural_no ", dbName)
                  // ResultFav = await db.any_query('SELECT * from complete', //1 where isfav=1', 
                  //  //1 where isfav=1', 
                  //  "modi_kural_comp.db");
                  Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FirstFragment1()),
        );
                  // Navigator.of(context).push(
                  //     MaterialPageRoute<Null>(builder: (BuildContext context) {
                  //   return new FirstFragment1(); // HomePage1();
                  // }));
                },
              ),
              // RaisedButton(
              //   child: Text('Tamils calendar'),
              //   color: Color(5400),
              //   onPressed: () async {
              //     int v = await prefs.getInt("cursor");
              //     a = await prefs.getDouble("fontSize1"); 
              //     if (v == 0) {
              //       Navigator.of(context).push(
              //           MaterialPageRoute<Null>(builder: (BuildContext context) {
              //         return new MyApp444(value: 0);
              //       }));
              //     } else {
              //       Navigator.of(context).push(
              //           MaterialPageRoute<Null>(builder: (BuildContext context) {
              //         return new MyApp444(value: v, currentPageValue: v, fontSize1: a,);
              //       }));
              //     }
              //     // Navigator.of(context).push(
              //     //     MaterialPageRoute<Null>(builder: (BuildContext context) {
              //     //   return new MyApp44(value: v);
              //     // }));
              //   },
              // ),
              // RaisedButton(
              //   child: Text('Simple Slider'),
              //   color: Color(5400),
              //   onPressed: () async {
                  
              //       Navigator.of(context).push(
              //           MaterialPageRoute<Null>(builder: (BuildContext context) {
              //         return new SIMpleSlider();
              //       }));
                 
                 
              //     // Navigator.of(context).push(
              //     //     MaterialPageRoute<Null>(builder: (BuildContext context) {
              //     //   return new MyApp44(value: v);
              //     // }));
              //   },
              // ),
              // RaisedButton(
              //   child: Text('Simple Slider'),
              //   color: Color(5400),
              //   onPressed: () async {
                  
              //       Navigator.of(context).push(
              //           MaterialPageRoute<Null>(builder: (BuildContext context) {
              //         return new SimpleSlider1();
              //       }));
                 
                 
              //     // Navigator.of(context).push(
              //     //     MaterialPageRoute<Null>(builder: (BuildContext context) {
              //     //   return new MyApp44(value: v);
              //     // }));
              //   },
              // ),
              
            ],
          ),
        )));
      }
    }
    
    void loaddb() async {
       newData1 =
        await db.any_query("select * from complete1", "modi_kural_comp.db");
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: RaisedButton(
          color: Colors.red,
          child: Text('Go To categories'),
          onPressed: () {
            //Use`Navigator` widget to pop oir go back to previous route / screen
            // Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewerActivity1()),
            );
          },
        ),
      ),
    );
  }
}

class ViewerActivity1 extends StatelessWidget {
  // var pal_tamil;

  // get pal_tamil => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('third Screen'),
        ),
        body: Center(
            child: new Column(
          children: <Widget>[
            new RaisedButton(
              color: Colors.red,
              child: Text('Categories'),
              onPressed: () async {
                //Use`Navigator` widget to pop oir go back to previous route / screen
                var db = DatabaseHelper();
                result = await db.any_query(
                    'select DISTINCT pal_tamil from complete1',
                    'modi_kural_comp.db');

                // List.generate(result.length, (i) {
                //   Pal(
                //     pal_tamil: result[i]['pal_tamil'],
                //   );
                // });
                print(result.length);
                print(result);
                // Items I = new Items();
                // I = result as Items;
                // print(I.pal_tamil[0]);
                x = result;
                // y = result;
                // Items P = new Items(); // as List<Map<String, >>;
                // Items P = new Items();
                // var P = new Pal();
                // P = result as Pal;
                // var z;
                // z = P[0].pal_tamil ;
                // // print("P is $P");
                // print(z);
                // print("Pal is ${P.pal_tamil[1]}");
                // print("tell it    ${result[1]}");
                // // List<Map> x = result; // as Items; // as Items;

                // one.forEach((row) => print(row));
                // items = result.toList();
                //items1 = result.toList();

                result.forEach(
                    (row) => print("pal in tamil: ${row['pal_tamil']}"));
                print("${result[0]['pal_tamil']}");
                print("${result[1]['pal_tamil']}");
                print("${result[2]['pal_tamil']}");
                // print("${row['pal_tamil']}");
                // print(x['pal_tamil']);
                // List<Map> x = result; // as Items; // as Items;
                // Items one = result as Items;
                // print("hi    ${y[1]}");
                // return result.toList();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListedViewEx()),
                );
              },
            ),
//             new Expanded(
//                 child: new ListView(
//               padding: new EdgeInsets.symmetric(vertical: 8.0),
//               children: <Widget>[
//                 Text("$x"),
// // Text("${result[0]['pal_tamil']}"),
// //                 Text("${result[1]['pal_tamil']}"),
// //                 Text("${result[2]['pal_tamil']}"),
//               ],
//             )),
          ],
        )));
  }
}

// class Pal {
//   String pal_tamil;
//   Pal({this.pal_tamil});

//   Pal.map(dynamic obj) {
//     this.pal_tamil = obj['pal_tamil'];
//   }
// // String get pal_tamil => pal_tamil;
//   // String get pal_tamil => pal_tamil;

//   Map<String, dynamic> toMap() {
//     var map = new Map<String, dynamic>();
//     map['pal_tamil'] = pal_tamil;
//     return map;
//   }

//   Pal.fromMap(Map<String, dynamic> json) {
//     this.pal_tamil = json['pal_tamil'];
//   }
// }

// class Iyal {
//   String iyal_tamil;
//   Iyal({this.iyal_tamil});

//   Iyal.map(dynamic obj) {
//     this.iyal_tamil = obj['iyal_tamil'];
//   }

//   // String get pal_tamil => pal_tamil;

//   Map<String, dynamic> toMap() {
//     var map = new Map<String, dynamic>();
//     map['iyal_tamil'] = iyal_tamil;
//     return map;
//   }

//   Iyal.fromMap(Map<String, dynamic> json) {
//     this.iyal_tamil = json['iyal_tamil'];
//   }
//   //bool isSelected;
// }

class ListedViewEx extends StatelessWidget {
  final List<String> items1;

  const ListedViewEx({Key key, this.items1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: result.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return new Column(
            children: <Widget>[
              Text('${result[index]['pal_tamil']}',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.green,
                    background: Paint(),
                  )),
              // Text("${result[0]['pal_tamil']}"),
              //   Text("${result[1]['pal_tamil']}"),
              //   Text("${result[2]['pal_tamil']}"),
            ],
          );
        });
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
