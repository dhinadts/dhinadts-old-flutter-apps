import 'package:dictionary/otherApps/thirukkural/tenkural.dart';
import 'package:flutter/material.dart';

import 'package:dictionary/main.dart';

class Thirukkural extends StatefulWidget {
  @override
  ThirukkuralState createState() => ThirukkuralState();
}

class ThirukkuralState extends State<Thirukkural> {
  String queryAthikaram = "SELECT DISTINCT catname from thirukuralnew";
  List<AthikaramList> list = new List();
  AthikaramList product;

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
        title: Text("அதிகாரங்கள்"),
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
      body:

          // Padding(
          //   padding: EdgeInsets.only(bottom: 50),
          //   child: new ListView.builder(
          //     itemCount: athikaram.length,
          //     itemBuilder: (context, i) => new Column(
          //       children: <Widget>[
          //         new Divider(
          //           height: 10.0,
          //         ),
          //         new GestureDetector(
          //             onTap: () async {
          /* indexKey = i;
                      var sql =
                          'SELECT * from thirukuralnew where catname = "${athikaram[i]['catname']}"';
                      tenkurals = await db.anyQuery(sql, dbName);
                      print(tenkurals);
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TenKurals())); // null = AdhikaramKural() */
          //           },
          Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
            Expanded(
                child: new ListView(
              children: list.map((AthikaramList product) {
                return new Athikaram_list_design(product);
              }).toList(),
            )),
          ])),
    );
  }

  Future<List<AthikaramList>> cat() async {
    list.clear();
    List<Map> list1 =
        await db.anyQuery("SELECT DISTINCT catname from thirukuralnew", dbName);

    for (int i = 0; i < list1.length; i++) {
      String set_catname = list1[i]['catname'];
      int set_catid = i + 1;

      list.add(new AthikaramList(
        catname: set_catname,
        catid: set_catid,
      ));
    }
    setState(() {
      list.map((AthikaramList product) {
        Athikaram_list_design(product);
      }).toList();
    });
  }
}

class AthikaramList {
  String catname;
  int catid;
  AthikaramList({String catname, this.catid}) {
    this.catname = catname;
    this.catid = catid;
  }
}

class Athikaram_list_design extends StatefulWidget {
  var product;

  Athikaram_list_design(var product)
      : product = product,
        super(key: new ObjectKey(product));

  @override
  list_designState createState() {
    return new list_designState(product);
  }
}

class list_designState extends State<Athikaram_list_design> {
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
            print("${product.catid}");
            // indexKey = product.catid; + 1;
            var sql =
                'SELECT * from thirukuralnew where catname = "${product.catname}"';
            tenkurals = await db.anyQuery(sql, dbName);
            print(tenkurals);
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TenKurals(title: product.catname)));
          },
          child: Card(
              borderOnForeground: true,
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  '${product.catid}. ${product.catname}',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                trailing: GestureDetector(
                  child: Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    print("${product.catid}");
                    // indexKey = product.catid; + 1;
                    var sql =
                        'SELECT * from thirukuralnew where catname = "${product.catname}"';
                    tenkurals = await db.anyQuery(sql, dbName);
                    print(tenkurals);
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TenKurals(title: product.catname)));
                  },
                ),
                // Text(
                //   '${product.catname}',
                //   style:
                //       TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                // ),
              )),
          // onTap: () async {
          //   print("${product.catid}");
          //   // indexKey = product.catid; + 1;
          //   var sql =
          //       'SELECT * from thirukuralnew where catname = "${product.catname}"';
          //   tenkurals = await db.anyQuery(sql, dbName);
          //   print(tenkurals);
          //   await Navigator.push(
          //       context, MaterialPageRoute(builder: (context) => TenKurals(title: product.catname)));
          // },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
