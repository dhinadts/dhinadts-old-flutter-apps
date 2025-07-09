import 'dart:core';
import 'dart:core' as prefix0;
import 'package:flutter/material.dart';
import 'package:dhina/db/dbhelper.dart';
import 'package:dhina/db/sharedpref.dart';

import 'newMainpage1.dart';

var db = DatabaseHelper();
var prefs = Shared_Preference();

class FirstFragment1 extends StatefulWidget {
  @override
  FirstState1 createState() {
    return new FirstState1();
  }
}

class FirstState1 extends State<FirstFragment1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white10,
      child: Center(
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
          Card(
            color: Colors.blueGrey,
          child: SizedBox(
            height: 60,
            width: 250,
          child: Container(
              height: 25,
              child: Row(children: <Widget>[
                Image.asset(
                  'assets/play1.png',
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text("                 ஆரம்பிக்க                "),
                    Text("-----------------------------------------"),
                    Text("                   Start                 "),
                  ],
                )
              ])))),
          RaisedButton(
                  color: Colors.white10,
                  child: Card(
            color: Colors.white10,
          child: SizedBox(
            height: 60,
            
          child: Container(
              height: 35,
              child: Row(children: <Widget>[
                Image.asset(
                  'assets/play1.png',
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text("                 ஆரம்பிக்க                "),
                    Text("-----------------------------------------"),
                    Text("                   Start                 "),
                  ],
                )
              ])))
              ),
                  onPressed: () async {
                    
                    await Navigator.of(context).push(
                        MaterialPageRoute<Null>(builder: (BuildContext context) {
                      return new MyApp444(value: 0, currentPageValue: 0, fontSize1: 0,);// fontSize11),);
                    }));
                    
                  }),
          Row(),
          Row(),
          Row(),
        ],
      ),
    ))));
  }
}

/*
RaisedButton(
              color: Color(1000),
              child: Text('ஆரம்பிக்க'),
              onPressed: () {
                // await Navigator.of(context).push(
                //     MaterialPageRoute<Null>(builder: (BuildContext context) {
                //   return new MyApp4(fontSize1 : fontSize1);
                // }));
              }),
          RaisedButton(
            color: Color(1100),
            child: Text('தொடர்க'),
            onPressed: () {
              // Navigator.of(context).push(
              //     MaterialPageRoute<Null>(builder: (BuildContext context) {
              //   return new MyApp44(value: v);
              // }));
            },
          ),
          RaisedButton(
            color: Color(1100),
            child: Text('வகைப்பட்டியல்'),
            onPressed: () {},
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
                      onPressed: () {}),
                ),
                Container(
                  width: 140,
                  child: RaisedButton(
                    color: Color(1100),
                    child: Text('தேடல்'),
                    onPressed: () {},
                  ),
                ),
              ]),
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
            onPressed: () {},
          ),
          RaisedButton(
            child: Text('Favourites'),
            color: Color(5400),
            onPressed: () {},
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


*/
