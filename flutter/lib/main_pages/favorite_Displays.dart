

import 'package:dhina/newMainpage1.dart';
import 'package:flutter/material.dart';
import 'package:dhina/db/dbhelper.dart';
import 'package:dhina/cate2pgview.dart';

import '../cate2pgview.dart';


// List<Map<String, dynamic>> result2;

bool _isFavorited = false;
bool _isfav = false;
var db = DatabaseHelper();
class Favorite11 extends StatefulWidget {
  @override
  FavState createState() {
    return new FavState();
  }
}

class FavState extends State<Favorite11> {
  
  @override
  void initState() {
    // ResultFav = await db.any_query('SELECT * from complete', "modi_kural_comp.db");
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'பிடித்தவைகள்',
            textAlign: TextAlign.justify,
          ),
        ),
        body: new ListView.builder(
          itemCount: ResultFav.length,
          itemBuilder: (context, i) => new Column(
            children: <Widget>[
              new Divider(
                height: 10.0,
              ),
              new GestureDetector(
                  onTap: () async {
                     // print("HI");
                    // indexKey = i;
                    // indexResult = ResultFav;
                    // print(indexResult);
                    // _adhikaramDisplay();
                    // var db = DatabaseHelper();
                    // var sql =
                    //     'SELECT * from complete';
                    // ResultFav = await db.any_query(sql, "modi_kural_comp.db");

summa(ResultFav[i]['kural_no']-1);
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyApp444(value: (ResultFav[i]['kural_no'] -1),))); // null = AdhikaramKural()
                  },
                  // child: Expanded(
                  child: ListTile(
                    
                    title: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                        child: new Text(
                          ResultFav[i]['kural_tamil1'],
                          textScaleFactor: 1.0,
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: new TextStyle(
                            fontSize: 13,
                          // style: new TextStyle(fontWeight: FontWeight.bold),
                        ))),
                      ],
                    ),
                  ), 
                  // )
                  ),

              
            ],
          ),
        ));
  }
  summa(int value) async {
    List<Map<String, dynamic>> result10; // = null;
    List<Map<String, dynamic>> result09; // = null;
    var result9;
    List<Map<String, dynamic>> result11; // = null;
    // int temp = await prefs.getInt("cursor");
    /*
    try {
      result10 =
          await db.any_query("select * from complete", "modi_kural_comp.db");
      if (result10.isEmpty) {
        _isFavorited = false;
        _isfav = false;
      } else if (result10.isNotEmpty) {
        result09 = await db.any_query(
            "select kural_no from complete", "modi_kural_comp.db");
        for (var i = 0; i < result09.length; i++) {
          // prefix0.print("Try Catch: ${result09[i]['kural_no']}");
          await db.any_query(
              "UPDATE complete1 SET isfav=1 WHERE kural_no = ${result09[i]['kural_no']}",
              "modi_kural_comp.db");
          controller.addListener(() {
            setState(() {
              if (currentPageValue == result09[i]['kural_no'])
                _isFavorited = true;
            });
          });
        }
      } else {
        prefix0.print("Not Happening");
      }
    } catch (e) {
      prefix0
          .print("Exception result10: Complete Table   true  " + e.toString());
    } */

    try {
      result11 = await db.any_query(
          "SELECT * from complete where kural_no =$value ",
          "modi_kural_comp.db");
      print("Summa : result11: $result11");
      if (result11.isEmpty) {
        _isFavorited = false;
        _isfav = false;
      } else {
        _isFavorited = true;
        _isfav = true;
      }
      // prefix0.print("result11: ${result11[0]['kural_tamil1']}");
    } catch (Exception) {
      print("Exception result11:   true  " + Exception.toString());
    }
  }
  
}
