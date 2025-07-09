import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: AppBar(
        title: Text("News Today"),
      ),
      body: WebviewScaffold(
          url:  "https://nithra.mobi/news/#!/home/bdic/",

    ));
  }
}

