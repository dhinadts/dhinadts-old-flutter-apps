import 'dart:convert';

import 'package:dictionary/otherApps/baamini2unicode.dart';
import 'package:flutter/material.dart';

import 'package:dictionary/main.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:share/share.dart';

class Conversations21 extends StatefulWidget {
  @override
  Conversations21State createState() => Conversations21State();
}

class Conversations21State extends State<Conversations21> {
  List<ConverCat> list = new List();
  ConverCat product;

  @override
  void initState() {
    super.initState();

    cat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("உரையாடல்கள்"),
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
              children: list.map((ConverCat product) {
                return new CoverSations_list_design(product);
              }).toList(),
            )),
          ])),
    );
  }

  Future<List<ConverCat>> cat() async {
    list.clear();
    List<Map> list1 = await db.anyQuery(
        "SELECT DISTINCT categoryname from conversation", dbName);

    for (int i = 0; i < list1.length; i++) {
      String set_categoryname = list1[i]['categoryname'];
      int set_catid = i + 1;

      list.add(new ConverCat(
        categoryname: set_categoryname,
        catid: set_catid,
      ));
    }
    setState(() {
      list.map((ConverCat product) {
        CoverSations_list_design(product);
      }).toList();
    });
  }
}

class ConverCat {
  String categoryname;
  int catid;
  ConverCat({String categoryname, this.catid}) {
    this.categoryname = categoryname;
    this.catid = catid;
  }
}

class CoverSations_list_design extends StatefulWidget {
  var product;

  CoverSations_list_design(var product)
      : product = product,
        super(key: new ObjectKey(product));

  @override
  list_designState createState() {
    return new list_designState(product);
  }
}

var topicname;

class list_designState extends State<CoverSations_list_design> {
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
                // 'SELECT * from thirukuralnew where catname = "${product.catname}"';
                'select topicname from conversation where categoryname ="${product.categoryname}"';
            topicname = await db.anyQuery(sql, dbName);
            print(tenkurals);
            await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      new Conversations2(title: product.categoryname),
                ));
          },
          child: Card(
              borderOnForeground: true,
              margin: EdgeInsets.only(top: 4.0),
              child: ListTile(
                title: Text(
                  '${product.catid}. ${product.categoryname}',
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
                        // 'SELECT * from thirukuralnew where catname = "${product.catname}"';
                        'select topicname from conversation where categoryname ="${product.categoryname}"';
                    topicname = await db.anyQuery(sql, dbName);
                    print(tenkurals);
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              new Conversations2(title: product.categoryname),
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

class Conversations2 extends StatelessWidget {
  final String title;

  Conversations2({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          // backgroundColor: Colors.grey,
          title: Text("$title"),
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
            child: Container(
              // color: Colors.grey,
              child: new ListView.separated(
                itemCount: topicname.length,
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.redAccent,
                    endIndent: 1.0,
                  );
                },
                itemBuilder: (context, i) {
                  return new GestureDetector(
                    /* child: Card(
                   borderOnForeground: true,
                  elevation: 1.0, */
                    child: ListTile(
                      title: Text(
                        topicname[i]['topicname'],
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: GestureDetector(
                        child: Icon(Icons.arrow_right),
                        onTap: () async {
                          var webView = await db.anyQuery(
                              'SELECT * FROM conversation  where topicname = "${topicname[i]['topicname']}"',
                              dbName);
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => new ConversationswebView(
                                    webView: webView[0]['conversation_ss'],
                                    title: webView[0]['topicname']),
                              ));
                        },
                      ),
                    ),
                    onTap: () async {
                      var webView = await db.anyQuery(
                          'SELECT * FROM conversation  where topicname = "${topicname[i]['topicname']}"',
                          dbName);
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => new ConversationswebView(
                                webView: webView[0]['conversation_ss'],
                                title: webView[0]['topicname']),
                          ));
                    },
                  );
                },
              ),
            )));
  }
}

class ConversationswebView extends StatelessWidget {
  final String webView;
  final String title;
  ConversationswebView({Key key, @required this.webView, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: ListTile(
            title: Text(
              "${this.title}",
              maxLines: 2,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                var a =
                    "நித்ரா ஆங்கிலம் - தமிழ் அகராதி வழியாக பகிரப்பட்டது. இலவசமாக செயலியை தரவிறக்கம் செய்ய இங்கே கிளிக் செய்யுங்கள் :- https://goo.gl/7orr0d ";

                HtmltoTamilUtil tu = new HtmltoTamilUtil();
                var b = tu.convertToBamini("${this.webView}");
                print(this.webView);
                print(b);
                 var j =
                    "\n\nஇதுபோன்ற உரையாடல்களை அறிந்து கொள்ள  ஆங்கிலம் - தமிழ் அகராதி மென்பொருளை தரவிறக்கம் செய்ய இந்த லிங்கை கிளிக் செய்யவும்:- http://bit.ly/2kE4soU ";
                Share.share("$a$b$j");
              },
            )
          ],
        ),
        body: new WebviewScaffold(
          scrollBar: false,
          url: new Uri.dataFromString(this.webView,
                  encoding: Encoding.getByName('utf-8'), mimeType: 'text/html')
              .toString(),
        ));
  }
}
