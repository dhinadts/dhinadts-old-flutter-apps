import 'package:dictionary/db/dbhelp.dart';
import 'package:dictionary/db/sharedprefs.dart';
import 'package:dictionary/db/utility_basics.dart';
import 'package:dictionary/example1.dart';
import 'package:dictionary/grid_data.dart';
import 'package:dictionary/otherApps/AathiSudi/aathisudi1.dart';
import 'package:dictionary/otherApps/IdiomAndPhrase/phrases.dart';
import 'package:dictionary/otherApps/conversations/conversations2.dart';
import 'package:dictionary/otherApps/home_needs.dart';
import 'package:dictionary/otherApps/homophones/homophonesMain.dart';
import 'package:dictionary/otherApps/importantWords/swords.dart';
import 'package:dictionary/otherApps/onlinetest/onlinetest.dart';
import 'package:dictionary/otherApps/proverbs/proverbMain.dart';
import 'package:dictionary/otherApps/thirukkural/thirukkural.dart';
import 'package:dictionary/otherApps/today/wordtoday.dart';
import 'package:dictionary/otherApps/wordcategories/wordsbycat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:http/http.dart' as http;

import 'ScreenUtil.dart';
import 'imports.dart';
import 'otherApps/news.dart';

var db = DatabaseHelper();
String dbName = "dic_new.db";

var prefs = Shared_Preference();
var utilityBasic = Utility_Basic();
var newData1;
var athikaram;
var tenkurals;
var indexKey;
var dictionaryWords1, dictionaryWords2, dictionaryWords;
var specialWords;
var aathisudi;
var homophones;
var proverbCat, proverbByCat;
var wordcat, wordlistbycat, wordsbycat;
var engWords = new List();
var items = new List();
var allWords, allWords1;
var pageNo = 0;
int selected = 0;

var favorited = new List();
var recentWords;

TextEditingController emailController = new TextEditingController();
TextEditingController feedbackController = new TextEditingController();
var searchTextController = new TextEditingController();

String versionName = "";
String versionCode = "";
String device_name = "";
String platformVersion = "";
int back_flag = 0;
String deviceid = "";
String fcm_token = "";
double adscreen = 0.0;

String queryAthikaram = "SELECT DISTINCT catname from thirukuralnew";
String completeDictionary =
    "select * from Dic_Unicode"; //   ORDER by engword ASC";
// String dbName = "dic_new.db";
// String queryAthikaram = "SELECT DISTINCT catname from thirukuralnew";

final SpeechToText speech = SpeechToText();
bool _hasSpeech = false;
bool _stressTest = false;
int _stressLoops = 0;
String lastWords = "";
String lastError = "";
String lastStatus = "";
String currentLocaleId = "";
var voice = TextEditingController();

enum TtsState { playing, stopped }

FlutterTts flutterTts;
TtsState ttsState = TtsState.stopped;

get isPlaying => ttsState == TtsState.playing;

get isStopped => ttsState == TtsState.stopped;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ஆங்கிலம் தமிழ் அகராதி',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'ஆங்கிலம் தமிழ் அகராதி'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() {
    super.dispose();
    items.clear();
  }

  @override
  void initState() {
    items.clear();
    super.initState();
    forDB();
    initSpeechState();
    initTts();
  }

  forDB() async {
    await utilityBasic.versions();
    await utilityBasic.device_info();
    await utilityBasic.deviceID();

    print("device id::: $deviceid");

    int vcode = int.parse('$versionCode');
    print("spp  $versionCode");

    if (await prefs.getInt("dbMove") > vcode ||
        await prefs.getInt("dbMove") == 0) {
      await db.dbMove();
      await prefs.setint("dbMove", vcode);
      // await answercopy();

      db.createDB("noti");
      db.createTable(
          "notification",
          "id INTEGER PRIMARY KEY AUTOINCREMENT, title String, datas String, read int, date String,time String",
          "noti");
    }
    // allQueries();
    //query123();
    //allWords = await db.anyQuery(completeDictionary, dbName);
    //  ORDER by engword ASC
    // allWords1 = await db.anyQuery("SELECT * from Dic_Unicode", dbName);
    // athikaram = await db.anyQuery(
    //     "SELECT  DISTINCT catname from thirukuralnew", "dic_new.db");
  }

  query123() async {
    allWords = await db.anyQuery(completeDictionary, dbName);
    for (var i = 0; i < allWords.length; i++) {
      // english.add(allWords[i]["EngWord"]);
      //       tamil.add(allWords[i]["TamilWord"]);
      engWords.add(allWords[i]["EngWord"]);
      engWords.add(allWords[i]["TamilWord"]);
    }
  }

  initTts() {
    flutterTts = FlutterTts();

    // _getLanguages();

    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
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

  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener);
    print("hasspeech  $hasSpeech");
    if (hasSpeech) {
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

  void stopListening() {
    utility_basic.toastfun("Time Elapsed");
    speech.stop();
    setState(() {});
  }

  void cancelListening() {
    speech.cancel();
    setState(() {});
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = "${result.recognizedWords}";
      voice.text = lastWords;
      filterSearchResults(voice.text);
    });
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

  List<Widget> _buildMenuActions() {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Icon(Icons.notifications),
      ),
    ];
  }

  ScrollController _scrollViewController;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      drawer: Drawer(
        child: new Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    height: ScreenUtil().setHeight(610),
                    color: Colors.redAccent,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/dic/header_img.webp',
                          //height: ScreenUtil().setHeight(500),
                          //width: ScreenUtil().setWidth(500),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "V Code : $versionCode",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(40),
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              "V Name : $versionName",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(40),
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ],
                    )),
                ListTile(
                  //selected: true,
                  leading: Image.asset(
                    'assets/dic/dic_home.webp',
                    height: ScreenUtil().setHeight(80),
                    width: ScreenUtil().setWidth(80),
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    //selecting(1, context);
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/dic/iconbell.webp',
                    height: ScreenUtil().setHeight(80),
                    width: ScreenUtil().setWidth(80),
                  ),
                  title: Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    // selecting(3, context);
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/dic/padlock.png',
                    height: ScreenUtil().setHeight(80),
                    width: ScreenUtil().setWidth(80),
                  ),
                  title: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    // selecting(7, context);
                  },
                ),
                Divider(
                  color: Colors.grey,
                ),
                Text("Online"),
                ListTile(
                  leading: Image.asset(
                    'assets/dic/dic_rate.webp',
                    height: ScreenUtil().setHeight(80),
                    width: ScreenUtil().setWidth(80),
                  ),
                  title: Text(
                    'Vocabulory Online Test',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    // selecting(4, context);
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/dic/line_word.webp',
                    height: ScreenUtil().setHeight(80),
                    width: ScreenUtil().setWidth(80),
                  ),
                  title: Text(
                    'Word of the Day',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    // selecting(4, context);
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/dic/line_artical.webp',
                    height: ScreenUtil().setHeight(80),
                    width: ScreenUtil().setWidth(80),
                  ),
                  title: Text(
                    'Article of the Day',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    // selecting(4, context);
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/dic/line_quotes.webp',
                    height: ScreenUtil().setHeight(80),
                    width: ScreenUtil().setWidth(80),
                  ),
                  title: Text(
                    'Quotes of the Day',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    // selecting(4, context);
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/dic/line_history.webp',
                    height: ScreenUtil().setHeight(80),
                    width: ScreenUtil().setWidth(80),
                  ),
                  title: Text(
                    'This Day in History',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    // selecting(5, context);
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/dic/line_birthday.webp',
                    height: ScreenUtil().setHeight(80),
                    width: ScreenUtil().setWidth(80),
                  ),
                  title: Text(
                    'Today Birth',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    // selecting(6, context);
                  },
                ),
                Divider(
                  color: Colors.grey,
                ),
                Text("Others"),
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text(
                    'Share this App',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),

                  onTap: () {
                    // selecting(7, context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.rate_review),
                  title: Text(
                    'Rate us',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    // selecting(7, context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.feedback),
                  title: Text(
                    'Feedback',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    // selecting(7, context);
                  },
                ),
                ListTile(
                  leading:Icon(Icons.flag),
                  title: Text(
                    'Like our Facebook Page',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    // selecting(7, context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: new NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              ),
              centerTitle: false,
              title: Text(
                widget.title,
                textAlign: TextAlign.start,
                softWrap: true,
                style: TextStyle(fontSize: 15.0),
              ),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: PreferredSize(
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 5.0, left: 30.0, right: 30.0),
                  child: Container(
                    height: 40.0, //40
                    //color: Colors.white,
                    decoration: new BoxDecoration(
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(17.0)),
                        color: Colors.white),
                    //padding: new EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                    child: TextField(
                      controller: new TextEditingController.fromValue(
                          new TextEditingValue(
                              text: voice.text,
                              selection: new TextSelection.collapsed(
                                  offset: voice.text.length))),
                      onChanged: (value) {
                        voice.text = value;
                        voice.selection = TextSelection.fromPosition(
                            TextPosition(offset: voice.text.length));
                        filterSearchResults(value);

                        print('${voice.text}');
                        print(value);
                      },
                      decoration: InputDecoration(
                          // labelText: "Search",
                          hintText: "Search",
                          suffix: GestureDetector(
                            child: Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Icon(Icons.close),
                            ),
                            onTap: () {
                              voice.clear();

                              setState(() {
                                items.clear();
                              });
                            },
                          ),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                if (_hasSpeech == true) {
                                  if (speech.isListening == false) {
                                    startListening();
                                  }
                                } else {
                                  utilityBasic.toastfun("need internet");
                                }
                              },
                              child: Icon(Icons.keyboard_voice)),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Image.asset(
                              "assets/dic/dic_search.webp",
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(17.0)))),
                    ),
                  ),
                ),
                preferredSize: Size.fromHeight(50.0), //50
              ),
              actions: _buildMenuActions(),
              /* actions: <Widget>[
                Column(children: <Widget>[
                  Row(
                    children: <Widget>[

                      IconButton(
                        icon: Icon(Icons.notifications,color: Colors.white,),
                        onPressed: null,
                      ),

                    ],
                  ),
                ]),
              ],*/
            ),
          ];
        },
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: items.length != 0
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            // recentWords.add(items[index]);
                            return GestureDetector(
                              child: ListTile(
                                title: Text('${items[index]}'),
                              ),
                              onTap: () async {
                                var temp = items[index];
                                // items.clear();
                                // voice.clear();
                                print("temp :: " + temp);

                                var no = await db.anyQuery(
                                    'SELECT id from Dic_Unicode where engword = "$temp" or tamilword = "$temp"',
                                    dbName);
                                var no1 = no[0]['id'];

                                //  pageNo = no1 - 1;
                                pageNo = no1;
                                print(
                                    "no1 -1 : $no1,, engword: ${no[0]['EngWord']}");

                                items.clear();

                                voice.clear();

                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WordSearchRes1(
                                          id: no1 - 1, title: '$temp')),
                                );

                                /* Navigator.of(context).push(
                                  MaterialPageRoute<Null>(
                                      builder: (BuildContext context) {
                                return WordSearchRes1(
                                    id: no1 - 1, title: '${no[0]['EngWord']}');
                              })); */
                              },
                            );
                          })
                      : Container(
                          color: Color(0xffF9F9F9),
                          child: GridView.count(
                            crossAxisCount: 3,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                 showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Phrase & Idioms"),
                                      // contentPadding: ,
                                      content: new Row(
                                        children: <Widget>[
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              GestureDetector(
                                                child: Text(
                                                  "Phrase",
                                                  style: TextStyle(
                                                      backgroundColor:
                                                          Colors.blueAccent),
                                                ),
                                                onTap: () async {
                                                  Navigator.pop(context);

                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Phrases()),
                                                  );
                                                },
                                              ),
                                              /* Text("", ),
                                              RaisedButton(
                                                child: Text("Phrase"),
                                                onPressed: () async {
                                                  Navigator.pop(context);

                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Phrases()),
                                                  );
                                                },
                                              ), */
                                              Text(""),
                                              Text(""),
                                              Text(""),
                                              RaisedButton(
                                                child: Text("Idioms"),
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Idioms()),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      /* actions: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ], */
                                    );
                                  });
                                },
                                child: Grid_design(
                                  title: 'Phrases and Idioms',
                                  image: 'assets/dic/dic_pharse.webp',
                                ),
                              ),
                              GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Conversations21()),
                              );
                            },
                            child: Grid_design(
                              title: 'Conversations உரையாடல்கள்',
                              image: 'assets/dic/dic_conver.webp',
                            ),
                          ),
                             GestureDetector(
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Align(
                                        child: Text("Today"),
                                        alignment: Alignment.center,
                                      ),
                                      content: new Container(
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                RaisedButton(
                                                  child:
                                                      Text("Word Of The Day"),
                                                  onPressed: () async {
                                                    var now1 = DateTime.now();
                                                    print(new DateFormat(
                                                            "dd\/MM\/yyyy")
                                                        .format(
                                                            now1)); // => 21-04-2019
                                                    Today newToday = new Today(
                                                      date: DateFormat(
                                                              "dd\/MM\/yyyy")
                                                          .format(now1),
                                                    );

                                                    var response = await http
                                                        .post(CREATE_Today_URL,
                                                            body: newToday
                                                                .toMap());
                                                    print("rrrr $response ");
                                                    // Today p = await createToday(CREATE_Today_URL,
                                                    //     body: newToday.toMap());
                                                    //  print(p.title);
                                                    print("rrrr $response ");
                                                    print(
                                                        "${json.decode(response.body)}");
                                                    WordOfTheDayCompl = json
                                                        .decode(response.body);
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              WordOfTheDay()),
                                                    );
                                                  },
                                                ),
                                                RaisedButton(
                                                  child:
                                                      Text("Quote Of The Day"),
                                                  onPressed: () async {
                                                    var now1 = DateTime.now();
                                                    print(new DateFormat(
                                                            "dd\/MM\/yyyy")
                                                        .format(
                                                            now1)); // => 21-04-2019
                                                    TodayE newToday =
                                                        new TodayE(
                                                            date: DateFormat(
                                                                    "dd\/MM")
                                                                .format(now1),
                                                            type: "q");

                                                    var response = await http
                                                        .post(todayQuoteURL,
                                                            body: newToday
                                                                .toMap());
                                                    // Today p = await createToday(CREATE_Today_URL,
                                                    //     body: newToday.toMap());
                                                    //  print(p.title);
                                                    print("rrrr $response ");
                                                    print(
                                                        "${json.decode(response.body)}");
                                                    quoteOfTheDayCompl = json
                                                        .decode(response.body);
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              QuoteOfTheDay()),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                RaisedButton(
                                                  child: Text(
                                                      "Article Of The Day"),
                                                  onPressed: () async {
                                                    var now1 = DateTime.now();
                                                    print(new DateFormat(
                                                            "dd\/MM\/yyyy")
                                                        .format(
                                                            now1)); // => 21-04-2019
                                                    TodayE newToday =
                                                        new TodayE(
                                                            date: DateFormat(
                                                                    "dd\/MM")
                                                                .format(now1),
                                                            type: "a");

                                                    var response = await http
                                                        .post(todayArticleURL,
                                                            body: newToday
                                                                .toMap());
                                                    // Today p = await createToday(CREATE_Today_URL,
                                                    //     body: newToday.toMap());
                                                    //  print(p.title);
                                                    print("rrrr $response ");
                                                    print(
                                                        "${json.decode(response.body)}");
                                                    articleOfTheDayCompl = json
                                                        .decode(response.body);
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ArticleOfTheDay()),
                                                    );
                                                  },
                                                ),
                                                RaisedButton(
                                                  child: Text(
                                                      "History Of The Day"),
                                                  onPressed: () async {
                                                    var now1 = DateTime.now();
                                                    print(new DateFormat(
                                                            "dd\/MM\/yyyy")
                                                        .format(
                                                            now1)); // => 21-04-2019
                                                    TodayE newToday =
                                                        new TodayE(
                                                            date: DateFormat(
                                                                    "dd\/MM")
                                                                .format(now1),
                                                            type: "h");

                                                    var response = await http
                                                        .post(todayHistoryURL,
                                                            body: newToday
                                                                .toMap());
                                                    // Today p = await createToday(CREATE_Today_URL,
                                                    //     body: newToday.toMap());
                                                    //  print(p.title);
                                                    print("rrrr $response ");
                                                    print(
                                                        "${json.decode(response.body)}");
                                                    historyOfTheDayCompl = json
                                                        .decode(response.body);
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HistoryOfTheDay()),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            Align(
                                              child: RaisedButton(
                                                child: Text("Birth Of The Day"),
                                                onPressed: () async {
                                                  var now1 = DateTime.now();
                                                  print(new DateFormat(
                                                          "dd\/MM\/yyyy")
                                                      .format(
                                                          now1)); // => 21-04-2019
                                                  TodayE newToday = new TodayE(
                                                      date: DateFormat("dd\/MM")
                                                          .format(now1),
                                                      type: "h");

                                                  var response = await http
                                                      .post(todayBirthdayURL,
                                                          body:
                                                              newToday.toMap());
                                                  // Today p = await createToday(CREATE_Today_URL,
                                                  //     body: newToday.toMap());
                                                  //  print(p.title);
                                                  print("rrrr $response ");
                                                  print(
                                                      "${json.decode(response.body)}");
                                                  birthOfTheDayCompl = json
                                                      .decode(response.body);
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BirthOfTheDay()),
                                                  );
                                                },
                                              ),
                                              alignment: Alignment.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });

                              // Navigator.of(context).push(
                              //     MaterialPageRoute<Null>(builder: (BuildContext context) {
                              //   return TodayWord();
                              // }));
                            },
                            child: Grid_design(
                              title: 'இன்று',
                              image: 'assets/dic/dic_today.webp',
                            ),
                          ),
                              

                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => News()),
                                  );
                                },
                                child: Grid_design(
                                  title: 'செய்திகள்',
                                  image: 'assets/dic/dic_news.webp',
                                ),
                              ),
GestureDetector(
                            onTap: () async {
                              var now1 = DateTime.now();
                              print(new DateFormat("dd\/MM\/yyyy")
                                  .format(now1)); // => 21-04-2019
                              OnlineTest newOnlineTest = new OnlineTest(
                                type: 'VOT',
                              );

                              var response = await http.post(onlineTestURL,
                                  body: newOnlineTest.toMap());

                              // OnlineTest p = await createOnlineTest(CREATE_OnlineTest_URL,
                              //     body: newOnlineTest.toMap());
                              //  print(p.title);
                              print("rrrr $response ");
                              print("${json.decode(response.body)}");
                              test1 = json.decode(response.body);
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TestsPage()),
                              );
                              /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OnlineTestWord()),
                              ); */
                            },
                            child: Grid_design(
                              title: 'Online Test',
                              image: 'assets/dic/dic_online.webp',
                            ),
                          ),

                              

                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ImpWords()),
                                  );
                                },
                                child: Grid_design(
                                  title: 'Important Words',
                                  image: 'assets/dic/dic_imp.webp',
                                ),
                              ),

                              // ImpWords
                              // AathiSudi

GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Aathisudi1()),
                              );
                            },
                            child: Grid_design(
                              title: 'ஆத்திச்சூடி',
                              image: 'assets/dic/dic_aathisoodi.webp',
                            ),
                          ),

                              

                              // Proverb
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Proverbs()),
                                  );
                                },
                                child: Grid_design(
                                  title: 'பழமொழிகள்',
                                  image: 'assets/dic/dic_proverb.webp',
                                ),
                              ),

                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeNeeds()),
                                  );
                                },
                                child: Grid_design(
                                  title: 'Home Needs',
                                  image: 'assets/dic/dic_home.webp',
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Thirukkural()),
                                  );
                                },
                                child: Grid_design(
                                  title: 'திருக்குறள்',
                                  image: 'assets/dic/dic_thirukural.webp',
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WordCategory()),
                                  );
                                },
                                child: Grid_design(
                                  title: 'Word Categories',
                                  image: 'assets/dic/dic_word.webp', //
                                ),
                              ),

                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomoPhones()),
                                  );
                                },
                                child: Grid_design(
                                  title: 'Homophones',
                                  image: 'assets/dic/dic_homophone.webp',
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomoPhones()),
                                  );
                                },
                                child: Grid_design(
                                  title: 'மதிப்பிடுக',
                                  image: 'assets/dic/dic_rate.webp',
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomoPhones()),
                                  );
                                },
                                child: Grid_design(
                                  title: 'கருத்து பதிவு செய்ய',
                                  image: 'assets/dic/dic_feed.webp',
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomoPhones()),
                                  );
                                },
                                child: Grid_design(
                                  title: 'பகிர',
                                  image: 'assets/dic/dic_share.webp',
                                ),
                              ),
                            ],
                          ),
                        )),
            ],
          ),
        ),
      ),

      /*appBar: AppBar(
        // leading: ,
        title: Text(widget.title, textAlign: TextAlign.start, softWrap: true,style: TextStyle(fontSize: 15.0),),
        bottom: PreferredSize(
          child: Padding(
            padding: EdgeInsets.only(bottom: 10.0,left: 30.0,right: 30.0),
            child: Container(
              height: 40.0,
              //color: Colors.white,
              decoration: new BoxDecoration (
                  borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                  color: Colors.white
              ),
              //padding: new EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              child: TextField(


                controller: new TextEditingController.fromValue(
                    new TextEditingValue(
                        text: voice.text,
                        selection: new TextSelection.collapsed(
                            offset: voice.text.length))),
                onChanged: (value) {
                  voice.text = value;
                  voice.selection = TextSelection.fromPosition(
                      TextPosition(offset: voice.text.length));
                  filterSearchResults(value);

                  print('${voice.text}');
                  print(value);
                },
                decoration: InputDecoration(
                    // labelText: "Search",
                    hintText: "Search",

                    suffix: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(top:10.0),
                        child: Icon(Icons.close),
                      ),
                      onTap: () {
                        voice.clear();

                        setState(() {
                          items.clear();
                        });
                      },
                    ),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          if (_hasSpeech == true) {
                            if (speech.isListening == false) {
                              startListening();
                            }
                          } else {
                            utilityBasic.toastfun("need internet");
                          }
                        },
                        child: Icon(Icons.keyboard_voice)),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Image.asset("assets/dic/dic_search.webp",),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)))),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(60.0),
        ),
        actions: <Widget>[
          Column(children: <Widget>[
            Row(
              children: <Widget>[

                IconButton(
                  icon: Icon(Icons.notifications,color: Colors.white,),
                  onPressed: null,
                ),

              ],
            ),
          ]),
        ],
      ),*/
    );
  }
}





class Today {
  final date;

  Today({
    this.date,
  });

  factory Today.fromJson(Map<String, dynamic> json) {
    return Today(
      date: json['date'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["date"] = date;
    return map;
  }
}

class TodayE {
  final date;
  final String type;

  TodayE({this.date, this.type});

  factory TodayE.fromJson(Map<String, dynamic> json) {
    return TodayE(
      date: json['date'],
      type: json['type'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["date"] = date;
    map["type"] = type;
    return map;
  }
}

class OnlineTest {
  final String type;

  OnlineTest({
    this.type,
  });

  factory OnlineTest.fromJson(Map<String, dynamic> json) {
    return OnlineTest(
      type: json['type'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["type"] = type;
    return map;
  }
}
