import 'package:flutter/material.dart';

import '../controllers.dart';

// List<Map<String, dynamic>> result2;

class AdhikaramKural extends StatefulWidget {
  @override
  AdhikaramKuralState createState() {
    return new AdhikaramKuralState();
  }
}

class AdhikaramKuralState extends State<AdhikaramKural> {
  @override
  void initState() {
    super.initState();
    athikaramKural(iyal_S[0]['iyal_tamil']);

    // _onSelectItem1(result1[0]['pal_tamil']);
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: adhikaram_S.length,
      itemBuilder: (context, i) => new Column(
        children: <Widget>[
          new Divider(
            height: 10.0,
          ),
          new ListTile(
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  adhikaram_S[i]['adhikarm_tamil'],
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
