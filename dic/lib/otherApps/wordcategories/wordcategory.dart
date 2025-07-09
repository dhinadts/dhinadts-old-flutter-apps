// WordListByCategory from adhikaram



import 'package:flutter/material.dart';


import 'package:dictionary/main.dart';

class WordListByCategory extends StatefulWidget {
  WordListByCategory({Key key}) : super(key: key);

  @override
  _WordListByCategoryState createState() => _WordListByCategoryState();
}

class _WordListByCategoryState extends State<WordListByCategory> {
  @override
  void initState() {
    super.initState();

    // result = db.anyQuery(query, dbName)
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
                Navigator.pop(context);
              },
            );
          },
        ),
        title: Text('${wordcat[indexKey]['engword']}'),
      ),
      body: new Container(
        child: Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.redAccent,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Text(
                            "S.no",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                      Expanded(
                          flex: 3,
                          child: Text("English Word",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      Expanded(
                          flex: 3,
                          child: Text("Tamil Meaning",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
              ),
              new Expanded(
                  child: new ListView.builder(
                      itemCount: wordlistbycat.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        var sno = index + 1;
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '$sno',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Divider(
                                    thickness: 5.0,
                                    color: Colors.black,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      '${wordlistbycat[index]['engword']}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      '${wordlistbycat[index]['tamilword']}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),

                                  /*   Text("$sno"),
                          Text("${wordlistbycat[index]['engword']}"),
                          Text("${wordlistbycat[index]['tamilword']}"), */
                                ],
                              ),
                              Divider(
                                height: 5.0,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        );
                      })),
            ],
          ),
        ),
      ),

      /* Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: Column(children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Text(
                      "S.no",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                Expanded(
                    flex: 3,
                    child: Text("English Word",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))),
                Expanded(
                    flex: 3,
                    child: Text("Tamil Meaning",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          new Expanded(
              child: new ListView.builder(
                  itemCount: wordlistbycat.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    var sno = index + 1;
                    return Container(
                      child: Row(
                        children: <Widget>[
                          Text("$sno"),
                          Text("${wordlistbycat[index]['engword']}"),
                          Text("${wordlistbycat[index]['tamilword']}"),
                        ],
                      ),
                    );
                  })),
        ]),
      ), */
    );
  }
}
