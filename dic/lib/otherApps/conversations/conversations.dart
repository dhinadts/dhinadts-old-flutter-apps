import 'package:flutter/material.dart';

import 'package:dictionary/main.dart';

var convCat;
var topicname;
var index;
String convCatList = "SELECT DISTINCT categoryname from conversation ";

class Conversation extends StatefulWidget {
  @override
  ConversationState createState() => ConversationState();
}

class ConversationState extends State<Conversation> {
  // String queryAthikaram = "SELECT DISTINCT catname from thirukuralnew";

  @override
  void initState() {
    super.initState();
    // athikaramQ();
    converCatQ();
  }

  converCatQ() async {
    // athikaram = await db.anyQuery(queryAthikaram, dbName);
    convCat = await db.anyQuery(convCatList, dbName);
    // detailedCat = await db.anyQuery(detailQuery, dbName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Conversation"),
          actions: <Widget>[],
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
          child: 
          new ListView.builder(
            itemCount: convCat.length,
            itemBuilder: (context, i) {
              return new ExpansionTile(
                title: new Text(
                  convCat[i]['categoryname'],
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
                children: // null,
                /* for(var im =0; im<convCat.length; im++) */
                     _getChildren(convCat[i]['categoryname']),
                    //  onExpansionChanged: summa(convCat[i]['categoryname']),
                // _buildExpandableContent(convCat[i]['categoryname']),
              );
            },
          ),
        ));
  }

   summa(var s) async {
    print("S::" + s);
    var query = 'select topicname from conversation where categoryname ="$s"';
    topicname = await db.anyQuery(query, dbName);
    print("topicname:: " + topicname);
    
  }

   List<Widget> _getChildren(var s) {
    List<Widget> children = [];
    print("category:: " + s);
    summa(s);
    // var query = 'select topicname from conversation where categoryname ="$s"';
    // topicname =  db.anyQuery(query, dbName);
    for (var i = 0; i < topicname.length; i++) {
      children.add(
        new ListTile(
          title: new Text(
            "${topicname[i]["topicname"]}",
            // "$i",
            style: new TextStyle(fontSize: 18.0),
          ),
        
        ),
        
      );
    }
    return children;
  }

  // _buildExpandableContent(String catName) async {
  _buildExpandableContent(var s) {
    List<Widget> columnContent = [];
    //  List<Widget> columnContent = new List<Widget>();

    var query = 'select topicname from conversation where categoryname ="$s"';
    // var  topicname = new List();
    topicname = db.anyQuery(query, dbName);
    var len = topicname.length;
    for (var i = 0; i < topicname.length; i++) {
      columnContent.add(
        new ListTile(
          title: new Text(
            "${topicname[i]["topicname"]}",
            //  "$i",
            style: new TextStyle(fontSize: 18.0),
          ),
          // leading: new Icon(vehicle.icon),
        ),
      );
      // columnContent = new Text("1234567890") as List<Widget>;
      return columnContent;
    }

    List<Text> createChildrenTexts(String catName) {
      String query =
          'select topicname from conversation where categoryname ="$catName"';
      topicname = db.anyQuery(query, dbName);
      var len = topicname.length;
      // for (var i = 0; i < len; i++) {
      //   columnContent.add(
      //     new ListTile(
      //       title: new Text(
      //         // "${topicname[i]['topicname']}",
      //         "$i",
      //         style: new TextStyle(fontSize: 18.0),
      //       ),
      //       // leading: new Icon(vehicle.icon),
      //     ),
      //   );
// columnContent = new Text("1234567890") as List<Widget>;
//        return columnContent;
      return topicname
          .map((text) => Text(
                text,
                style: TextStyle(color: Colors.blue),
              ))
          .toList();
    }
  }
}
