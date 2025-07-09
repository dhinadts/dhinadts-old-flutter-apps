import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// void main() {
//   runApp(new MyApp2());
// }
  
class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var title = 'Webview Demo';
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
        // title: title,
        routes: {
          // '/widget': (_) => new WebviewScaffold(
            '/': (_) => new WebviewScaffold(
            url: "https://www.nithra.mobi/privacy.php",
            // url:  "file:///android_asset/flutter_assets/assets/PrivacyPolicy.html",
            // appBar: new AppBar(
            //   title: const Text('Widget Webview'),
            // ),
            withZoom: false,
            withLocalStorage: true,
          )
        },
        //  home: new MyAppHomePage(),
    );
  }
}

class MyAppHomePage extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}

  
class _MyAppState extends State<MyAppHomePage> {
  void _opennewpage() {
    Navigator.of(context).pushNamed('/widget');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
          // appBar: AppBar(
          //   // title: Text("Nithra Privacy Policy"),
          // ),
          body: //  _opennewpage()
          new Center(
            child: new RaisedButton(
              child: Text('Privacy Policy'),
              onPressed: () { 
                _opennewpage();                               
              }
            ) ,
          )
    ); 
  }

}