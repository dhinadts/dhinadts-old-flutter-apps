// import 'package:dictionary/otherApps/ImpWords/';
import 'package:flutter/material.dart';

import 'package:dictionary/main.dart';
import 'package:share/share.dart';

class ImpWords extends StatefulWidget {
  @override
  ImpWordsState createState() => ImpWordsState();
}

class ImpWordsState extends State<ImpWords> {
  String ImpWordsQuery = "select * from swords";
  List<ImpWordsGet> list = new List();
  ImpWordsGet product;

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
        title: Text("Important Words"),
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
      body: new Container(
        color: Colors.grey,
        child: Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  child: new ListView(
                children: list.map((ImpWordsGet product) {
                  return new ImpWords_list_design(product);
                }).toList(),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<ImpWordsGet>> cat() async {
    list.clear();
    List<Map> list1 = await db.anyQuery("select * from swords", "dic_new.db");

    for (int i = 0; i < list1.length; i++) {
      String set_engword = list1[i]['engword'];
      String set_tamilword = list1[i]['tamilword'];
      String set_synword = list1[i]['synword'];
      String set_anyword = list1[i]['anyword'];
      int set_id = i + 1;

      list.add(new ImpWordsGet(
        engword: set_engword,
        tamilword: set_tamilword,
        synword: set_synword,
        anyword: set_anyword,
        id: set_id,
      ));
    }
    setState(() {
      list.map((ImpWordsGet product) {
        ImpWords_list_design(product);
      }).toList();
    });
  }
}

class ImpWordsGet {
  String engword;
  String tamilword;
  String synword;
  String anyword;
  int id;

  ImpWordsGet(
      {String engword,
      String tamilword,
      String synword,
      String anyword,
      int id}) {
    this.engword = engword;
    this.tamilword = tamilword;
    this.synword = synword;
    this.anyword = anyword;
    this.id = id;
  }
}

class ImpWords_list_design extends StatefulWidget {
  var product;

  ImpWords_list_design(var product)
      : product = product,
        super(key: new ObjectKey(product));

  @override
  list_designState createState() {
    return new list_designState(product);
  }
}

class list_designState extends State<ImpWords_list_design> {
  var product;

  list_designState(this.product);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.0),
      child: Container(
          color: Colors.grey,
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Card(
                      borderOnForeground: true,
                      // color: Colors.blueGrey,
                      // margin: EdgeInsets.all(3.0),

                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Align(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '${product.id}. ${product.engword} \n',
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  ),
                                  GestureDetector(
                                    child: Icon(Icons.share),
                                    onTap: () {
                                      var a =
                                          "நித்ரா ஆங்கிலம் - தமிழ் அகராதி வழியாக பகிரப்பட்டது. இலவசமாக செயலியை தரவிறக்கம் செய்ய இங்கே கிளிக் செய்யுங்கள் :-\n https://goo.gl/7orr0d\n\nImportant Words :-\n\n${product.tamilword}\n\n${product.engword}\n\nSynonyms : ${product.synword}\n\nAntonyms : ${product.anyword}\n\nஇதுபோன்ற பல  Important Words நித்ரா ஆங்கிலம் - தமிழ் அகராதியில் உள்ளது. உடனே, தரவிறக்கம் செய்ய கீழ்க்கண்ட லிங்கை கிளிக் செய்யுங்கள்:- https://goo.gl/7orr0d";
                                      Share.share(a);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              child: Text(
                                '${product.tamilword}\n',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Align(
                              child: Text(
                                'Synonyms - ${product.synword}\n',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Align(
                              child: Text(
                                'Antonyms - ${product.anyword}\n',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                          ],
                        ),
                      ))),
            ],
          )),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

// // import 'package:dictionary/otherApps/ImpWords/';
// import 'package:flutter/material.dart';

// import 'package:dictionary/main.dart';
//   String impWordsQuery = "select * from swords";

// class ImpWords extends StatefulWidget {
//   @override
//   ImpWordsState createState() => ImpWordsState();
// }

// class ImpWordsState extends State<ImpWords> {
//   String impWordsQuery = "select * from swords";

//   @override
//   void initState() {
//     super.initState();
//     impWordsQ();
//   }

//   impWordsQ() async {
//     specialWords = await db.anyQuery(impWordsQuery, dbName);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomPadding: false,
//         appBar: AppBar(
//           title: Text("ImpWords"),
//           actions: <Widget>[],
//           leading: Builder(
//             builder: (BuildContext context) {
//               return IconButton(
//                 icon: const Icon(Icons.arrow_back_ios),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               );
//             },
//           ),
//         ),
//         body: Padding(
//           padding: EdgeInsets.only(bottom: 50),
//           child: new ListView.builder(
//             itemCount: specialWords.length,
//             itemBuilder: (context, i) => new Column(
//               children: <Widget>[
//                 new Divider(
//                   height: 10.0,
//                 ),
//                 new GestureDetector(
//                     onTap: () async {
//                       /* indexKey = i;
//                       var sql =
//                           'SELECT kuralno from thirukuralnew where catname = "${athikaram[i]['catname']}"';
//                       tenkurals = await db.anyQuery(sql, dbName);
//                       print(tenkurals);
//                       await Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   null //TenKurals()
//                                   )); */ // null = AdhikaramKural()
//                     },
//                     child: ListTile(
//                       title: new Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Card(
//                             child: Column(
//                               children: <Widget>[
//                                 Align(
//                                     alignment: Alignment.topRight,
//                                     child: Icon(Icons.share)),
//                                 Text(specialWords[i]['engword']),
//                                 Text(specialWords[i]['tamilword']),
//                                 Text(specialWords[i]['synword']),
//                                 Text(specialWords[i]['anyword']),
//                               ],
//                             ),
//                           ),
//                           // new Text(
//                           //   ImpWords[i]['tamiltxt'],
//                           //   style: new TextStyle(fontWeight: FontWeight.bold),
//                           // ),
//                         ],
//                       ),
//                     ))
//               ],
//             ),
//           ),
//         ));
//     /* ListView.builder(
//             itemCount: athikaram.length,
//             itemBuilder: (context, index) {
//               print("itemCount: ${athikaram.length}");
//               return ListTile(
//                 title: IconButton(
//                   alignment: Alignment.topRight,
//                   icon: Icon(Icons.share),
//                   onPressed: () {
//                     if (Platform.isAndroid) {
//                       Share.share(
//                           'உலக மக்கள் அனைவருக்கும்  ஈரடியில் உலக தத்துவத்தை எடுத்துரைக்கும் இது போன்ற திருக்குறளை உங்கள் நண்பர்களுக்கும் பகிர இங்கே கிளிக் செய்யுங்கள்.\n\n https://goo.gl/mZU2qr');
//                       // return new MyApp12345();
//                     } else if (Platform.isIOS) {
//                       Share.share(
//                           'உலக மக்கள் அனைவருக்கும்  ஈரடியில் உலக தத்துவத்தை எடுத்துரைக்கும் இது போன்ற திருக்குறளை உங்கள் நண்பர்களுக்கும் பகிர இங்கே கிளிக் செய்யுங்கள்.\n\n IOS Link');
//                       // return new MyApp12345();
//                     }
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 leading: Text("${athikaram[index]["catname"]}"),
//               );
//             }) */
//   }
// }
