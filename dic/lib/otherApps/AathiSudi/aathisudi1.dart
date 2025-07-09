import 'package:dictionary/imports.dart';

/// Bar chart example

bool circlevisible = true;
bool checkbokvisible = false;
bool ischeck = false;
int del = 0;

class Aathisudi1 extends StatefulWidget {
  @override
  HomeAct createState() {
    return new HomeAct();
  }
}

class HomeAct extends State<Aathisudi1> {
  List<AathisudiGet1> list = new List();
  var db = DatabaseHelper();
  var utility_basic = Utility_Basic();
  var shared_preference = Shared_Preference();
  bool animate;
  AathisudiGet1 product;
  int position = 0;
  bool selectall = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 00.00,
        title: new Text(
          "ஆத்திச்சூடி",
        ),
        backgroundColor: Colors.blue,
      ),
      body: new Container(
        color: Colors.grey,
        child: Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  child: new ListView(
                children: list.map((AathisudiGet1 product) {
                  return new Aathisudi_list_design(product);
                }).toList(),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<AathisudiGet1>> cat() async {
    list.clear();
    List<Map> list1 =
        await db.anyQuery("select * from aathisudi", "dic_new.db");

    for (int i = 0; i < list1.length; i++) {
      String set_tamiltxt = list1[i]['tamiltxt'].toString();
      String set_engword = list1[i]['engtxt'];
      String set_tamildes = list1[i]['tamildes'];
      int set_id = i + 1;

      list.add(new AathisudiGet1(
        tamiltxt: set_tamiltxt,
        engtxt: set_engword,
        tamildes: set_tamildes,
        id: set_id,
      ));
    }
    setState(() {
      list.map((AathisudiGet1 product) {
        Aathisudi_list_design(product);
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    cat();
  }
}

class AathisudiGet1 {
  String tamiltxt;
  String engtxt;
  String tamildes;
  int id;

  AathisudiGet1({String tamiltxt, String engtxt, String tamildes, int id}) {
    this.tamiltxt = tamiltxt;
    this.engtxt = engtxt;
    this.tamildes = tamildes;
    this.id = id;
  }
}

class Aathisudi_list_design extends StatefulWidget {
  var product;

  Aathisudi_list_design(var product)
      : product = product,
        super(key: new ObjectKey(product));

  @override
  list_designState createState() {
    return new list_designState(product);
  }
}

class list_designState extends State<Aathisudi_list_design> {
  var product;

  list_designState(this.product);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.0),
      child: Container(
          color: Colors.grey,
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Card(
                      borderOnForeground: true,
                      // color: Colors.blueGrey,
                      // margin: EdgeInsets.all(5.0),

                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Align(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '${product.id}.  ${product.tamiltxt}\n\n',
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
                                          "\n\nஆத்திச்சூடி:-\n\n${product.tamiltxt}\n\n${product.engtxt}\n\n${product.tamildes}\n\n";
                                      var c =
                                          "\nஇதுபோன்ற பல ஆத்திச்சூடிகள் நித்ரா ஆங்கிலம் - தமிழ் அகராதியில் உள்ளது. உடனே, தரவிறக்கம் செய்ய கீழ்க்கண்ட லிங்கை கிளிக் செய்யுங்கள்:- https://goo.gl/7orr0d";

                                      Share.share("$a$b$c");
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              child: Text(
                                '${product.engtxt}\n',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Align(
                              child: Text(
                                '${product.tamildes}\n',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                          ],
                        ),
                      ))),
            ],
          )),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
