import 'package:flutter/material.dart';

import 'package:dictionary/main.dart';
import 'package:share/share.dart';

class HomoPhones extends StatefulWidget {
  @override
  HomoPhonesState createState() => HomoPhonesState();
}

class HomoPhonesState extends State<HomoPhones> {
  String homophonesQuery = "select * from homophones";
    List<HomoPhonesGet> list = new List();
      HomoPhonesGet product;



  @override
  void initState() {
    super.initState();
    homophonesQ();
    cat();
  }

  homophonesQ() async {
    homophones = await db.anyQuery(homophonesQuery, dbName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("HomoPhones"),
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
        body: 

        new Container(
        color: Colors.grey,
        child: Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  child: new ListView(
                children: list.map((HomoPhonesGet product) {
                  return new HomoPhones_list_design(product);
                }).toList(),
              )),
            ],
          ),
        ),
      ),
        
        // Padding(
        //   padding: EdgeInsets.only(bottom: 50),
        //   child: new ListView.builder(
        //     itemCount: homophones.length,
        //     itemBuilder: (context, i) => new Column(
        //       children: <Widget>[
        //         new Divider(
        //           height: 10.0,
        //         ),
        //         new GestureDetector(
        //             onTap: () async {
        //               /* indexKey = i;
        //               var sql =
        //                   'SELECT kuralno from thirukuralnew where catname = "${athikaram[i]['catname']}"';
        //               tenkurals = await db.anyQuery(sql, dbName);
        //               print(tenkurals);
        //               await Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) =>
        //                           null //TenKurals()
        //                           )); */ // null = AdhikaramKural()
        //             },
        //             child: ListTile(
        //               title: new Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: <Widget>[
        //                   Card(
        //                     child: Column(
        //                       children: <Widget>[
        //                         Align(
        //                             alignment: Alignment.topRight,
        //                             child: Icon(Icons.share)),
        //                         Text(homophones[i]['engword1']),
        //                         Text(homophones[i]['tamilword1']),
        //                         Text(homophones[i]['engword2']),
        //                         Text(homophones[i]['tamilword2']),
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ))
        //       ],
        //     ),
        //   ),
        // )
        );
  }




  Future<List<HomoPhonesGet>> cat() async {
    list.clear();
    List<Map> list1 =
        await db.anyQuery("select * from homophones", "dic_new.db");

    for (int i = 0; i < list1.length; i++) {
      String set_engword1 = list1[i]['engword1'];
      String set_engword2 = list1[i]['engword2'];
      String set_tamilword1 = list1[i]['tamilword1'];
      String set_tamilword2 = list1[i]['tamilword2'];
      int set_id = i + 1;

      list.add(new HomoPhonesGet(
        engword1: set_engword1,
        engword2: set_engword2,
        tamilword1: set_tamilword1,
        tamilword2 : set_tamilword2,
        id: set_id,
      ));
    }
    setState(() {
      list.map((HomoPhonesGet product) {
        HomoPhones_list_design(product);
      }).toList();
    });
  }


}

class HomoPhonesGet {
  String engword1;
  String engword2;
  String tamilword1;
  String tamilword2;
  int id;

  HomoPhonesGet(
      {String engword1,
      String engword2,
      String tamilword1,
      String tamilword2,
      int id}) {
    this.engword1 = engword1;
    this.engword2 = engword2;
    this.tamilword1 = tamilword1;
    this.tamilword2 = tamilword2;
    this.id = id;
  }
}



class HomoPhones_list_design extends StatefulWidget {
  var product;

  HomoPhones_list_design(var product)
      : product = product,
        super(key: new ObjectKey(product));

  @override
  list_designState createState() {
    return new list_designState(product);
  }
}

class list_designState extends State<HomoPhones_list_design> {
  var product;

  list_designState(this.product);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      
      padding: EdgeInsets.only(top: 4.0),
      child: Container(
           color: Colors.grey,
          child: Column(
        children: <Widget>[
          Padding(
               padding: const EdgeInsets.only(top:3.0),
              child: Card(
                 borderOnForeground: true,
                    // color: Colors.blueGrey,
                    // margin: EdgeInsets.all(3.0),
                    
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child:
                    Column(
                  children: <Widget>[
                    Align(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '${product.id}.\n',
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          GestureDetector(
                            child: Icon(Icons.share),
                            onTap: () {
                               var a =
                                          "நித்ரா ஆங்கிலம் - தமிழ் அகராதி வழியாக பகிரப்பட்டது. இலவசமாக செயலியை தரவிறக்கம் செய்ய இங்கே கிளிக் செய்யுங்கள் :-\nhttps://goo.gl/7orr0d \n";
                                       var b =
                                           "\nHomophones :- \n\n${product.engword1} - ${product.tamilword1}\n\n${product.engword2} - ${product.tamilword2}\n\n";
                                      var c =
                                          "\nஇதுபோன்ற பல Homophones நித்ரா ஆங்கிலம் - தமிழ் அகராதியில் உள்ளது. உடனே, தரவிறக்கம் செய்ய கீழ்க்கண்ட லிங்கை கிளிக் செய்யுங்கள்:- https://goo.gl/7orr0d";

                                      Share.share("$a$b$c");
                            },
                          ),
                        ],
                      ),
                    ),
                    Align(
                      child: Text(
                        '${product.engword1} - ${product.tamilword1}\n',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Align(
                      child: Text(
                        '${product.engword2} - ${product.tamilword2}\n',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    
                  ],
                ),
              )    )),
        ],
      )),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
