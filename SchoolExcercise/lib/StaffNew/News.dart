import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:school/main.dart';

class News extends StatefulWidget {
  News({Key key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  var news = new List();
  var searchedItems = new List();
  TextEditingController searchNews = new TextEditingController();
  @override
  void initState() {
    super.initState();
    newsAPI();
  }

  newsAPI() async {
    var url = "http://13.127.33.107/upload/dhanraj/homework/api/android.php";

    Dio dio = new Dio();
    Response response;

    FormData formData = new FormData.fromMap({
      "action": "get_news",
      "schoolid": schoolID.toString(),
      "acyid": academicYear.toString(),
    });

    response = await dio.post(url, data: formData);
    print('Response body: ${response.data}');
    news = json.decode(response.data);
    print(news);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News")),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          TextField(
              controller: searchNews,
              decoration:
                  InputDecoration(hintText: "Search", labelText: "Search News"),
              onChanged: (value) {
                for (var i = 0; i < news.length; i++) {
                  if (news[i]["title"].contains(value) ||
                      news[i]["description"].contains(value) ||
                      news[i]["addby"].contains(value)) {
                    searchedItems.addAll(news[i]);
                  }
                }
              }),
          searchedItems == null
              ? SizedBox()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchedItems.length,
                  itemBuilder: (context, i) {
                    return Expanded(
                        child: Card(
                      child: Column(
                        children: <Widget>[
                          Text("${searchedItems[i]["title"]}",
                              textAlign: TextAlign.left),
                          Text("${searchedItems[i]["description"]}"),
                          Text("${searchedItems[i]["addby"]}"),
                          Text("${searchedItems[i]["files"]}")
                        ],
                      ),
                    )

                        /* description, files, addby, */
                        );
                  }),
          news == null
              ? Center(child: Text("No news"))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: news.length,
                  itemBuilder: (context, i) {
                    if (news[0]["status"] == "Failed") {
                      return Center(child: Text("No news"));
                    } else {
                      return Expanded(
                          child: Card(
                        child: Column(
                          children: <Widget>[
                            Text("${news[i]["title"]}",
                                textAlign: TextAlign.left),
                            Text("${news[i]["description"]}"),
                            Text("${news[i]["addby"]}"),
                            Text("${news[i]["files"]}")
                          ],
                        ),
                      ));
                    }
                  })
        ],
      )),
    );
  }
}

class Events extends StatefulWidget {
  Events({Key key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  var events = new List();
  var searchedItems = new List();
  TextEditingController searchNews = new TextEditingController();

  @override
  void initState() {
    super.initState();
    eventsAPI();
  }

  eventsAPI() async {
    var url = "http://13.127.33.107/upload/dhanraj/homework/api/android.php";

    Dio dio = new Dio();
    Response response;

    FormData formData = new FormData.fromMap({
      "action": "get_events",
      "schoolid": schoolID.toString(),
      "acyid": academicYear.toString(),
    });

    response = await dio.post(url, data: formData);
    print('Response body: ${response.data}');
    events = json.decode(response.data);
    print(events);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events"),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          TextField(
              controller: searchNews,
              decoration:
                  InputDecoration(hintText: "Search", labelText: "Search News"),
              onChanged: (value) {
                for (var i = 0; i < events.length; i++) {
                  if (events[i]["title"].contains(value) ||
                      events[i]["description"].contains(value) ||
                      events[i]["addby"].contains(value)) {
                    searchedItems.addAll(events[i]);
                  }
                }
              }),
          searchedItems == null
              ? SizedBox()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchedItems.length,
                  itemBuilder: (context, i) {
                    return Expanded(
                        child: Card(
                      child: Column(
                        children: <Widget>[
                          Text("${searchedItems[i]["title"]}",
                              textAlign: TextAlign.left),
                          Text("${searchedItems[i]["description"]}"),
                          Text("${searchedItems[i]["addby"]}"),
                          Text("${searchedItems[i]["files"]}")
                        ],
                      ),
                    )

                        /* description, files, addby, */
                        );
                  }),
          events == null
              ? Center(child: Text("No Events"))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: events.length,
                  itemBuilder: (context, i) {
                    if (events[0]["status"] == "Failed") {
                      return Center(child: Text("No events"));
                    } else {
                      return Expanded(
                          child: Card(
                        child: Column(
                          children: <Widget>[
                            Text("${events[i]["title"]}",
                                textAlign: TextAlign.left),
                            Text("${events[i]["description"]}"),
                            Text("${events[i]["addby"]}"),
                            Text("${events[i]["files"]}")
                          ],
                        ),
                      ));
                    }
                  })
        ],
      )),
    );
  }
}

class Gallaery extends StatefulWidget {
  Gallaery({Key key}) : super(key: key);

  @override
  _GallaeryState createState() => _GallaeryState();
}

class _GallaeryState extends State<Gallaery> {
  var gallery = new List();
  var searchedItems = new List();
  TextEditingController searchNews = new TextEditingController();

  @override
  void initState() {
    super.initState();
    eventsAPI();
  }

  eventsAPI() async {
    var url = "http://13.127.33.107/upload/dhanraj/homework/api/android.php";

    Dio dio = new Dio();
    Response response;

    FormData formData = new FormData.fromMap({
      "action": "get_gallary",
      "schoolid": schoolID.toString(),
      "acyid": academicYear.toString(),
    });

    response = await dio.post(url, data: formData);
    print('Response body: ${response.data}');
    gallery = json.decode(response.data);
    print(gallery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gallaery")),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          TextField(
              controller: searchNews,
              decoration:
                  InputDecoration(hintText: "Search", labelText: "Search News"),
              onChanged: (value) {
                for (var i = 0; i < gallery.length; i++) {
                  if (gallery[i]["title"].contains(value) ||
                      gallery[i]["description"].contains(value) ||
                      gallery[i]["addby"].contains(value)) {
                    searchedItems.addAll(gallery[i]);
                  }
                }
              }),
          searchedItems == null
              ? SizedBox()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchedItems.length,
                  itemBuilder: (context, i) {
                    return Expanded(
                        child: Card(
                      child: Column(
                        children: <Widget>[
                          Text("${searchedItems[i]["title"]}",
                              textAlign: TextAlign.left),
                          Text("${searchedItems[i]["description"]}"),
                          Text("${searchedItems[i]["addby"]}"),
                          Text("${searchedItems[i]["files"]}")
                        ],
                      ),
                    )

                        /* description, files, addby, */
                        );
                  }),
          gallery == null
              ? Center(child: Text("No news"))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: gallery.length,
                  itemBuilder: (context, i) {
                    if (gallery[0]["status"] == "Failed") {
                      return Container(
                        height:450,
                        child: Center(child: Text("No Gallery")));
                    } else {
                      return Expanded(
                        flex:1,
                          child: Card(
                        child: Column(
                          children: <Widget>[
                            Text("${gallery[i]["title"]}",
                                textAlign: TextAlign.left),
                            Text("${gallery[i]["description"]}"),
                            Text("${gallery[i]["addby"]}"),
                            Text("${gallery[i]["files"]}")
                          ],
                        ),
                      ));
                    }
                  })
        ],
      )),
    );
  }
}
