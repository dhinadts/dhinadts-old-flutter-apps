// import 'dart:convert';

// import 'package:flutter/material.dart';

// import 'package:dictionary/main.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:share/share.dart';

// var phraseCompl;
// var topicname;
// var index;
// String phrasesList = "SELECT * from phrases";

// class Phrases extends StatefulWidget {
//   @override
//   PhrasesState createState() => PhrasesState();
// }

// class PhrasesState extends State<Phrases> {
//   // String queryAthikaram = "SELECT DISTINCT catname from thirukuralnew";

//   @override
//   void initState() {
//     super.initState();
//     // athikaramQ();
//     converCatQ();
//   }

//   converCatQ() async {
//     // athikaram = await db.anyQuery(queryAthikaram, dbName);
//     phraseCompl = await db.anyQuery(phrasesList, dbName);
//     // detailedCat = await db.anyQuery(detailQuery, dbName);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomPadding: false,
//         appBar: AppBar(
//           title: Text("Phrases"),
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
//             itemCount: phraseCompl.length,
//             itemBuilder: (context, i) {
//               return new ListTile(
//                 title: Column(
//                   children: <Widget>[
//                     Text(
//                       phraseCompl[i]['Idioms'], textAlign: TextAlign.left,
//                       style: new TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       phraseCompl[i]['EnglishMeaning'],textAlign: TextAlign.left,
//                       style: new TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       phraseCompl[i]['TamilMeaning'], textAlign: TextAlign.left,
//                       style: new TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       phraseCompl[i]['EnglishSentence'], textAlign: TextAlign.left,
//                       style: new TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       phraseCompl[i]['TamilSentence'], textAlign: TextAlign.left,
//                       style: new TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 trailing: GestureDetector(
//                   child: Icon(Icons.share),
//                   onTap: () {
//                     Share.share("text");
//                   },
//                 ),
//               );
//               //   children: // null,
//               //   /* for(var im =0; im<convCat.length; im++) */
//               //        _getChildren(convCat[i]['categoryname']),
//               //       //  onExpansionChanged: summa(convCat[i]['categoryname']),
//               //   // _buildExpandableContent(convCat[i]['categoryname']),
//               // );
//             },
//           ),
//         ));
//   }

  
// }




// String idiomsList = "SELECT * from idioms";
// var idiomsCompl;

// class Idioms extends StatefulWidget {
//   @override
//   IdiomsState createState() => IdiomsState();
// }

// class IdiomsState extends State<Idioms> {
//   // String queryAthikaram = "SELECT DISTINCT catname from thirukuralnew";

//   @override
//   void initState() {
//     super.initState();
//     // athikaramQ();
//     converCatQ();
//   }

//   converCatQ() async {
//     // athikaram = await db.anyQuery(queryAthikaram, dbName);
//     idiomsCompl = await db.anyQuery(idiomsList, dbName);
//     // detailedCat = await db.anyQuery(detailQuery, dbName);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomPadding: false,
//         appBar: AppBar(
//           title: Text("Idioms"),
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
//             itemCount: idiomsCompl.length,
//             itemBuilder: (context, i) {
//               return new ListTile(
//                 title: Column(
//                   children: <Widget>[
//                     Text(
//                       idiomsCompl[i]['Idioms'], textAlign: TextAlign.left,
//                       style: new TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       idiomsCompl[i]['EnglishMeaning'],textAlign: TextAlign.left,
//                       style: new TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       idiomsCompl[i]['TamilMeaning'], textAlign: TextAlign.left,
//                       style: new TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       idiomsCompl[i]['EnglishSentence'], textAlign: TextAlign.left,
//                       style: new TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       idiomsCompl[i]['TamilSentence'], textAlign: TextAlign.left,
//                       style: new TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 trailing: GestureDetector(
//                   child: Icon(Icons.share),
//                   onTap: () {
//                     Share.share("text");
//                   },
//                 ),
//               );
              
//             },
//           ),
//         ));
//   }

  
// }


import 'package:flutter/material.dart';

import 'package:dictionary/main.dart';
import 'package:share/share.dart';

class Phrases extends StatefulWidget {
  @override
  PhrasesState createState() => PhrasesState();
}

class PhrasesState extends State<Phrases> {
  String PhrasesQuery = "select * from phrases";
  List<PhrasesGet> list = new List();
  PhrasesGet product;

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
        title: Text("Phrases"),
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
                children: list.map((PhrasesGet product) {
                  return new Phrases_list_design(product);
                }).toList(),
              )),
            ],
          ),
        ),
      ),

    );
  }

  Future<List<PhrasesGet>> cat() async {
    list.clear();
    List<Map> list1 = await db.anyQuery("select * from phrases", "dic_new.db");

    for (int i = 0; i < list1.length; i++) {
      String set_Idioms = list1[i]['Idioms'];
      String set_EnglishMeaning = list1[i]['EnglishMeaning'];
      String set_TamilMeaning = list1[i]['TamilMeaning'];
      String set_EnglishSentence = list1[i]['EnglishSentence'];
      String set_TamilSentence = list1[i]['TamilSentence'];
      int set_id = i + 1;

      list.add(new PhrasesGet(
        Idioms: set_Idioms,
        EnglishMeaning: set_EnglishMeaning,
        TamilMeaning: set_TamilMeaning,
        EnglishSentence: set_EnglishSentence,
        TamilSentence: set_TamilSentence,
        id: set_id,
      ));
    }
    setState(() {
      list.map((PhrasesGet product) {
        Phrases_list_design(product);
      }).toList();
    });
  }
}

class PhrasesGet {
  String Idioms;
  String EnglishMeaning;
  String TamilMeaning;
  String EnglishSentence;
  String TamilSentence;
  int id;

  PhrasesGet(
      {String Idioms,
      String EnglishMeaning,
      String TamilMeaning,
      String EnglishSentence,
      String TamilSentence,
      int id}) {
    this.Idioms = Idioms;
    this.EnglishMeaning = EnglishMeaning;
    this.TamilMeaning = TamilMeaning;
    this.EnglishSentence = EnglishSentence;
    this.TamilSentence = TamilSentence;
    this.id = id;
  }
}

class Phrases_list_design extends StatefulWidget {
  var product;

  Phrases_list_design(var product)
      : product = product,
        super(key: new ObjectKey(product));

  @override
  list_designState createState() {
    return new list_designState(product);
  }
}

class list_designState extends State<Phrases_list_design> {
  var product;

  list_designState(this.product);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
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
                                    'Phrases: ${product.id}\n',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  ),
                                  GestureDetector(
                                    child: Icon(Icons.share),
                                    onTap: () {
                                      var a = "நித்ரா ஆங்கிலம் - தமிழ் அகராதி வழியாக பகிரப்பட்டது. இலவசமாக செயலியை தரவிறக்கம் செய்ய இங்கே கிளிக் செய்யுங்கள் :-\n https://goo.gl/7orr0d \n\n Phrase:-\n${product.Idioms}\n\n English Meaning :-\n ${product.EnglishMeaning}\n\n Tamil Meaning :-\n ${product.TamilMeaning}\n\n English Sentence :-\n ${product.EnglishSentence}\n\n Tamil Sentence :-\n ${product.TamilSentence}\n\n இதுபோன்ற பல Phrases நித்ரா ஆங்கிலம் - தமிழ் அகராதியில் உள்ளது. உடனே, தரவிறக்கம் செய்ய கீழ்க்கண்ட லிங்கை கிளிக் செய்யுங்கள்:-\n https://goo.gl/7orr0d";
                                      Share.share(a);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              child: Text(
                                '${product.Idioms}\n',
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Divider(
                              thickness: 1.0,
                              color: Colors.black,
                            ),
                            Align(
                              child: Text(
                                'English Meaning :-\n',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Align(
                              child: Text(
                                '${product.EnglishMeaning}\n',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Divider(
                              thickness: 1.0,
                              color: Colors.black,
                            ),
                            Align(
                              child: Text(
                                'Tamil Meaning :-\n',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Align(
                              child: Text(
                                '${product.TamilMeaning}\n',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Divider(
                              thickness: 1.0,
                              color: Colors.black,
                            ),
                            Align(
                              child: Text(
                                'English Sentence :-\n',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Align(
                              child: Text(
                                '${product.EnglishSentence}\n',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Divider(
                              thickness: 1.0,
                              color: Colors.black,
                            ),
                            Align(
                              child: Text(
                                'Tamil Sentence :-\n',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Align(
                              child: Text(
                                '${product.TamilSentence}\n',
                                style: TextStyle(
                                    color: Colors.black,
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






// import 'package:flutter/material.dart';

// import 'package:dictionary/main.dart';
// import 'package:share/share.dart';

class Idioms extends StatefulWidget {
  @override
  IdiomsState createState() => IdiomsState();
}

class IdiomsState extends State<Idioms> {
  String IdiomsQuery = "select * from idioms";
  List<IdiomsGet> list = new List();
  IdiomsGet product;

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
        title: Text("Idioms"),
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
                children: list.map((IdiomsGet product) {
                  return new Idioms_list_design(product);
                }).toList(),
              )),
            ],
          ),
        ),
      ),

    );
  }

  Future<List<IdiomsGet>> cat() async {
    list.clear();
    List<Map> list1 = await db.anyQuery("select * from idioms", "dic_new.db");

    for (int i = 0; i < list1.length; i++) {
      String set_Idioms = list1[i]['Idioms'];
      String set_EnglishMeaning = list1[i]['EnglishMeaning'];
      String set_TamilMeaning = list1[i]['TamilMeaning'];
      String set_EnglishSentence = list1[i]['EnglishSentence'];
      String set_TamilSentence = list1[i]['TamilSentence'];
      int set_id = i + 1;

      list.add(new IdiomsGet(
        Idioms: set_Idioms,
        EnglishMeaning: set_EnglishMeaning,
        TamilMeaning: set_TamilMeaning,
        EnglishSentence: set_EnglishSentence,
        TamilSentence: set_TamilSentence,
        id: set_id,
      ));
    }
    setState(() {
      list.map((IdiomsGet product) {
        Idioms_list_design(product);
      }).toList();
    });
  }
}

class IdiomsGet {
  String Idioms;
  String EnglishMeaning;
  String TamilMeaning;
  String EnglishSentence;
  String TamilSentence;
  int id;

  IdiomsGet(
      {String Idioms,
      String EnglishMeaning,
      String TamilMeaning,
      String EnglishSentence,
      String TamilSentence,
      int id}) {
    this.Idioms = Idioms;
    this.EnglishMeaning = EnglishMeaning;
    this.TamilMeaning = TamilMeaning;
    this.EnglishSentence = EnglishSentence;
    this.TamilSentence = TamilSentence;
    this.id = id;
  }
}

class Idioms_list_design extends StatefulWidget {
  var product;

  Idioms_list_design(var product)
      : product = product,
        super(key: new ObjectKey(product));

  @override
  list_designState_i createState() {
    return new list_designState_i(product);
  }
}

class list_designState_i extends State<Idioms_list_design> {
  var product;

  list_designState_i(this.product);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
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
                                    'Idioms: ${product.id}\n',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  ),
                                  GestureDetector(
                                    child: Icon(Icons.share),
                                    onTap: () {
                                      var a = "நித்ரா ஆங்கிலம் - தமிழ் அகராதி வழியாக பகிரப்பட்டது. இலவசமாக செயலியை தரவிறக்கம் செய்ய இங்கே கிளிக் செய்யுங்கள் :-\n https://goo.gl/7orr0d \n\n Idiom:-\n${product.Idioms}\n\n English Meaning :-\n ${product.EnglishMeaning}\n\n Tamil Meaning :-\n ${product.TamilMeaning}\n\n English Sentence :-\n ${product.EnglishSentence}\n\n Tamil Sentence :-\n ${product.TamilSentence}\n\n இதுபோன்ற பல Phrases நித்ரா ஆங்கிலம் - தமிழ் அகராதியில் உள்ளது. உடனே, தரவிறக்கம் செய்ய கீழ்க்கண்ட லிங்கை கிளிக் செய்யுங்கள்:-\n https://goo.gl/7orr0d";
                                      Share.share("$a");
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              child: Text(
                                '${product.Idioms}\n',
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Divider(
                              thickness: 1.0,
                              color: Colors.black,
                            ),
                            Align(
                              child: Text(
                                'English Meaning :-\n',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Align(
                              child: Text(
                                '${product.EnglishMeaning}\n',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Divider(
                              thickness: 1.0,
                              color: Colors.black,
                            ),
                            Align(
                              child: Text(
                                'Tamil Meaning :-\n',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Align(
                              child: Text(
                                '${product.TamilMeaning}\n',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Divider(
                              thickness: 1.0,
                              color: Colors.black,
                            ),
                            Align(
                              child: Text(
                                'English Sentence :-\n',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Align(
                              child: Text(
                                '${product.EnglishSentence}\n',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Divider(
                              thickness: 1.0,
                              color: Colors.black,
                            ),
                            Align(
                              child: Text(
                                'Tamil Sentence :-\n',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Align(
                              child: Text(
                                '${product.TamilSentence}\n',
                                style: TextStyle(
                                    color: Colors.black,
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






