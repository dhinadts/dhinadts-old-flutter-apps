import 'package:dictionary/otherApps/table_list_design.dart';
import 'package:dictionary/imports.dart';

/// Bar chart example

bool circlevisible = true;
bool checkbokvisible = false;
bool ischeck = false;
int del = 0;

class HomeNeeds extends StatefulWidget {
  @override
  HomeAct createState() {
    return new HomeAct();
  }
}

class HomeAct extends State<HomeNeeds> {
  List<Home_get> list = new List();
  var db = DatabaseHelper();
  var utility_basic = Utility_Basic();
  var shared_preference = Shared_Preference();
  bool animate;
  Home_get product;
  int position = 0;
  bool selectall = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 00.00,
        title: new Text(
          "Home Needs",
        ),
        backgroundColor: Colors.blue,
      ),
      body: new Container(
        child: Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.redAccent,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Text(
                            "S.no",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                      Expanded(
                          flex: 3,
                          child: Text("English Word",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      Expanded(
                          flex: 3,
                          child: Text("Tamil Meaning",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
              ),
              new Expanded(
                  child: new ListView(
                children: list.map((Home_get product) {
                  return new Home_list_design(product);
                }).toList(),
              )),
            ],
          ),
        ),
      ),
    );

    /*return new charts.BarChart(
      seriesList,
      animate: animate,
    );*/
  }

  Future<List<Home_get>> cat() async {
    list.clear();
    List<Map> list1 =
        await db.anyQuery("SELECT * from homeneeds", "dic_new.db");

    for (int i = 0; i < list1.length; i++) {
      String set_id = list1[i]['id'].toString();
      String set_engword = list1[i]['engword'];
      String set_tamilword = list1[i]['tamilword'];

      list.add(new Home_get(
        id: set_id,
        engword: set_engword,
        tamilword: set_tamilword,
      ));
    }
    setState(() {
      list.map((Home_get product) {
        Home_list_design(product);
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    cat();
  }
}

class Home_get {
  String id;
  String engword;
  String tamilword;

  Home_get({String id, String engword, String tamilword}) {
    this.id = id;
    this.engword = engword;
    this.tamilword = tamilword;
  }
}
