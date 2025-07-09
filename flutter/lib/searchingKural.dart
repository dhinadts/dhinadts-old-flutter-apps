import 'package:dhina/tapOption.dart';
import 'package:dhina/tenkurals.dart';
import 'package:flutter/material.dart';
import 'package:dhina/db/dbhelper.dart';



var adhikaramIndex;

class SearchingKural extends StatefulWidget {
  SearchingKural({Key key}) : super(key: key);

  @override
  _SearchingKuralState createState() => _SearchingKuralState();
}

class _SearchingKuralState extends State<SearchingKural> {
  

  @override
  void initState() {
    super.initState();

    // result = db.any_query(query, dbName)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        // resizeToAvoidBottomInset: true,
        extendBody: true,
        appBar: AppBar(
          primary: true,
          leading: Builder(
            
            builder: (BuildContext context) {
              

              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  // Scaffold.of(context).openDrawer();
                  //       Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => FirstFragment()),
                  // );
                  Navigator.pop(context);
                },
                // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
    // MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     theme: new ThemeData(
    //       primarySwatch: Colors.blueGrey,
    //     ),
    //     home: DefaultTabController(
    //         length: indexResult.length,
    //         child: Scaffold(
    //             appBar: AppBar(
    //               actions: <Widget>[
    //                 IconButton(
    //             icon: const Icon(Icons.arrow_back),
    //             onPressed: () {
    //               // Scaffold.of(context).openDrawer();
    //               //       Navigator.push(
    //               //   context,
    //               //   MaterialPageRoute(builder: (context) => FirstFragment()),
    //               // );
    //               Navigator.pop(context);
    //             },
    //             // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
    //           ),
    //               ],
                  title: Text('${indexResult[indexKey]['iyal_tamil']}'),
                ),
                body: new ListView.builder(
                    itemCount: iyalIndex.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return GestureDetector(
                  onTap: () async {
                    // print("HI");
                    // indexKey = index;
                    // indexResult = result1;
                    //print(indexResult);
                    // _adhikaramDisplay();
                    var db = DatabaseHelper();
                    var sql =
                        'SELECT * from complete1 where adhikarm_tamil = "${iyalIndex[index]['adhikarm_tamil']}"';
                    adhikaramIndex = await db.any_query(sql, "modi_kural_comp.db");
                    print(adhikaramIndex.length);

                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TenSearchingKural() ));
                                // SearchingKural())); // null = AdhikaramKural()
                  },
                  child: ListTile(
                    title: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          '${iyalIndex[index]['adhikarm_tamil']}',
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ));
                      // new ListTile(
                      //   title: new Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: <Widget>[
                      //       new Text(
                      //         '${iyalIndex[index]['adhikarm_tamil']}',
                      //         style: new TextStyle(fontWeight: FontWeight.bold),
                      //       ),
                      //     ],
                      //   ),
                      // );
                    })


                );
  }
}

// _adhikaramDisplay() async {

// var db = DatabaseHelper();
// var sql = "SELECT * from complete1 where iyal_tamil = ${indexResult[indexKey]['iyal_tamil']}";
// iyalIndex = await db.any_query(sql, "modi_kural_comp.db");
// print(iyalIndex);

// }
