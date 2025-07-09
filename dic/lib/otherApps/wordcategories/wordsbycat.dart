import 'package:dictionary/otherApps/wordcategories/wordcategory.dart';
import 'package:flutter/material.dart';
import 'package:dictionary/imports.dart';
import 'package:dictionary/main.dart';

class WordCategory extends StatefulWidget {
  @override
  WordCategoryState createState() => WordCategoryState();
}

class WordCategoryState extends State<WordCategory> {
  List<WordGet> list = new List();
  WordGet product;

  @override
  void initState() {
    super.initState();
    wordCatQ();
    cat();
  }

  wordCatQ() async {
    wordcat = await db.anyQuery("SELECT * from tamilcategory", dbName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          // backgroundColor: Colors.grey,
          title: Text("WordCategory"),
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
          color: Colors.grey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Expanded(
                  child: new ListView(
                children: list.map((WordGet product) {
                  return new Word_list_design(product);
                }).toList(),
              )),
            ])

            /*  new ListView.builder(
              itemCount: wordcat.length,
              itemBuilder: (context, i) {
                var no = i + 1;
                return new Card(
                  child: 
                
                    ListTile(
                      trailing: GestureDetector(
                        onTap: () async {
                          indexKey = i;
                          wordlistbycat = await db.anyQuery(
                              'SELECT * from tamilwords where catid ="${wordcat[indexKey]['catid']}"',
                              dbName);
                          
                          print(tenkurals);
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      // TenKurals()
                                      WordListByCategory())); // null = AdhikaramKural()
                        },
                        child: Icon(Icons.arrow_right),
                      ),
                      leading: new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(
                            "$no. ${wordcat[i]['engword']}",
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            wordcat[i]['tamilword'],
                            style: new TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                   
                );
              }), */
            ));
  }

  Future<List<WordGet>> cat() async {
    list.clear();
    List<Map> list1 = await db.anyQuery("SELECT * from tamilcategory", dbName);

    for (int i = 0; i < list1.length; i++) {
      int set_catid = list1[i]['catid'];
      String set_engword = list1[i]['engword'];
      String set_tamilword = list1[i]['tamilword'];

      list.add(new WordGet(
        catid: set_catid,
        engword: set_engword,
        tamilword: set_tamilword,
      ));
    }
    setState(() {
      list.map((WordGet product) {
        Word_list_design(product);
      }).toList();
    });
  }
}

class WordGet {
  int catid;
  String engword;
  String tamilword;

  WordGet({int catid, String engword, String tamilword}) {
    this.catid = catid;
    this.engword = engword;
    this.tamilword = tamilword;
  }
}

class Word_list_design extends StatefulWidget {
  var product;

  Word_list_design(var product)
      : product = product,
        super(key: new ObjectKey(product));

  @override
  list_designState createState() {
    return new list_designState(product);
  }
}

class list_designState extends State<Word_list_design> {
  var product;

  list_designState(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.0),
      child: Container(
        child: GestureDetector(
          child: Card(
              borderOnForeground: true,
              // color: Colors.blueGrey,
              margin: EdgeInsets.all(8.0),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    /* Column(
                    children: <Widget>[
                      Text(
                        '${product.catid}. ${product.engword} \n',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        '${product.tamilword}',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ) */
                    ListTile(
                  title: Text("${product.catid}. ${product.engword}", 
                   style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent,
                                ),
                  ),
                  subtitle: Text("${product.tamilword}",
                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                  ),
                  trailing: GestureDetector(
                    child: Icon(Icons.arrow_forward_ios, color: Colors.black,),
                    onTap: () async {
                      print("${product.catid}");
                      wordlistbycat = await db.anyQuery(
                          'SELECT * from tamilwords where catid = "${product.catid}"',
                          dbName);
                      print(wordlistbycat);
                      indexKey = product.catid - 1;

                      // print(tenkurals);
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  // TenKurals()
                                  WordListByCategory())); // null = AdhikaramKural()
                    },
                  ),
                ),
              )),
          onTap: () async {
            print("${product.catid}");
            wordlistbycat = await db.anyQuery(
                'SELECT * from tamilwords where catid = "${product.catid}"',
                dbName);
            print(wordlistbycat);
            indexKey = product.catid - 1;

            // print(tenkurals);
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        // TenKurals()
                        WordListByCategory())); // null = AdhikaramKural()
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
