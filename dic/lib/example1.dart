// tenkurals from adhikaram

import 'package:dictionary/imports.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'main.dart';

// var engWords = new List();
var title1;

int pagess = 0;
bool _hasSpeech = false;
var fav = false;
// var allWords;
// List<Map<String, dynamic>> allWords;
var cursor = pageNo;
// var pageNo=0;
var currentPageValue;
int intexvalue = 0;

String tamilmeaning = '';
String grammar = '';
String moremeaning = '';
Bloc bloc = new Bloc();
var query;

class WordSearchRes1 extends StatefulWidget {
  final String title;
  final int id;

  WordSearchRes1({Key key, @required this.title, @required this.id})
      : super(key: key);

  @override
  _WordSearchRes1State createState() => _WordSearchRes1State();
}

class _WordSearchRes1State extends State<WordSearchRes1> {
  // TextEditingController editingController = TextEditingController();
  final editingController = TextEditingController();

  /* String dictionary = "select engword from Dic_Unicode";
  String secondDictionary = "select engword from Dictionary "; */
  // String completeDictionary =
  //     "select DISTINCT engword from Dictionary"; // ORDER by engword ASC";

  var items = new List();
  final SpeechToText speech = SpeechToText();
  bool _hasSpeech = false;
  bool _stressTest = false;
  int _stressLoops = 0;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String currentLocaleId = "";
  List<LocaleName> _localeNames = [];
  String searchword = '';
  String tamilword = '';
  String moretamilword = '';
  String grammar = '';
  bool secondcard = false;
  bool moremeaingcol = true;
  bool grammarcol = true;

/*
  PageController controller = PageController(
    initialPage: pageNo,
  );
*/

  @override
  Future<void> initState() {
    // items.addAll(engWords);
    super.initState();
    query123(pageNo);
    print("page no $pageNo");
    /* controller.addListener(() {
      setState(() {
        currentPageValue = controller.page;
        print("currntpage::: $currentPageValue , page:::: $pagess");
      });
    });*/
    //searchTextController.text = allWords[pageNo]["EngWord"];
    //print('59 ${searchTextController.text}');

    initSpeechState();
  }

  query123(int id) async {
    /* var currentWords = await db.anyQuery('select id from Dic_Unicode where EngWord="${widget.title}"  ', dbName);
    pagess =currentWords[0]['id']; */
    // var index1 = await db.anyQuery("select id from Dic_Unicode ", dbName);

    /*allWords = await db.anyQuery(completeDictionary, dbName);
    for (var i = 0; i < dictionaryWords.length; i++) {
      engWords.add(allWords[i]["EngWord"]);
    }*/
    print("meee");
    await queryfun(id);
  }

  queryfun(int id) async {
    searchword = "";
    tamilword = "";
    moretamilword = "";
    grammar = "";
    query =
        await db.anyQuery("SELECT * from Dic_Unicode where id= $id", dbName);
    print("Querry " + query.toString());
    await condition(query[0]["EngWord"]);
    // bloc.set_tamilmeaning("${query[0]["EngWord"]}");
    /*setState(() {
      searchword = query[0]["EngWord"];
      tamilword = query[0]["TamilWord"];
    });*/

    print("eeee ${query[0]["EngWord"]}");
  }

  condition(String data) async {
    var con;

    con = await db.anyQuery(
        "select tamilword from Dictionary where engword like '$data'", dbName);
    //  print("conn ${con[0]['TamilWord']}");
    print("conn ${con.toString()} len ${con.length}");

    String tw = query[0]['TamilWord'];
    searchword = query[0]["EngWord"];
    searchTextController.text = searchword;
    String gram = query[0]["Grammar"];

    if (gram.startsWith("-")) {
      grammarcol = false;
    } else {
      grammarcol = true;
      grammar = query[0]["Grammar"];
    }

    if (tw.startsWith("-")) {
      // tamilmeaning = '${con[0]['TamilWord']}';

      setState(() {
        // morecard = false;
        moremeaingcol = false;
        if (grammarcol == false) {
          secondcard = false;
        } else {
          secondcard = true;
        }
        if (con.length != 0) {
          tamilword = con[0]['TamilWord'];
        } else {
          tamilword = "-";

          print("- elsee part");
        }
      });
    } else {
      setState(() {
        // morecard = true;
        String t1, t2;
        if (query[0]['TamilWord_one'] == "-") {
          t1 = "";
        } else {
          t1 = ", ${query[0]['TamilWord_one']}";
        }
        if (query[0]['TamilWord_two'] == "-") {
          t2 = "";
        } else {
          t2 = ', ${query[0]["TamilWord_two"]}';
        }

        tamilword = "$tw$t1$t2";
        if (con.length != 0) {
          moretamilword = con[0]['TamilWord'];
          print("morr $moretamilword");
          if (moretamilword.length == 0) {
            moremeaingcol = false;
            if (gram.startsWith("-")) {
              secondcard = false; //true
            } else {
              secondcard = true;
            }
          } else {
            moremeaingcol = true;
            secondcard = true;
          }
        } else {
          if (gram.startsWith("-")) {
            secondcard = false; //true
          } else {
            secondcard = true;
          }
          moremeaingcol = false;
          print("else part");
        }

        print("tam $tamilword");
        // }
      });
    }

    print("tamil $tamilmeaning");
    /* if(data){

    }*/

    print("datas");
    print("Gram word $gram ,col $grammarcol , sd $secondcard");
    print("morem word $moretamilword ,col  $moremeaingcol");
  }

  @override
  void dispose() {
    super.dispose();
    items.clear();
    // query.clear();
  }

  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener);
    print("hasspeech  $hasSpeech");
    if (hasSpeech) {
      _localeNames = await speech.locales();
      var systemLocale = await speech.systemLocale();
      currentLocaleId = systemLocale.localeId;
    }
    if (!mounted) return;
    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  void stressTest() {
    if (_stressTest) {
      return;
    }
    _stressLoops = 0;
    _stressTest = true;
    print("Starting stress test...");
    startListening();
  }

  void changeStatusForStress(String status) {
    if (!_stressTest) {
      return;
    }
    if (speech.isListening) {
      stopListening();
    } else {
      if (_stressLoops >= 100) {
        _stressTest = false;
        print("Stress test complete.");
        return;
      }
      print("Stress loop: $_stressLoops");
      ++_stressLoops;
      startListening();
    }
  }

  void stopListening() {
    speech.stop();
    utility_basic.toastfun("Time Elapsed");

    setState(() {});
  }

  void cancelListening() {
    speech.cancel();
    setState(() {});
  }

  void errorListener(SpeechRecognitionError error) {
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  void statusListener(String status) {
    changeStatusForStress(status);
    setState(() {
      lastStatus = "$status";
    });
  }

  void startListening() {
    utility_basic.toastfun("Speak Now..");

    lastWords = "";
    lastError = "";
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 10),
        localeId: currentLocaleId);
    setState(() {});
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = "${result.recognizedWords}";
      searchTextController.text = lastWords;
      filterSearchResults(searchTextController.text);
    });
  }

  Future<void> filterSearchResults(String query) async {
    // query = query; // .toLowerCase();
    //  List dummySearchList = List();
    //  dummySearchList.addAll(engWords);
    // List dummySearchList = List();
    // dummySearchList.addAll(engWords);
    if (query.isNotEmpty) {
      List dummyListData = List();
      allWords = await db.anyQuery(
          "SELECT EngWord FROM Dic_Unicode WHERE EngWord LIKE '$query%' ORDER by EngWord ASC",
          dbName);
      /* //allWords = await db.anyQuery("select EngWord,TamilWord from Dic_Unicode where", dbName);
      allWords.forEach((item) {
        if (item.startsWith(query)) {*/
      if (allWords.length == 0) {
        allWords = await db.anyQuery(
            "SELECT TamilWord FROM Dic_Unicode WHERE TamilWord LIKE '$query%' ORDER by TamilWord ASC",
            dbName);
        for (int i = 0; i < allWords.length; i++) {
          dummyListData.add(allWords[i]["TamilWord"]);
        }
      } else {
        for (int i = 0; i < allWords.length; i++) {
          dummyListData.add(allWords[i]["EngWord"]);
        }
      }
      print("allll" + allWords.toString());
      print("allword len  ${allWords.length}");

      /* }
      });*/
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      if (allWords.length == 0) {
        items.add("No Match Found");
      }
      return;
    } else {
      setState(() {
        items.clear();
      });
    }
  }

  Future _speak() async {
    if (searchTextController.text.isNotEmpty) {
      var result = await flutterTts.speak(searchword);
      if (result == 1) setState(() => ttsState = TtsState.playing);
    }
  }

  @override
  Widget build(BuildContext context) {
    //searchTextController.text =allWords[intexvalue]["EngWord"];
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        // resizeToAvoidBottomInset: true,
        // extendBody: true,
        appBar: AppBar(
          leading: Container(),
          elevation: 0.0,

          flexibleSpace: PreferredSize(
          child: Padding(
            padding:
            EdgeInsets.only( left: 15.0, right: 15.0,top: 30.0),
            child: Container(
              height: 45.0, //40
              //color: Colors.white,
              decoration: new BoxDecoration(
                  borderRadius:
                  new BorderRadius.all(new Radius.circular(15.0)),
                  color: Colors.white),
              //padding: new EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              child: TextField(
                controller: new TextEditingController.fromValue(
                    new TextEditingValue(
                        text: searchTextController.text,
                        selection: new TextSelection.collapsed(
                            offset: searchTextController.text.length))),
                onChanged: (value) {
                  searchTextController.text = value;
                  searchTextController.selection = TextSelection.fromPosition(
                      TextPosition(offset: searchTextController.text.length));
                  filterSearchResults(value);

                  print('${searchTextController.text}');
                  print(value);
                },
                decoration: InputDecoration(
                  // labelText: "Search",
                    hintText: "Search",
                    suffix:  Padding(
                        padding: EdgeInsets.only(top: 30.0),
                      ),

                    suffixIcon: GestureDetector(
                      child: Icon(Icons.keyboard_voice),
                      onTap: () {
                        if (_hasSpeech == true) {
                          if (speech.isListening == false) {
                            startListening();
                          }
                        } else {
                          utilityBasic.toastfun("need internet");
                        }
                      },
                    ),
                    prefixIcon: GestureDetector(
                    child: Icon(Icons.arrow_back_ios,color: Colors.black,),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(15.0)))),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(60.0), //60
        ),),

        body: SafeArea(
          child: Container(
               color: Color(0xffF9F9F9),
              child: Padding(
            padding: EdgeInsets.only(bottom: 0.0),
            child: Column(children: <Widget>[
             /* Container(
                color: Colors.blue,
                child: Container(
                  color: Colors.white,
                  child: TextField(
                    controller: searchTextController,
                    onChanged: (value) {
                      filterSearchResults(value);
                      // print(value);
                    },
                    // controller: ,
                    decoration: InputDecoration(
                        // labelText: "Search",

                        // hintText: "${query[0]["EngWord"]}",
                        suffixIcon: GestureDetector(
                          child: Icon(Icons.keyboard_voice),
                          onTap: () {
                            if (_hasSpeech == true) {
                              if (speech.isListening == false) {
                                startListening();
                              }
                            } else {
                              utilityBasic.toastfun("need internet");
                            }
                          },
                        ),
                        suffix: GestureDetector(
                          child: Icon(Icons.close),
                          onTap: () {
                            searchTextController.clear();
                            setState(() {
                              items.clear();
                            });
                          },
                        ),
                        prefixIcon: GestureDetector(
                          child: Icon(Icons.arrow_back_ios),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(1.0)))),
                  ),
                ),
              ),*/
              Expanded(
                child: items.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: items
                            .length, // == 0 ? items.length = 0 : items.length,
                        itemBuilder: (context, index) {
                          // recentWords.add(items[index]);

                          return GestureDetector(
                            child: ListTile(
                              title: Text('${items[index]}'),
                            ),
                            onTap: () async {
                              var temp = items[index];
                              print("temp :: " + temp);

                              var no = await db.anyQuery(
                                  'SELECT id from Dic_Unicode where engword = "$temp" or tamilword = "$temp"',
                                  dbName);
                              var no1 = no[0]['id'];

                              //  pageNo = no1 - 1;
                              pageNo = no1;
                              print("$no1");
                              queryfun(pageNo);
                              setState(() {
                                items.clear();
                              });

                              /* print("${items[index]}");
                              print(index);
                              print(engWords[index]);
                              var no = await db.anyQuery(
                                  'SELECT * from Dic_Unicode where engword = "${items[index]}" or tamilword = "${items[index]}"',
                                  dbName);
                              var no1 = no[0]['id'];
                              pageNo = no1 - 1; // + 1;
                              searchTextController.text =
                                  allWords[pageNo]["EngWord"];
                              print('177 ${searchTextController.text}');
*/
                              /* setState(() {
                                items.clear();
                              });*/
                              // searchTextController.text =allWords[cursor]["EngWord"];
                              //condition(allWords[pageNo]["EngWord"]);
                            },
                          );
                        })
                    : Container(
                        child: SingleChildScrollView(

                          child: Column(
                            children: <Widget>[
                              Card(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding:  EdgeInsets.only(top: 5.0,bottom: 10.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      "Search Word :-",
                                                      style: TextStyle(
                                                          color: Colors.redAccent,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20.0),
                                                    ),
                                                    GestureDetector(
                                                      onTap: (){
                                                        Share.share("Word:- $searchword\n Tamil Meaning:- $tamilword");
                                                      },
                                                        child: Icon(Icons.share)),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        "$searchword",
                                                        style: TextStyle(
                                                            fontSize: 15.0,fontWeight: FontWeight.bold),
                                                      ),
                                                      Padding(
                                                        padding:  EdgeInsets.only(top:10.0,bottom: 10.0),
                                                        child: Text(
                                                          "Tamil Meaning :-",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.redAccent,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: 20.0),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                      child: Expanded(
                                                          child: Text(
                                                    "$tamilword",
                                                    style:
                                                        TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),
                                                  ))),
                                                ],
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: secondcard,
                                child: Card(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Visibility(
                                                    visible: grammarcol,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:  EdgeInsets.only(top: 10.0,bottom: 10.0),
                                                              child: Text(
                                                                "Grammar :-",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .lightBlue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: 20.0),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Text(
                                                              "$grammar",
                                                              style: TextStyle(
                                                                  fontSize: 15.0,fontWeight: FontWeight.bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )),
                                                Visibility(
                                                  visible: moremeaingcol,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:  EdgeInsets.only(top:10.0,bottom: 10.0),
                                                            child: Text(
                                                              "More Meanings :-",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .lightBlue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20.0),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Text(
                                                              "$moretamilword",
                                                              style: TextStyle(
                                                                  fontSize: 15.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),



                                              ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
              ),
              Container(
                color: Colors.blue,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          print("before $pageNo");
                          if (pageNo != 1) {
                            pageNo = pageNo - 1;
                          } else {
                            pageNo = 82127;
                          }
                          queryfun(pageNo);
                          print("after $pageNo");
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.navigate_before,
                              color: Colors.white,
                            ),
                            Text(
                              "Previous",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(new ClipboardData(
                              text:
                              "Word: $searchword\n Tamil Meaning: $tamilword"));

                          utility_basic.toastfun("நகலெடுக்கப்பட்டது");
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.content_copy,
                              color: Colors.white,
                            ),
                            Text(
                              "Copy",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _speak();
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.volume_down,
                              color: Colors.white,
                            ),
                            Text(
                              "Pronounce",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("before $pageNo");
                          if (pageNo != 82127) {
                            pageNo = pageNo + 1;
                          } else {
                            pageNo = 1;
                          }
                          queryfun(pageNo);
                          print("after $pageNo");
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.navigate_next,
                              color: Colors.white,
                            ),
                            Text(
                              "Next",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
/*
                       RaisedButton(
                        onPressed: () {
                          print("before $pageNo");
                          if (pageNo != 1) {
                            pageNo = pageNo - 1;
                          } else {
                            pageNo = 82127;
                          }
                          queryfun(pageNo);
                          print("after $pageNo");
                        },
                        child: Text("Prev"),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        child: Text("Copy"),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        child: Text("Sound"),
                      ),
                      RaisedButton(
                        onPressed: () {
                          print("before $pageNo");
                          if (pageNo != 82127) {
                            pageNo = pageNo + 1;
                          } else {
                            pageNo = 1;
                          }
                          queryfun(pageNo);
                          print("after $pageNo");
                        },
                        child: Text("Next"),
                      ),
*/
                    ],
                  ),
                ),
              )
            ]),
          )),
        ));
  }
}

class Bloc {
  BehaviorSubject<String> _tamilmeaning, _grammar, _moremeaning;

  Bloc() {
    _tamilmeaning = new BehaviorSubject();
    _grammar = new BehaviorSubject();
    _moremeaning = new BehaviorSubject();
  }

  Observable<String> get notify_tamilmeaning => _tamilmeaning.stream;

  Observable<String> get notify_grammar => _grammar.stream;

  Observable<String> get notify_moremeaning => _moremeaning.stream;

  void set_tamilmeaning(data) {
    _tamilmeaning.sink.add(data);
  }

  void set_grammar(data) {
    _grammar.sink.add(data);
  }

  void set_moremeaning(data) {
    _moremeaning.sink.add(data);
  }
}
