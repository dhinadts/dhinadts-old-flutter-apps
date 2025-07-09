import 'package:dictionary/example1.dart';
import 'package:dictionary/grid_data.dart';
import 'package:dictionary/otherApps/AathiSudi/aathisudi1.dart';
import 'package:dictionary/otherApps/IdiomAndPhrase/phrases.dart';
import 'package:dictionary/otherApps/conversations/conversations.dart';
import 'package:dictionary/otherApps/conversations/conversations2.dart';
import 'package:dictionary/otherApps/home_needs.dart';
import 'package:dictionary/otherApps/importantWords/swords.dart';
import 'package:dictionary/otherApps/onlinetest/onlinetest.dart';
import 'package:dictionary/otherApps/today/wordtoday.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'imports.dart';
import 'otherApps/news.dart';
import 'package:dictionary/db/dbhelp.dart';
import 'package:dictionary/db/sharedprefs.dart';
import 'package:dictionary/db/utility_basics.dart';

import 'package:dictionary/otherApps/homophones/homophonesMain.dart';
import 'package:dictionary/otherApps/proverbs/proverbMain.dart';

import 'package:dictionary/otherApps/thirukkural/thirukkural.dart';
import 'package:dictionary/otherApps/wordcategories/wordsbycat.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'ScreenUtil.dart';

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
List<LocaleName> _localeNames = [];
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
    // SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
        title: 'ஆங்கிலம் தமிழ் அகராதி',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'ஆங்கிலம் தமிழ் அகராதி'),
        debugShowCheckedModeBanner: false);
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
    query123();
    wordCatQ();
    allWords = await db.anyQuery(completeDictionary, dbName);
    convCat = await db.anyQuery(convCatList, dbName);

    //  ORDER by engword ASC
    // allWords1 = await db.anyQuery("SELECT * from Dic_Unicode", dbName);
    // athikaram = await db.anyQuery(
    //     "SELECT  DISTINCT catname from thirukuralnew", "dic_new.db");
  }

  wordCatQ() async {
    wordcat = await db.anyQuery("SELECT * from tamilcategory", dbName);
  }

  query123() async {
    // allWords = await db.anyQuery(completeDictionary, dbName);
    for (var i = 0; i < 1 /* allWords.length */; i++) {
      // english.add(allWords[i]["EngWord"]);
      //       tamil.add(allWords[i]["TamilWord"]);
      // engWords.add(allWords[i]["EngWord"]);
      // engWords.add(allWords[i]["TamilWord"]);
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

  void filterSearchResults(String query) {
    // query = query; // .toLowerCase();
    //  List dummySearchList = List();
    //  dummySearchList.addAll(engWords);
    // List dummySearchList = List();
    // dummySearchList.addAll(engWords);
    if (query.isNotEmpty) {
      List dummyListData = List();
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
      });
    }
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

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    return Scaffold(
      drawer: Drawer(
        child: new Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    height: ScreenUtil().setHeight(650),
                    color: Colors.blue,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'images/logo.png',
                          height: ScreenUtil().setHeight(300),
                          width: ScreenUtil().setWidth(300),
                        ),
                        SizedBox(
                          height:
                              10.0 * MediaQuery.of(context).devicePixelRatio,
                        ),
                        Text(
                          "வினாடி வினா",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(50),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5.0 * MediaQuery.of(context).devicePixelRatio,
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        )
                      ],
                    )),
                ListTile(
                  //selected: true,
                  leading: Image.asset(
                    'images/feedback.png',
                    height: ScreenUtil().setHeight(120),
                    width: ScreenUtil().setWidth(120),
                  ),
                  title: Text(
                    'கருத்துக்கள்',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text("Send a feedback to developer"),
                  onTap: () {
                    //selecting(1, context);
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'images/more.png',
                    height: ScreenUtil().setHeight(120),
                    width: ScreenUtil().setWidth(120),
                  ),
                  title: Text(
                    'நித்ரா செயலிகள்',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text("Use our Another All Apps"),
                  onTap: () {
                    // selecting(2, context);
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'images/notification.png',
                    height: ScreenUtil().setHeight(120),
                    width: ScreenUtil().setWidth(120),
                  ),
                  title: Text(
                    'அறிவிப்புகள்',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text("See Notifications"),
                  onTap: () {
                    // selecting(3, context);
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'images/rateus.png',
                    height: ScreenUtil().setHeight(120),
                    width: ScreenUtil().setWidth(120),
                  ),
                  title: Text(
                    'மதிப்பிடுக',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text("Please Rate this App"),
                  onTap: () {
                    // selecting(4, context);
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'images/reports.png',
                    height: ScreenUtil().setHeight(120),
                    width: ScreenUtil().setWidth(120),
                  ),
                  title: Text(
                    'அறிக்கைகள்',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text("See Your Reports"),
                  onTap: () {
                    // selecting(5, context);
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'images/share.png',
                    height: ScreenUtil().setHeight(120),
                    width: ScreenUtil().setWidth(120),
                  ),
                  title: Text(
                    'செயலியை பகிர',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text("Share this App"),
                  onTap: () {
                    // selecting(6, context);
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'images/padlock.png',
                    height: ScreenUtil().setHeight(120),
                    width: ScreenUtil().setWidth(120),
                  ),
                  title: Text(
                    'தனியுரிமைக் கொள்கை',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text("Privacy Policy"),
                  onTap: () {
                    // selecting(7, context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        // leading: ,
        title: ListTile(
          title: Text(widget.title, textAlign: TextAlign.start, softWrap: true),
        ),
        actions: <Widget>[
          Column(children: <Widget>[
            Row(
              children: <Widget>[
                /*  IconButton(
                  icon: Icon(Icons.keyboard),
                  onPressed: null,
                ), */
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: null,
                ),
                /* IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: null,
                ), */
              ],
            ),
          ]),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(1.5),
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
                      child: Icon(Icons.close),
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
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)))),
              ),
            ),
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
                                  'SELECT * from Dic_Unicode where engword = "$temp" or tamilword = "$temp"',
                                  dbName);
                              var no1 = no[0]['id'];

                              pageNo = no1 - 1;
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
                    : GridView.count(
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
                              image: 'images/winner.png',
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
                              image: 'images/winner.png',
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
                              image: 'images/winner.png',
                            ),
                          ),

                          /* Grid_design(
                            title: 'கதைகள் / கட்டுரைகள்',
                            image: 'images/winner.png',
                          ), */
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => News()),
                              );
                            },
                            child: Grid_design(
                              title: 'செய்திகள்',
                              image: 'images/winner.png',
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
                              image: 'images/winner.png',
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
                              image: 'images/winner.png',
                            ),
                          ),

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
                              image: 'images/winner.png',
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
                              image: 'images/winner.png',
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
                              image: 'images/winner.png',
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
                              image: 'images/winner.png',
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
                              image: 'images/winner.png', //
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
                              image: 'images/winner.png',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              return showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      errorDialog);
                            },
                            child: Grid_design(
                              title: 'testDialo',
                              image: 'images/winner.png',
                            ),
                          ),
                        ],
                      )),

            /* RaisedButton(
                child: Text("FavRited"),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return Conversations21();
                  }));
                }),
            RaisedButton(
                child: Text("Today"),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return TodayWord();
                  }));
                }),
            RaisedButton(
                child: Text("Online Test"),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return OnlineTestWord();
                  }));
                }),
            RaisedButton(
                child: Text("Aathisudi Test"),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return Aathisudi1();
                  }));
                }),
            RaisedButton(
              child: Text("Test Dialogue"),
              onPressed: () {},
            ), */
          ],
        ),
      ),
    );
  }

  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0)), //this right here
    child: Padding(
          padding: EdgeInsets.all(15.0),
          child: 
        
    Container(
      height: 300.0,
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded( child: Text("P&I"), ),
          Expanded(child: 
          Row(
            children: <Widget>[
              Container(
                color: Colors.purple,
                child: Column(
                  children: <Widget>[
                    Text("PHRASE"),
                    Padding(
                      padding: EdgeInsets.all(2.0),
                      child: 
                    Image.asset("images/winner.png"), ),
                  ],
                ),
              ),
              Container(
                color: Colors.purple,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("IDIOMS"),
                    Padding(
                      padding: EdgeInsets.all(2.0),
                      child: 
                    Image.asset("images/winner.png"), ),
                  ],
                ),
              )
            ],
          )),

          /* Padding(
          padding:  EdgeInsets.all(15.0),
          child: Text('Cool', style: TextStyle(color: Colors.red),),
        ),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Text('Awesome', style: TextStyle(color: Colors.red),),
        ),
        Padding(padding: EdgeInsets.only(top: 50.0)),
        FlatButton(onPressed: (){
          print("ddd");
        },
            child: Text('Got It!', style: TextStyle(color: Colors.purple, fontSize: 18.0),)) */
        ],
      ),
    )),
  );
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
