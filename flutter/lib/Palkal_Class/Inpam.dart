import 'package:dhina/tapOption.dart';
import 'package:flutter/material.dart';
import 'package:dhina/db/dbhelper.dart';
import 'package:dhina/fragments/first_fragment.dart';

import '../controllers.dart';
import '../searchingKural.dart';

// List<Map<String, dynamic>> result2;

class Inpam extends StatefulWidget {
  @override
  InpamState createState() {
    return new InpamState();
  }
}

class InpamState extends State<Inpam> {
  var xyz = TabBarDemo();
  @override
  void initState() {
    super.initState();
    iyalTamil(result[2]['pal_tamil']);

    // _onSelectItem1(result1[0]['pal_tamil']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('இயல்கள்'),
      ),
      body:
     new ListView.builder(
      itemCount: result3.length,
      itemBuilder: (context, i) => new Column(
        children: <Widget>[
          new Divider(
            height: 10.0,
          ),
          new GestureDetector(
              onTap: () async {
                // print("HI");
                indexKey = i;
                indexResult = result3;
                var db = DatabaseHelper();
                var sql =
                    'SELECT DISTINCT adhikarm_tamil from complete1 where iyal_tamil = "${indexResult[i]['iyal_tamil']}"';
                iyalIndex = await db.any_query(sql, "modi_kural_comp.db");
                print(iyalIndex);
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SearchingKural())); // null = AdhikaramKural()
              },
              child: ListTile(
                title: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      result3[i]['iyal_tamil'],
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ))

          /*
                  ListTile(
                    
                    title: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          iyal_S[i]['iyal_tamil'],
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ) */
        ],
      ),
    ));
  }
}

// _onSelectItem2(String s) async {
//   var db = DatabaseHelper();
//    result2 = await db.any_query(
//       'SELECT DISTINCT iyal_tamil from complete1 WHERE pal_tamil="$s"',
//       'modi_kural_comp.db');
//   List.generate(result2.length, (i) {
//     Iyal(
//       iyal_tamil: result2[i]['iyal_tamil'],
//     );
//   });
//   print(result2.length);
//   print(result2);

//   // Items I = new Items();
//   // I = result as Items;
//   // print(I.pal_tamil[0]);
// }
