import 'package:dictionary/main.dart';

import 'package:flutter/material.dart';

class FavouritedList extends StatefulWidget {
  FavouritedList({Key key}) : super(key: key);

  @override
  _FavouritedListState createState() => _FavouritedListState();
}

class _FavouritedListState extends State<FavouritedList> {
  @override
  void initState() {
    // items.addAll(engWords);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: ListView.builder(
         shrinkWrap: true,
        itemCount: favorited.length,
        itemBuilder: (context, index) {
          return Column(children: <Widget>[
            Card(
                child: ListTile(
              title: Text('${favorited[index]}'),
              
            ))
          ]);
        },
      ),
      /* PageView.builder(
         itemCount: recentWords.length,
         itemBuilder: (BuildContext context, int index) {
           return Center(
             
           child: ListTile(
                              title: Text('${recentWords[index]['EngWord']}'),
                            ));

         },
       ), */
      // ])
    )));
  }
}
