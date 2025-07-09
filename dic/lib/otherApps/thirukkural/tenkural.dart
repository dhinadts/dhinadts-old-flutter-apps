// tenkurals from adhikaram

import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'package:dictionary/main.dart';

class TenKurals extends StatefulWidget {
  final String title;
  TenKurals({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  _TenKuralsState createState() => _TenKuralsState();
}

class _TenKuralsState extends State<TenKurals> {
  @override
  void initState() {
    super.initState();

    // result = db.anyQuery(query, dbName)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      // resizeToAvoidBottomInset: true,
      extendBody: true,
      backgroundColor: Colors.grey,
      appBar: AppBar(
        primary: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: Text('${widget.title}'),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 50),
        
        child: new ListView.builder(
            itemCount: tenkurals.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return /* GestureDetector(
                  onTap: ()  {
                    if (Platform.isAndroid) {
                      Share.share(
                          '${tenkurals[index]['kural_no']}..  உலக மக்கள் அனைவருக்கும்  ஈரடியில் உலக தத்துவத்தை எடுத்துரைக்கும் இது போன்ற திருக்குறளை உங்கள் நண்பர்களுக்கும் பகிர இங்கே கிளிக் செய்யுங்கள்.\n\n https://goo.gl/mZU2qr');
                      // return new MyApp12345();
                    } else if (Platform.isIOS) {
                      Share.share(
                          '${tenkurals[index]['kural_no']}.. உலக மக்கள் அனைவருக்கும்  ஈரடியில் உலக தத்துவத்தை எடுத்துரைக்கும் இது போன்ற திருக்குறளை உங்கள் நண்பர்களுக்கும் பகிர இங்கே கிளிக் செய்யுங்கள்.\n\n IOS Link');
                      // return new MyApp12345();
                    }
                  },
                  child:  */
                  Card(
                    borderOnForeground: true,
                    // color: Colors.blueGrey,
                    margin: EdgeInsets.all(8.0),
                    
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child:
                    Column(

                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Align(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text(
                                "குறள்: ${tenkurals[index]['kuralno']}\n",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurpleAccent,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              new GestureDetector(
                                child: Icon(
                                  Icons.share,
                                ),
                                onTap: () {
                                   var a =
                                          "நித்ரா ஆங்கிலம் - தமிழ் அகராதி வழியாக பகிரப்பட்டது. இலவசமாக செயலியை தரவிறக்கம் செய்ய இங்கே கிளிக் செய்யுங்கள் :-\nhttps://goo.gl/7orr0d \n";
                                       var b =
                                           "\nதிருக்குறள்:- \n\n${tenkurals[index]['kural1']}\n${tenkurals[index]['kural2']}\n\nவிளக்கம் :-\n${tenkurals[index]['tamildef']}\n\nஆங்கில விளக்கம்  :-\n${tenkurals[index]['engdef']}\n\nஆங்கில வடிவில் :-\n\n${tenkurals[index]['engkural1']}\n${tenkurals[index]['engkural2']}\n\n";
                                      var c =
                                          "\nஇதுபோன்ற பல திருக்குறள்கள் நித்ரா ஆங்கிலம் - தமிழ் அகராதியில் உள்ளது. உடனே, தரவிறக்கம் செய்ய கீழ்க்கண்ட லிங்கை கிளிக் செய்யுங்கள்:- https://goo.gl/7orr0d";

                                      Share.share("$a$b$c");
                                },
                              )
                            ],
                          ),
                        ),
                        Align(
                          child: Text(
                            "${tenkurals[index]['kural1']}\n${tenkurals[index]['kural2']}\n",
                            style: TextStyle(
                              /* fontSize: 15 + a, */
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                        Divider(
                          thickness: 1.0,
                          color: Colors.black,
                        ),
                        Align(
                          child: new Text(
                            "விளக்கம் :-\n",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent, ),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Text("${tenkurals[index]['tamildef']}\n", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,),),
                        Divider(
                          thickness: 1.0,
                          color: Colors.black,
                        ),
                        Align(
                          child: new Text(
                            "ஆங்கில விளக்கம் :- \n",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent,),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Text("${tenkurals[index]['engdef']}\n", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,),),
                        Divider(
                          thickness: 1.0,
                          color: Colors.black,
                        ),
                        Align(
                          child: new Text(
                            "ஆங்கில வடிவில் :-\n",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent,),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Text(
                          "${tenkurals[index]['engkural1']}\n${tenkurals[index]['engkural2']}\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),

                    /*    child: ListTile(
                    // contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                    leading: Text("${tenkurals[index]['kuralno']}"),
                    trailing: GestureDetector(
                      child: Icon(Icons.share),
                      onTap: () {
                        Share.share("${tenkurals[index]['kuralno']}: ${tenkurals[index]['kural1']}\n${tenkurals[index]['kural2']}");
                      },
                    
                    ),
                    
                    title: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        
                        Expanded(
                          child: Text(
                        
                            '${tenkurals[index]['kural1']}\n${tenkurals[index]['kural2']}',
                            textScaleFactor: 1.0,
                            softWrap: true,
                            textAlign: TextAlign.start,
                            style: new TextStyle(
                              fontSize: 13,
                              // fontWeight:
                              //     FontWeight.bold
                            ), // textScaleFactor: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ) */
              // )
              ));
            }),
      ),
    );
  }
}
