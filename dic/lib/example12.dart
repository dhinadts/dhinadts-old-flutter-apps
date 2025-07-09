// tenkurals from adhikaram

import 'package:dictionary/imports.dart';
import 'package:flutter/material.dart';
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

  PageController controller = PageController(
    initialPage: pageNo,
  );

  @override
  void initState() {
    // items.addAll(engWords);
    super.initState();
    query123();
    print("page no $pageNo");
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page;
        print("currntpage::: $currentPageValue , page:::: $pagess");
      });
    });
    searchTextController.text = allWords[pageNo]["EngWord"];
    print('59 ${searchTextController.text}');

    initSpeechState();
  }

  query123() async {
    /* var currentWords = await db.anyQuery('select id from Dic_Unicode where EngWord="${widget.title}"  ', dbName);
    pagess =currentWords[0]['id']; */
    // var index1 = await db.anyQuery("select id from Dic_Unicode ", dbName);

    /*    allWords = await db.anyQuery(completeDictionary, dbName);
    for (var i = 0; i < dictionaryWords.length; i++) {
      engWords.add(allWords[i]["EngWord"]);
    } */

    // allWords = await db.anyQuery("SELECT * from Dic_Unicode", dbName);
  }

  @override
  void dispose() {
    super.dispose();
    items.clear();
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

  void filterSearchResults(String query) {
    // List dummySearchList = List();
    // dummySearchList.addAll(engWords);
    if (query.isNotEmpty) {
      List dummyListData = List();
      // dummySearchList.forEach((item) {
      engWords.forEach((item) {
        if (item.startsWith(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();

        //items.addAll(engWords);
        items.clear();
      });
    }
  }

  Future _speak() async {
    if (searchTextController.text.isNotEmpty) {
      var result = await flutterTts.speak(searchTextController.text);
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

        body: SafeArea(
          child: Container(
              // color: Colors.blue,
              child: Column(children: <Widget>[
            TextField(
              controller: searchTextController,
              onChanged: (value) {
                filterSearchResults(value);
                // print(value);
              },
              // controller: ,
              decoration: InputDecoration(
                  // labelText: "Search",

                  hintText: "${allWords[cursor]["EngWord"]}",
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
                              print("${items[index]}");
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

                              controller = PageController(
                                initialPage: no1 - 1, // + 1,
                                keepPage: true,
                              );

                              setState(() {
                                items.clear();
                              });
                              // searchTextController.text =allWords[cursor]["EngWord"];
                            },
                          );
                        })
                    : PageView.builder(
                        itemCount: allWords.length,
                        controller: controller,
                        physics: new NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          intexvalue = index;

                          return Column(children: <Widget>[
                            Card(

                              child: Row(
                                children: <Widget>[
                                  SingleChildScrollView(
                                      child: Container(
                                    width: 300.0,
                                    height: 300.0,
                                    child: Column(
                                      children: <Widget>[
                                        Card(
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    "Search Word:-",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons.share),
                                                    onPressed: () {
                                                      Share.share(
                                                          "நித்ரா ஆங்கிலம் - தமிழ் அகராதி வழியாக பகிரப்பட்டது. இலவசமாக செயலியை தரவிறக்கம் செய்ய இங்கே கிளிக் செய்யுங்கள் :- \n\n https://goo.gl/2kCLQZ \n\n  Word:  ${allWords[index]["EngWord"]} \n Tamil Meaning:  ${allWords[index]["TamilWord"]}. \n\n இதுபோன்ற 1 இலட்சத்திற்கும் அதிகமான ஆங்கில வார்த்தைகளுக்கு இணையான தமிழ் சொற்கள் (ஆங்கிலம் - தமிழ் - ஆங்கிலம்), சரளமாக ஆங்கிலம் பேச உதவும் அற்புதமான Offline நித்ரா ஆங்கிலம் - தமிழ் அகராதி செயலியை இலவசமாக தரவிறக்கம் செய்ய கீழ்க்கண்ட லிங்கை கிளிக் செய்யுங்கள்:- \n\n https://goo.gl/2kCLQZ");
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "${allWords[index]["EngWord"]}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Divider(
                                                color: Colors.black,
                                              ),
                                              Text(
                                                "Tamil Meaning:-",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${allWords[index]["TamilWord"]}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Card(
                                            child: Container(
                                          width: 300.0,
                                          height: 300.0,
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "Grammar :-",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${allWords[index]["Grammar"]}",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "More Meanings:-",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${allWords[index]["TamilWord_one"]}",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${allWords[index]["TamilWord_two"]}",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        )),
                                      ],
                                    ),
                                  )),
                                  // Container(
                                  //   width: 50,
                                  //   child: Column(
                                  //     children: <Widget>[
                                  //       /* IconButton(
                                  //         icon: fav == true
                                  //             ? Icon(Icons.favorite)
                                  //             : Icon(Icons.favorite_border),
                                  //         onPressed: () async {
                                  //           setState(() {
                                  //             fav = !fav;
                                  //           });
                                  //           if (fav == true) {
                                  //             String query =
                                  //                 'select * from Dic_Unicode where engword = "${allWords[index]["EngWord"]}"';
                                  //             List e = List();
                                  //             e = await db.anyQuery(
                                  //                 query, dbName);
                                  //             favorited.add(e);
                                  //           } else {
                                  //             String query =
                                  //                 'select * from Dic_Unicode where engword = "${allWords[index]["EngWord"]}"';
                                  //             List e = List();
                                  //             e = await db.anyQuery(
                                  //                 query, dbName);
                                  //             favorited.remove(e);
                                  //           }
                                  //           print("\n ${favorited.length}");
                                  //           print("favorited: $favorited)");
                                  //           print("${favorited[0]['EngWord']}");
                                  //         },
                                  //       ), */
                                  //       IconButton(
                                  //         icon: Icon(Icons.share),
                                  //         onPressed: () {
                                  //           Share.share("நித்ரா ஆங்கிலம் - தமிழ் அகராதி வழியாக பகிரப்பட்டது. இலவசமாக செயலியை தரவிறக்கம் செய்ய இங்கே கிளிக் செய்யுங்கள் :- \n\n https://goo.gl/2kCLQZ \n\n  Word:  ${allWords[index]["EngWord"]} \n Tamil Meaning:  ${allWords[index]["TamilWord"]}. \n\n இதுபோன்ற 1 இலட்சத்திற்கும் அதிகமான ஆங்கில வார்த்தைகளுக்கு இணையான தமிழ் சொற்கள் (ஆங்கிலம் - தமிழ் - ஆங்கிலம்), சரளமாக ஆங்கிலம் பேச உதவும் அற்புதமான Offline நித்ரா ஆங்கிலம் - தமிழ் அகராதி செயலியை இலவசமாக தரவிறக்கம் செய்ய கீழ்க்கண்ட லிங்கை கிளிக் செய்யுங்கள்:- \n\n https://goo.gl/2kCLQZ");
                                  //         },
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  RaisedButton(
                                    child: Text("Prev"),
                                    onPressed: () {
                                      controller.jumpToPage(index.floor() - 1);
                                      cursor = controller.page.floor();
                                      // /* controller
                                      //     .jumpToPage(currentPageValue.floor() - 1);

                                      print(currentPageValue);

                                      searchTextController.text =
                                          allWords[cursor]["EngWord"];
                                      print('317 ${searchTextController.text}');
                                    },
                                  ),
                                  RaisedButton(
                                    child: Text("Copy"),
                                    onPressed: null,
                                  ),
                                  RaisedButton(
                                    child: Text("Sound"),
                                    onPressed: () {
                                      _speak();
                                    },
                                  ),
                                  RaisedButton(
                                    child: Text("Next"),
                                    onPressed: () {
                                      // currentPageValue = controller.page.round();
/*                                       controller
                                          .jumpToPage(index.floor() + 1); */
                                      controller.jumpToPage(index.floor() + 1);

                                      cursor = controller.page.floor();
                                      searchTextController.text =
                                          allWords[cursor]["EngWord"];
                                      print('339 ${searchTextController.text}');

                                      print("index::: $index");
                                    },
                                  ),
                                ]),
                          ]);
                        },
                      )),
          ])),
        ));
  }
}
