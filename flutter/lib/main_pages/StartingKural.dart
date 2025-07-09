// import 'dart:convert';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// class BeginingKural extends StatelessWidget {
//   var items;

//   @override
//   Widget build(BuildContext context) {
//     // todo: implement build
//     return

//     FutureBuilder(
//                 future: DefaultAssetBundle.of(context)
//                     .loadString('assets/complete1.json'),
//                 builder: (context, snapshot) {
//                   // Decode the JSON
//                   var newData = json.decode(snapshot.data.toString());
//                    /*
// CarouselSlider(
// //   items: items,
// //   viewportFraction: 0.8,
// //   initialPage: 0,
// //   aspectRatio: 16/9,
// //   height: 400,
// //   reverse: false,
// //   autoPlay: false,
// //   interval: const Duration(seconds: 4),
// //   autoPlayCurve: Curves.fastOutSlowIn,
// //   autoPlayDuration: const Duration(milliseconds: 800),
// //   updateCallback: someFunction
// // )

//                    */

//                   return CarouselSlider(
//   items: newData,
//   viewportFraction: 0.8,
//   initialPage: 0,
//   aspectRatio: 16/9,
//   height: 400,
//   reverse: false,
//   autoPlay: false,
//   interval: const Duration(seconds: 4),
//   autoPlayCurve: Curves.fastOutSlowIn,
//   autoPlayDuration: const Duration(milliseconds: 800),

// );

// /* ListView.builder(
//                     // Build the ListView
//                     itemBuilder: (BuildContext context, int index) {
//                       return Card(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: <Widget>[
//                             // Text("Kural: " + newData[index]['kural_no']),
//                             Text("kural_tamil1: " + newData[index]['kural_tamil1']),
//                             Text("kuralvilakam_tamil: " + newData[index]['kuralvilakam_tamil']),
//                             Text(
//                                 "pal_tamil: " + newData[index]['pal_tamil']),
//                             Text(
//                                 "adhikarm_tamil: " + newData[index]['adhikarm_tamil']),
//                             Text("iyal_tamil: " + newData[index]['iyal_tamil']),
//                             // Text(
//                             //     "adhikarm_no: " + newData[index]['adhikarm_no']),
//                             Text("desc1: " + newData[index]['desc1'])
//                           ],
//                         ),
//                       );
//                     },
//                     itemCount: newData == null ? 0 : newData.length,
//                   ); */

//                 });

// //     new  CarouselSlider(
// //   items: items,
// //   viewportFraction: 0.8,
// //   initialPage: 0,
// //   aspectRatio: 16/9,
// //   height: 400,
// //   reverse: false,
// //   autoPlay: false,
// //   interval: const Duration(seconds: 4),
// //   autoPlayCurve: Curves.fastOutSlowIn,
// //   autoPlayDuration: const Duration(milliseconds: 800),
// //   updateCallback: someFunction
// // )
//     // CarouselSlider(items: <Widget>[],);
//   }

// }

// Flutter code sample for

// This sample shows an [AppBar] with two simple actions. The first action
// opens a [SnackBar], while the second action navigates to a new page.

import 'package:dhina/fragments/first_fragment.dart';
import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

/// This Widget is the main application widget.
class BeginingKural extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      title: _title,
      home: MyStatelessWidget(),
    );
  }
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));

void openPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  // Scaffold.of(context).openDrawer();
                  Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return new FirstFragment();
                  }));
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: const Text('Thirukkural'),
        ),
        body: const Center(
          child: Text(
            'This is the next page',
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
    },
  ));
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Thirukkural'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              scaffoldKey.currentState.showSnackBar(snackBar);
            },
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Next page',
            onPressed: () {
              openPage(context);
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'This is the home page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
