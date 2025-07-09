import 'package:flutter/material.dart';

import 'package:dictionary/main.dart';

String aathiSudiQuery = "select * from aathisudi";

class AathiSudi extends StatefulWidget {
  @override
  AathiSudiState createState() => AathiSudiState();
}

class AathiSudiState extends State<AathiSudi> {

    List<AathisudiGet> list = new List();
      AathisudiGet product;



  @override
  void initState()  {
    super.initState();
    aathisudiQ();
    aathisudiget();
  }

  aathisudiQ() async {
    aathisudi = await db.anyQuery(aathiSudiQuery, dbName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("AathiSudi"),
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
          child: //Card(
          /* new ListView.builder(
            itemCount: aathisudi.length,
            itemBuilder: (context, i) {
              return  */
               Expanded(
                child: new ListView(
                children: list.map((AathisudiGet product) {
                  return new AathisudiDesign(product);
                }).toList(),
              )
             //  )
            //   );
            // }
            /* new Column(
              children: <Widget>[
                new Divider(
                  height: 10.0,
                ),
                new GestureDetector(
                    onTap: () async {
                      
                    },
                    child: ListTile(
                      title: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Card(
                            child: Row(
                              children: <Widget>[
                                
                                Column(
                                  children: <Widget>[
                                    Text(aathisudi[i]['tamiltxt']),
                                Text(aathisudi[i]['engtxt']),
                                Text(aathisudi[i]['tamildes']),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(Icons.share)),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ), */
          ),
        ));
    
  }


Future<List<AathisudiGet>> aathisudiget() async {
    list.clear();
    List<Map> list1 =
        await db.anyQuery(aathiSudiQuery, dbName);

    for (int i = 0; i < list1.length; i++) {
      String set_tamiltxt = list1[i]['tamiltxt'];
      String set_engtxt = list1[i]['engtxt'];
      String set_tamildes = list1[i]['tamildes'];

      list.add(new AathisudiGet(
        tamiltxt: set_tamiltxt,
        engtxt: set_engtxt,
        tamildes: set_tamildes,
      ));
    }
    setState(() {
      list.map((AathisudiGet product) {
        // null;
        AathisudiDesign(product);
      }).toList();
    });
  }

  
}


class AathisudiGet {
  String tamiltxt;
  String engtxt;
  String tamildes;

  AathisudiGet({String tamiltxt, String engtxt, String tamildes}) {
    this.tamiltxt = tamiltxt;
    this.engtxt = engtxt;
    this.tamildes = tamildes;
  }
}




class AathisudiDesign extends StatefulWidget {

   var product;


  AathisudiDesign(var product)
      : product = product,
        super(key: new ObjectKey(product));

  @override
  list_designState createState() {
    return new list_designState(product);
  }
}

class list_designState extends State<AathisudiDesign> {
   var  product;

  list_designState(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black,
      // padding: EdgeInsets.all(1.0),
      child: Container(
          // color: Colors.white,
          child: Column(
            children: <Widget>[
              Text(
                        '${product.tamiltxt}',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '${product.engtxt}',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                       Text(
                        '${product.tamildes}',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                      ),

              /* Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        '${product.tamiltxt}',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(
                      thickness: 5.0,
                      color: Colors.black,
                    ),

                    Expanded(
                      flex: 3,
                      child: Text(
                        '${product.engtxt}',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        '${product.tamildes}',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                    ), */
              //     ], 
              //   ),
              // ),

            ],
          )),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
