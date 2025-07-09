import 'dart:async';
import 'dart:convert';
import 'package:dictionary/otherApps/baamini2unicode.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:share/share.dart';

var WordOfTheDayCompl;
// var quoteOfTheDayCompl;
var articleOfTheDayCompl;
var historyOfTheDayCompl;
var birthOfTheDayCompl;

String convertedStr = '';

final CREATE_Today_URL = 'https://www.nithra.mobi/dictionary/getdailyword.php';
final todayArticleURL = 'https://www.nithra.mobi/dictionary/getdayarticle.php';
final todayQuoteURL = 'https://www.nithra.mobi/dictionary/getdayquote.php';
final todayHistoryURL = 'https://www.nithra.mobi/dictionary/getdayhistory.php';
final todayBirthdayURL =
    'https://www.nithra.mobi/dictionary/getdaybirthday.php';

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

Future<Today> createToday(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    print(Today.fromJson(json.decode(response.body)));
    return Today.fromJson(json.decode(response.body));
  });
}

class TodayWord extends StatelessWidget {
  final Future<Today> post;

  TodayWord({Key key, this.post}) : super(key: key);

  TextEditingController bodyControler = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TODAY",
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Create Today'),
          ),
          body: new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new Column(
              children: <Widget>[
                /* return new AlertDialog(
                 backgroundColor: Colors.grey,
                  title: Text("Today"),
                  actions: <Widget>[
                    new RaisedButton(
                      onPressed: () async {
                        var now1 = DateTime.now();
                        print(new DateFormat("dd\/MM\/yyyy")
                            .format(now1)); // => 21-04-2020
                        Today newToday = new Today(
                          date: DateFormat("dd\/MM\/yyyy").format(now1),
                        );

                        var response = await http.post(CREATE_Today_URL,
                            body: newToday.toMap());
                        print("rrrr $response ");
                        // Today p = await createToday(CREATE_Today_URL,
                        //     body: newToday.toMap());
                        //  print(p.title);
                        print("rrrr $response ");
                        print("${json.decode(response.body)}");
                        WordOfTheDayCompl = json.decode(response.body);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WordOfTheDay()),
                        );
                      },
                      child: const Text("Today Date"),
                    ),
                    new RaisedButton(
                      onPressed: () async {
                        var now1 = DateTime.now();
                        print(new DateFormat("dd\/MM\/yyyy")
                            .format(now1)); // => 21-04-2020
                        TodayE newToday = new TodayE(
                            date: DateFormat("dd\/MM").format(now1), type: "q");

                        var response = await http.post(todayQuoteURL,
                            body: newToday.toMap());
                        // Today p = await createToday(CREATE_Today_URL,
                        //     body: newToday.toMap());
                        //  print(p.title);
                        print("rrrr $response ");
                        print("${json.decode(response.body)}");
                        quoteOfTheDayCompl = json.decode(response.body);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuoteOfTheDay()),
                        );
                      },
                      child: const Text("Today Date - Quote"),
                    ),
                    new RaisedButton(
                      onPressed: () async {
                        var now1 = DateTime.now();
                        print(new DateFormat("dd\/MM\/yyyy")
                            .format(now1)); // => 21-04-2020
                        TodayE newToday = new TodayE(
                            date: DateFormat("dd\/MM").format(now1), type: "a");

                        var response = await http.post(todayArticleURL,
                            body: newToday.toMap());
                        // Today p = await createToday(CREATE_Today_URL,
                        //     body: newToday.toMap());
                        //  print(p.title);
                        print("rrrr $response ");
                        print("${json.decode(response.body)}");
                        articleOfTheDayCompl = json.decode(response.body);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ArticleOfTheDay()),
                        );
                      },
                      child: const Text("Today Date - Article"),
                    ),
                    new RaisedButton(
                      onPressed: () async {
                        var now1 = DateTime.now();
                        print(new DateFormat("dd\/MM\/yyyy")
                            .format(now1)); // => 21-04-2020
                        TodayE newToday = new TodayE(
                            date: DateFormat("dd\/MM").format(now1), type: "h");

                        var response = await http.post(todayHistoryURL,
                            body: newToday.toMap());
                        // Today p = await createToday(CREATE_Today_URL,
                        //     body: newToday.toMap());
                        //  print(p.title);
                        print("rrrr $response ");
                        print("${json.decode(response.body)}");
                        historyOfTheDayCompl = json.decode(response.body);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistoryOfTheDay()),
                        );
                      },
                      child: const Text("Today Date - History"),
                    ),
                    new RaisedButton(
                      onPressed: () async {
                        var now1 = DateTime.now();
                        print(new DateFormat("dd\/MM\/yyyy")
                            .format(now1)); // => 21-04-2020
                        TodayE newToday = new TodayE(
                            date: DateFormat("dd\/MM").format(now1), type: "h");

                        var response = await http.post(todayBirthdayURL,
                            body: newToday.toMap());
                        // Today p = await createToday(CREATE_Today_URL,
                        //     body: newToday.toMap());
                        //  print(p.title);
                        print("rrrr $response ");
                        print("${json.decode(response.body)}");
                        birthOfTheDayCompl = json.decode(response.body);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BirthOfTheDay()),
                        );
                      },
                      child: const Text("Today Date - BirthDay"),
                    ),
                  ],
                ); */

                new RaisedButton(
                  onPressed: () async {
                    var now1 = DateTime.now();
                    print(new DateFormat("dd\/MM\/yyyy")
                        .format(now1)); // => 21-04-2020
                    Today newToday = new Today(
                      date: DateFormat("dd\/MM\/yyyy").format(now1),
                    );

                    var response = await http.post(CREATE_Today_URL,
                        body: newToday.toMap());
                    print("rrrr $response ");
                    // Today p = await createToday(CREATE_Today_URL,
                    //     body: newToday.toMap());
                    //  print(p.title);
                    print("rrrr $response ");
                    print("${json.decode(response.body)}");
                    WordOfTheDayCompl = json.decode(response.body);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WordOfTheDay()),
                    );
                  },
                  child: const Text("Today Date"),
                ),
                new RaisedButton(
                  onPressed: () async {
                    var now1 = DateTime.now();
                    print(new DateFormat("dd\/MM\/yyyy")
                        .format(now1)); // => 21-04-2020
                    TodayE newToday = new TodayE(
                        date: DateFormat("dd\/MM").format(now1), type: "q");

                    var response =
                        await http.post(todayQuoteURL, body: newToday.toMap());
                    // Today p = await createToday(CREATE_Today_URL,
                    //     body: newToday.toMap());
                    //  print(p.title);
                    print("rrrr $response ");
                    print("${json.decode(response.body)}");
                    quoteOfTheDayCompl = json.decode(response.body);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuoteOfTheDay()),
                    );
                  },
                  child: const Text("Today Date - Quote"),
                ),
                new RaisedButton(
                  onPressed: () async {
                    var now1 = DateTime.now();
                    print(new DateFormat("dd\/MM\/yyyy")
                        .format(now1)); // => 21-04-2020
                    TodayE newToday = new TodayE(
                        date: DateFormat("dd\/MM").format(now1), type: "a");

                    var response = await http.post(todayArticleURL,
                        body: newToday.toMap());
                    // Today p = await createToday(CREATE_Today_URL,
                    //     body: newToday.toMap());
                    //  print(p.title);
                    print("rrrr $response ");
                    print("${json.decode(response.body)}");
                    articleOfTheDayCompl = json.decode(response.body);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ArticleOfTheDay()),
                    );
                  },
                  child: const Text("Today Date - Article"),
                ),
                new RaisedButton(
                  onPressed: () async {
                    var now1 = DateTime.now();
                    print(new DateFormat("dd\/MM\/yyyy")
                        .format(now1)); // => 21-04-2020
                    TodayE newToday = new TodayE(
                        date: DateFormat("dd\/MM").format(now1), type: "h");

                    var response = await http.post(todayHistoryURL,
                        body: newToday.toMap());
                    // Today p = await createToday(CREATE_Today_URL,
                    //     body: newToday.toMap());
                    //  print(p.title);
                    print("rrrr $response ");
                    print("${json.decode(response.body)}");
                    historyOfTheDayCompl = json.decode(response.body);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HistoryOfTheDay()),
                    );
                  },
                  child: const Text("Today Date - History"),
                ),
                new RaisedButton(
                  onPressed: () async {
                    var now1 = DateTime.now();
                    print(new DateFormat("dd\/MM\/yyyy")
                        .format(now1)); // => 21-04-2020
                    TodayE newToday = new TodayE(
                        date: DateFormat("dd\/MM").format(now1), type: "h");

                    var response = await http.post(todayBirthdayURL,
                        body: newToday.toMap());
                    // Today p = await createToday(CREATE_Today_URL,
                    //     body: newToday.toMap());
                    //  print(p.title);
                    print("rrrr $response ");
                    print("${json.decode(response.body)}");
                    birthOfTheDayCompl = json.decode(response.body);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BirthOfTheDay()),
                    );
                  },
                  child: const Text("Today Date - BirthDay"),
                ),
              ],
            ),
          )),
    );
  }
}

class WordOfTheDay extends StatefulWidget {
  @override
  WordOfTheDayState createState() => WordOfTheDayState();
}

class WordOfTheDayState extends State<WordOfTheDay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var now1 = DateTime.now();
    String now2 = new DateFormat("dd\/MM\/yyyy").format(now1);

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: ListTile(
            title: Text(
              "Word Of The Day",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            subtitle: Text(
              now2,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                CodetoTamilUtil tu = new CodetoTamilUtil();
                var tamword =
                    tu.convertToBamini(WordOfTheDayCompl[0]['tamword']);
                var tamildef =
                    tu.convertToBamini(WordOfTheDayCompl[0]['tamildef']);
                ;
                var tamilsyn =
                    tu.convertToBamini(WordOfTheDayCompl[0]['tamilsyn']);
                ;
                var tamilant =
                    tu.convertToBamini(WordOfTheDayCompl[0]['tamilant']);
                ;
                var tamilsen =
                    tu.convertToBamini(WordOfTheDayCompl[0]['tamilsen']);
                ;
                var tamilgra =
                    tu.convertToBamini(WordOfTheDayCompl[0]['tamilgra']);
                ;

                var a =
                    "நித்ரா ஆங்கிலம் - தமிழ் அகராதி வழியாக பகிரப்பட்டது. இலவசமாக செயலியை தரவிறக்கம் செய்ய இங்கே கிளிக் செய்யுங்கள் :- http://bit.ly/2kE4soU";
                var b = "\n\nWord of The Day : $now2";
                var c =
                    "\n\nWord:-\n${WordOfTheDayCompl[0]['engword']}\n$tamword";
                var d =
                    "\n\nDefinition:-\n${WordOfTheDayCompl[0]['engdef']}\n$tamildef";
                var e =
                    "\n\nSynonyms\n${WordOfTheDayCompl[0]['engsyn']}\n$tamilsyn";
                var f =
                    "\n\nAntonyms\n${WordOfTheDayCompl[0]['engant']}\n$tamilant";
                var g =
                    "\n\nSentence\n${WordOfTheDayCompl[0]['engsentence']}\n$tamilsen";
                var h =
                    "\n\nGrammar\n${WordOfTheDayCompl[0]['enggra']}\n$tamilgra";
                var j =
                    "\n\nஇதுபோன்று தினம் ஒரு வார்த்தையின் முழு விவரங்களையும் அறிந்து கொள்ள நித்ரா ஆங்கிலம் - தமிழ் அகராதியை தரவிறக்கம் செய்திடுங்கள்:-\n http://bit.ly/2kE4soU";

                Share.share("$a$b$c$d$e$f$g$h$j");
              },
            )
          ],
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
          child: new ListView.builder(
            itemCount: WordOfTheDayCompl.length,
            itemBuilder: (context, i) {
              return new ListTile(
                title: Column(
                  children: <Widget>[
                    Card(
                        child: Container(
                      width: double.infinity,
                      padding: new EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            child: Text(
                              "Word :-\n",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Align(
                            child: Text(
                              "${WordOfTheDayCompl[i]['engword']}\n",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          Align(
                            child: Text(
                              "${WordOfTheDayCompl[i]['tamword']}\n",
                              textAlign: TextAlign.left,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  fontSize: 18,
                                  fontFamily: 'Baamini'),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                        ],
                      ),
                    )),
                    Card(
                        child: Container(
                      width: double.infinity,
                      padding: new EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Align(
                            child: Text(
                              "Defenitions :-\n",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Align(
                            child: Text(
                              "${WordOfTheDayCompl[i]['engdef']}\n",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          Align(
                            child: Text(
                              "${WordOfTheDayCompl[i]['tamildef']}\n",
                              style: new TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'Baamini'),
                            ),
                            alignment: Alignment.bottomLeft,
                          ),
                        ],
                      ),
                    )),
                    Card(
                        child: Container(
                      width: double.infinity,
                      padding: new EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Align(
                            child: Text(
                              "Synonyms :-\n",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Align(
                            child: Text(
                              "${WordOfTheDayCompl[i]['engsyn']}\n",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          Align(
                            child: Text(
                              "${WordOfTheDayCompl[i]['tamilsyn']}",
                              style: new TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Baamini'),
                            ),
                            alignment: Alignment.bottomLeft,
                          ),
                        ],
                      ),
                    )),
                    Card(
                        child: Container(
                      width: double.infinity,
                      padding: new EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Align(
                            child: Text(
                              "Antonyms :-\n",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Align(
                            child: Text(
                              " ${WordOfTheDayCompl[i]['engant']}\n",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          Align(
                            child: Text(
                              "${WordOfTheDayCompl[i]['tamilant']}",
                              style: new TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'Baamini'),
                            ),
                            alignment: Alignment.bottomLeft,
                          ),
                        ],
                      ),
                    )),
                    Card(
                        child: Container(
                      width: double.infinity,
                      padding: new EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Align(
                            child: Text(
                              "Sentence :-\n",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Align(
                            child: Text(
                              " ${WordOfTheDayCompl[i]['engsentence']}\n",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          Align(
                            child: Text(
                              "${WordOfTheDayCompl[i]['tamilsen']}",
                              style: new TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'Baamini'),
                            ),
                            alignment: Alignment.bottomLeft,
                          ),
                        ],
                      ),
                    )),
                    Card(
                        child: Container(
                      width: double.infinity,
                      padding: new EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Align(
                            child: Text(
                              "Grmammar :-\n",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Align(
                            child: Text(
                              "${WordOfTheDayCompl[i]['enggra']}\n",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          Align(
                            child: Text(
                              "${WordOfTheDayCompl[i]['tamilgra']}",
                              style: new TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'Baamini'),
                            ),
                            alignment: Alignment.bottomLeft,
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              );
            },
          ),
        ));
  }
}

var quoteOfTheDayCompl;

class QuoteOfTheDay extends StatefulWidget {
  @override
  QuoteOfTheDayState createState() => QuoteOfTheDayState();
}

class QuoteOfTheDayState extends State<QuoteOfTheDay> {
  // String queryAthikaram = "SELECT DISTINCT catname from thirukuralnew";

  @override
  void initState() {
    super.initState();
    // athikaramQ();
  }

  @override
  Widget build(BuildContext context) {
    var now1 = DateTime.now();
    String now2 = new DateFormat("dd\/MM\/yyyy").format(now1);

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        // backgroundColor: Colors.grey,
        appBar: AppBar(
          title: ListTile(
            title: Text(
              "Quote Of The Day",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            subtitle: Text(
              now2,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                CodetoTamilUtil tu = new CodetoTamilUtil();

                var tamword =
                    tu.convertToBamini(quoteOfTheDayCompl[0]['tamdes']);

                var a =
                    "நித்ரா ஆங்கிலம் - தமிழ் அகராதி வழியாக பகிரப்பட்டது. இலவசமாக செயலியை தரவிறக்கம் செய்ய இங்கே கிளிக் செய்யுங்கள் :- http://bit.ly/2kE4soU";
                var b = "\n\Quote of The Day : $now2";
                var c = "\n\n${quoteOfTheDayCompl[0]['engdes']}\n$tamword";

                var j =
                    "\n\nஇதுபோன்ற சிறந்த அறிஞர்களின் மேற்கோள்களை அறிந்து கொள்ள  ஆங்கிலம் - தமிழ் அகராதி மென்பொருளை தரவிறக்கம் செய்ய இந்த லிங்கை கிளிக் செய்யவும்:- http://bit.ly/2kE4soU ";

                Share.share("$a$b$c$j");
              },
            )
          ],
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
          child: new ListView.builder(
            itemCount: quoteOfTheDayCompl.length,
            itemBuilder: (context, i) {
              return new Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    side: BorderSide(
                      color: Colors.white70,
                      width: 2.0,
                    ),
                  ),
                  elevation: 10.0,
                  child: Container(
                    width: double.infinity,
                    padding: new EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Align(
                          child: Text(
                            "\n${quoteOfTheDayCompl[i]['engdes']}\n",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Divider(
                            thickness: 1.0,
                            color: Colors.redAccent,
                          ),
                        ),
                        Align(
                          child: Text(
                            "\n${quoteOfTheDayCompl[i]['tamdes']}\n",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'Baamini'),
                          ),
                          alignment: Alignment.bottomLeft,
                        ),
                      ],
                    ),
                  ));

              /* ListTile(
                title: Column(
                  children: <Widget>[
                    Text(
                      quoteOfTheDayCompl[i]['tamdes'],
                      textAlign: TextAlign.left,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'Baamini'),
                    ),
                    Text(
                      quoteOfTheDayCompl[i]['engdes'],
                      textAlign: TextAlign.left,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                
              ); */
            },
          ),
        ));
  }
}

class ArticleOfTheDay extends StatefulWidget {
  @override
  ArticleOfTheDayState createState() => ArticleOfTheDayState();
}

class ArticleOfTheDayState extends State<ArticleOfTheDay> {
  // String queryAthikaram = "SELECT DISTINCT catname from thirukuralnew";

  @override
  void initState() {
    super.initState();
    // athikaramQ();
  }

  @override
  Widget build(BuildContext context) {
    var now1 = DateTime.now();
    String now2 = new DateFormat("dd\/MM\/yyyy").format(now1);

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: ListTile(
            title: Text(
              "Article Of The Day",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            subtitle: Text(
              now2,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                CodetoTamilUtil tu = new CodetoTamilUtil();
                var tamtitle =
                    tu.convertToBamini(articleOfTheDayCompl[0]['tamtitle']);
                var tamdes =
                    tu.convertToBamini(articleOfTheDayCompl[0]['tamdes']);
                var a =
                    "நித்ரா ஆங்கிலம் - தமிழ் அகராதி வழியாக பகிரப்பட்டது. இலவசமாக செயலியை தரவிறக்கம் செய்ய இங்கே கிளிக் செய்யுங்கள் :- http://bit.ly/2kE4soU";
                var b = "\n\Article of The Day : $now2";
                var c =
                    "\n\n${articleOfTheDayCompl[0]['engtitle']}\n\n${articleOfTheDayCompl[0]['engdes']}";
                var d = "\n\n$tamtitle\n\n$tamdes";

                var j =
                    "\n\nஇதுபோன்ற அறிவுமிக்க தகவல்களின் கட்டுரைகளை அறிந்து கொள்ள  ஆங்கிலம் - தமிழ் அகராதி மென்பொருளை தரவிறக்கம் செய்ய இந்த லிங்கை கிளிக் செய்யவும்:- http://bit.ly/2kE4soU ";

                Share.share("$a$b$c$d$j");
              },
            )
          ],
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
          child: new ListView.builder(
            itemCount: articleOfTheDayCompl.length,
            itemBuilder: (context, i) {
              return new Column(children: <Widget>[
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(
                        color: Colors.white70,
                        width: 2.0,
                      ),
                    ),
                    elevation: 10.0,
                    child: Container(
                      width: double.infinity,
                      padding: new EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Align(
                            child: Text(
                              "\n${articleOfTheDayCompl[i]['engtitle']}\n",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent),
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Align(
                            child: Text(
                              "\n${articleOfTheDayCompl[i]['engdes']}\n",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            alignment: Alignment.bottomLeft,
                          ),
                        ],
                      ),
                    )),
                Divider(
                  thickness: 1.0,
                  color: Colors.redAccent,
                ),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(
                        color: Colors.white70,
                        width: 2.0,
                      ),
                    ),
                    elevation: 10.0,
                    child: Container(
                      width: double.infinity,
                      padding: new EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Align(
                            child: Text(
                              "\n${articleOfTheDayCompl[i]['tamtitle']}\n",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.blue,
                                  fontFamily: 'Baamini'),
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Align(
                            child: Text(
                              "\n${articleOfTheDayCompl[i]['tamdes']}\n",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.black87,
                                  fontFamily: 'Baamini'),
                            ),
                            alignment: Alignment.bottomLeft,
                          ),
                        ],
                      ),
                    )),
              ]);
            },
          ),
        ));
  }
}

class HistoryOfTheDay extends StatefulWidget {
  @override
  HistoryOfTheDayState createState() => HistoryOfTheDayState();
}

class HistoryOfTheDayState extends State<HistoryOfTheDay> {
  // String queryAthikaram = "SELECT DISTINCT catname from thirukuralnew";

  @override
  void initState() {
    super.initState();
    // athikaramQ();
  }

  @override
  Widget build(BuildContext context) {
    var now1 = DateTime.now();
    String now2 = new DateFormat("dd\/MM\/yyyy").format(now1);

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: ListTile(
            title: Text(
              "History Of The Day",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            subtitle: Text(
              now2,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                CodetoTamilUtil tu = new CodetoTamilUtil();
                //  historyOfTheDayCompl[i]['tamdes'], historyOfTheDayCompl[i]['engdes']

                var tamdes =
                    tu.convertToBamini(historyOfTheDayCompl[0]['tamdes']);
                var a =
                    "நித்ரா ஆங்கிலம் - தமிழ் அகராதி வழியாக பகிரப்பட்டது. இலவசமாக செயலியை தரவிறக்கம் செய்ய இங்கே கிளிக் செய்யுங்கள் :- http://bit.ly/2kE4soU";
                var b = "\n\n\This day in history:- $now2";
                var c = "\n\n${historyOfTheDayCompl[0]['engdes']}\n\n$tamdes";

                var j =
                    "\n\nஇதுபோன்ற வரலாற்று நிகழ்வுகளை அறிந்து கொள்ள  ஆங்கிலம் - தமிழ் அகராதி மென்பொருளை தரவிறக்கம் செய்ய இந்த லிங்கை கிளிக் செய்யவும்:- http://bit.ly/2kE4soU ";

                Share.share("$a$b$c$j");
              },
            )
          ],
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
          child: new ListView.builder(
            itemCount: historyOfTheDayCompl.length,
            itemBuilder: (context, i) {
              return new Column(children: <Widget>[
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(
                        color: Colors.white70,
                        width: 2.0,
                      ),
                    ),
                    elevation: 10.0,
                    child: Container(
                      width: double.infinity,
                      padding: new EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          /* Align(
                            child: Text(
                                "\n${historyOfTheDayCompl[i]['engtitle']}\n\n"),
                            alignment: Alignment.topLeft,
                          ), */
                          Align(
                            child: Text(
                              "\n${historyOfTheDayCompl[i]['engdes']}\n",
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.red,
                              ),
                            ),
                            alignment: Alignment.center,
                          ),
                        ],
                      ),
                    )),
                Divider(
                  thickness: 1.0,
                  color: Colors.lightBlue,
                ),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(
                        color: Colors.white70,
                        width: 2.0,
                      ),
                    ),
                    elevation: 10.0,
                    child: Container(
                      width: double.infinity,
                      padding: new EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          /* Align(
                            child: Text(
                              "\n${historyOfTheDayCompl[i]['tamtitle']}\n\n",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Baamini'),
                            ),
                            alignment: Alignment.topLeft,
                          ), */
                          Align(
                            child: Text(
                              "\n${historyOfTheDayCompl[i]['tamdes']}\n",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontFamily: 'Baamini'),
                            ),
                            alignment: Alignment.center,
                          ),
                        ],
                      ),
                    )),
              ]);
            },
          ),
        ));
  }
}

class BirthOfTheDay extends StatefulWidget {
  @override
  BirthOfTheDayState createState() => BirthOfTheDayState();
}

class BirthOfTheDayState extends State<BirthOfTheDay> {
  // String queryAthikaram = "SELECT DISTINCT catname from thirukuralnew";

  @override
  void initState() {
    super.initState();
    // athikaramQ();
  }

  @override
  Widget build(BuildContext context) {
    var now1 = DateTime.now();
    String now2 = new DateFormat("dd\/MM\/yyyy").format(now1);

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: ListTile(
            title: Text(
              "Birth Of The Day",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            subtitle: Text(
              now2,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                CodetoTamilUtil tu = new CodetoTamilUtil();
                // birthOfTheDayCompl[i]['engtitle']
                //           birthOfTheDayCompl[i]['engdes']
                //           birthOfTheDayCompl[i]['tamtitle']
                //           birthOfTheDayCompl[i]['tamdes']

                var tamtitle =
                    tu.convertToBamini(birthOfTheDayCompl[0]['tamtitle']);
                var tamdes =
                    tu.convertToBamini(birthOfTheDayCompl[0]['tamdes']);
                var a =
                    "நித்ரா ஆங்கிலம் - தமிழ் அகராதி வழியாக பகிரப்பட்டது. இலவசமாக செயலியை தரவிறக்கம் செய்ய இங்கே கிளிக் செய்யுங்கள் :- http://bit.ly/2kE4soU";
                var b = "\n\n\Today's birthday:- $now2";
                var c =
                    "\n\n${birthOfTheDayCompl[0]['engtitle']}\n\n${birthOfTheDayCompl[0]['engdes']}";
                var d = "\n\n$tamtitle\n\n$tamdes";

                var j =
                    "\n\nஇதுபோன்ற சிறந்த தலைவர்களின் பிறந்த நாட்களை அறிந்து கொள்ள  ஆங்கிலம் - தமிழ் அகராதி மென்பொருளை தரவிறக்கம் செய்ய இந்த லிங்கை கிளிக் செய்யவும்:- http://bit.ly/2kE4soU ";

                Share.share("$a$b$c$d$j");
              },
            )
          ],
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
          child: new ListView.builder(
            itemCount: birthOfTheDayCompl.length,
            itemBuilder: (context, i) {
              return new Column(children: <Widget>[
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(
                        color: Colors.white70,
                        width: 2.0,
                      ),
                    ),
                    elevation: 10.0,
                    child: Container(
                      width: double.infinity,
                      padding: new EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Align(
                            child: Text(
                              "\n${birthOfTheDayCompl[i]['engtitle']}\n",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent),
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Align(
                            child: Text(
                              "\n${birthOfTheDayCompl[i]['engdes']}\n",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            alignment: Alignment.center,
                          ),
                        ],
                      ),
                    )),
                Divider(
                  thickness: 1.0,
                  color: Colors.lightBlue,
                ),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(
                        color: Colors.white70,
                        width: 2.0,
                      ),
                    ),
                    elevation: 10.0,
                    child: Container(
                      width: double.infinity,
                      padding: new EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Align(
                            child: Text(
                              "\n${birthOfTheDayCompl[i]['tamtitle']}\n",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  fontSize: 18.0,
                                  fontFamily: 'Baamini'),
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Align(
                            child: Text(
                              "\n${birthOfTheDayCompl[i]['tamdes']}\n",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.black87,
                                  fontFamily: 'Baamini'),
                            ),
                            alignment: Alignment.center,
                          ),
                        ],
                      ),
                    )),
              ]);

              /* ListTile(
                title: Column(
                  children: <Widget>[
                    Text(
                      birthOfTheDayCompl[i]['engtitle'],
                      textAlign: TextAlign.left,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      birthOfTheDayCompl[i]['engdes'],
                      textAlign: TextAlign.left,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      birthOfTheDayCompl[i]['tamtitle'],
                      textAlign: TextAlign.left,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'Baamini'),
                    ),
                    Text(
                      birthOfTheDayCompl[i]['tamdes'],
                      textAlign: TextAlign.left,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'Baamini'),
                    ),
                  ],
                ),
              ); */
            },
          ),
        ));
  }
}
