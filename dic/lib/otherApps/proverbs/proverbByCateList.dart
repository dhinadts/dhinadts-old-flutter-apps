import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'package:dictionary/main.dart';

class ProverbListByCat extends StatefulWidget {
  final String title;
  ProverbListByCat({Key key, @required this.title}) : super(key: key);

  @override
  _ProverbListByCatState createState() => _ProverbListByCatState();
}

class _ProverbListByCatState extends State<ProverbListByCat> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      // resizeToAvoidBottomInset: true,
      extendBody: true,
      appBar: AppBar(
        
        primary: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: Text('${widget.title}'),
      ),
      body: 
      Container(
      
        color: Colors.grey,
        child: 
      Padding(
        
        padding: EdgeInsets.only(bottom: 50),
        child: new ListView.builder(
            itemCount: proverbByCat.length,
            itemBuilder: (BuildContext ctxt, int index) {
              var i = index + 1;
              return /* GestureDetector(
                  onTap: () async {
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
                  child: */ Card(
                    borderOnForeground: true,
                    margin: EdgeInsets.all(8.0),
                    /* child: Column(
                      children: <Widget>[
                        Row(children: <Widget>[
                          Text("$i. ${proverbByCat[index]['engpro']}",),
                          IconButton(
                            onPressed: () {
                              Share.share("text");
                            },
                            icon: Icon(Icons.share),
                          ),
                        ],),
                        Text(proverbByCat[index]['tamilpro']),
                      ],
                    ), */

                    
                      child: ListTile(
                    // leading: Text("$i"),
                    trailing: GestureDetector(
                      child: Icon(Icons.share),
                      onTap: () {
                        var a =
                                          "நித்ரா ஆங்கிலம் - தமிழ் அகராதி வழியாக பகிரப்பட்டது. இலவசமாக செயலியை தரவிறக்கம் செய்ய இங்கே கிளிக் செய்யுங்கள் :-\nhttps://goo.gl/7orr0d \n";
                                      var b =
                                          "\nபழமொழிகள்:-\n\n${proverbByCat[index]['tamilpro']}\n\n${proverbByCat[index]['engpro']}\n\n";
                                      var c =
                                          "\nஇதுபோன்ற பல பழமொழிகள் நித்ரா ஆங்கிலம் - தமிழ் அகராதியில் உள்ளது. உடனே, தரவிறக்கம் செய்ய கீழ்க்கண்ட லிங்கை கிளிக் செய்யுங்கள்:- https://goo.gl/7orr0d";

                                      Share.share("$a$b$c");
                      },
                    ),
                    title: Text("$i. ${proverbByCat[index]['engpro']}",  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),),
                    subtitle: Text(proverbByCat[index]['tamilpro'],style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                    /* new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(proverbByCat[index]['tamilpro']),
                              Text(proverbByCat[index]['engpro']),
                            ],
                          ),
                        ),
                      ],*/
                    // ), 
                  ) 
                  // )
                  );
            }),
      )),
    );
  }
}
