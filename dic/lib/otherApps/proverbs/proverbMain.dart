/* // import 'package:dictionary/otherApps/Proverb/';
import 'package:dictionary/otherApps/proverbs/proverbByCateList.dart';
import 'package:flutter/material.dart';

import 'package:dictionary/main.dart';

class Proverb extends StatefulWidget {
  @override
  ProverbState createState() => ProverbState();
}

class ProverbState extends State<Proverb> {
  String proverbCatQuery = "select DISTINCT engcat from proverbs";

  @override
  void initState() {
    super.initState();
    proverbQ();
  }

  proverbQ() async {
    proverbCat = await db.anyQuery(proverbCatQuery, dbName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Proverb Categories"),
          actions: <Widget>[],
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(bottom: 50),
          child: new ListView.builder(
            itemCount: proverbCat.length,
            itemBuilder: (context, i) => new Column(
              children: <Widget>[
                new Divider(
                  height: 10.0,
                ),
                new GestureDetector(
                    onTap: () async {
                      indexKey = i;
                      String proverbQuery =
                          "select engpro, tamilpro from proverbs where engcat = '${proverbCat[indexKey]['engcat']}'";
                      proverbByCat = await db.anyQuery(proverbQuery, dbName);
                      print(tenkurals);
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProverbListByCat() //TenKurals()
                              )); // null = AdhikaramKural()
                    },
                    child: ListTile(
                      title: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Card(
                            child: Column(
                              children: <Widget>[
                                Text(proverbCat[i]['engcat']),
                                  ],
                            ),
                          ),
    
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
    
  }
}


 */


import 'package:dictionary/otherApps/proverbs/proverbByCateList.dart';
import 'package:flutter/material.dart';

import 'package:dictionary/main.dart';

class Proverbs extends StatefulWidget {
  @override
  ProverbsState createState() => ProverbsState();
}

class ProverbsState extends State<Proverbs> {
  List<ProverbsList> list = new List();
  ProverbsList product;

  @override
  void initState() {
    super.initState();
    athikaramQ();
    cat();
  }

  athikaramQ() async {
    athikaram = await db.anyQuery(queryAthikaram, dbName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Proverbs - categories"),
        actions: <Widget>[],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ),
      body: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            Expanded(
                child: new ListView(
              children: list.map((ProverbsList product) {
                return new Proverbs_list_design(product);
              }).toList(),
            )),
          ])),
    );
  }

  Future<List<ProverbsList>> cat() async {
    list.clear();
    List<Map> list1 = await db.anyQuery(
        "SELECT DISTINCT engcat, tamilcat from proverbs", dbName);

    for (int i = 0; i < list1.length; i++) {
      String set_engcat = list1[i]['engcat'];
      String set_tamilcat = list1[i]['tamilcat'];
      int set_catid = i + 1;

      list.add(new ProverbsList(
        engcat: set_engcat,
        tamilcat: set_tamilcat,
        catid: set_catid,
      ));
    }
    setState(() {
      list.map((ProverbsList product) {
        Proverbs_list_design(product);
      }).toList();
    });
  }
}

class ProverbsList {
  String engcat;
  String tamilcat;
  int catid;
  ProverbsList({String engcat, String tamilcat, this.catid}) {
    this.engcat = engcat;
    this.tamilcat = tamilcat;
    this.catid = catid;
  }
}

class Proverbs_list_design extends StatefulWidget {
  var product;

  Proverbs_list_design(var product)
      : product = product,
        super(key: new ObjectKey(product));

  @override
  list_designState createState() {
    return new list_designState(product);
  }
}

class list_designState extends State<Proverbs_list_design> {
  var product;

  list_designState(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      padding: EdgeInsets.all(1.0),
      child: Container(
        child: GestureDetector(
          onTap: () async {
            indexKey = product.catid;

            String proverbQuery =
                "select engpro, tamilpro from proverbs where engcat = '${product.engcat}'";
            proverbByCat = await db.anyQuery(proverbQuery, dbName);
            print(tenkurals);
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProverbListByCat(title: product.tamilcat) //TenKurals()
                    )); // null = AdhikaramKural()
            /* var sql =
                'SELECT engpro, tamilpro from proverbs where engcat = "${product.engcat}"';
            tenkurals = await db.anyQuery(sql, dbName);
            print(tenkurals);
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>null /* TenKurals(title: product.catname) */)); */
          },
          child: Card(
              borderOnForeground: true,
              margin: EdgeInsets.all(8.0),
              
              child: ListTile(
                title: Text(
                  '${product.catid}. ${product.engcat} ',
                  style: TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                subtitle: Text(
                  ' ${product.tamilcat} ',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                trailing: GestureDetector(
                  child: Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    
                    String proverbQuery =
                        "select engpro, tamilpro from proverbs where engcat = '${product.engcat}'";
                    proverbByCat = await db.anyQuery(proverbQuery, dbName);
                    print(tenkurals);
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProverbListByCat(title: product.engcat,) //TenKurals()
                            ));
                  },
                ),
              )),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
