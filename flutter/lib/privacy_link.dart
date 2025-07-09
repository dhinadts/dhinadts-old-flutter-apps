// import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// // void main() {
// //   runApp(new MyApp2());
// // }

// class PrivacyHtml extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//      // var title = 'PrivacyPolicy';
//     return new MaterialApp(
//        // title: title,
//       routes: {
//         '/widget': (_) => new WebviewScaffold(
//               url:  "file:///android_asset/flutter_assets/assets/PrivacyPolicy.html",
//               // appBar: 
//               // new AppBar(
//               //     // title: const Text('PrivacyPolicy'),
//               //     ),
//               withZoom: false,
//               withLocalStorage: true,
//             )
//       },
//       home: new MyAppHomePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class MyAppHomePage extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyAppHomePage> {
//   void _opennewpage() {
//     Navigator.of(context).pushNamed('/widget');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         // appBar: AppBar(
//         //   title: Text("Sample App"),
//         // ),

//         body: new Center(
//       child: new RaisedButton(
//           child: Text('PrivacyPolicy'),
//           onPressed: () {
//             _opennewpage();
//           }),
//     ));
//   }
// }
