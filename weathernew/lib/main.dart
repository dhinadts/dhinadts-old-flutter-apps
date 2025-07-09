import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:weathernew/TableViewList.dart';

import 'package:weathernew/utilityBasics.dart';

void main() => runApp(MyApp());

var utilitybasic = UtilityBasicS();

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Weather Report';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

var weatherJSON; // = new List();
var weatherDetails = new List();
double long = 13.08, lat = 80.27;
bool setbool = false;
String icon, cityName, country;

TextEditingController enteredCity = TextEditingController();

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    MyApp12(long: long, lat: lat),
    // MapSample(),

    ListedCities(/* icon: icon, cityName: cityName, country: country */),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(index);
    });
  }

  @override
  void initState() {
    super.initState();

    initialMap();
  }

  initialMap() async {
    long = 13.08;
    lat = 80.27;
    weatherDetails = null;
    _onMapCreated(mapController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: const Text('Weather Report'),
      ),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                border: new Border.all(
                    style: BorderStyle.solid, color: Colors.black45),
                borderRadius: BorderRadius.circular(5)),
            child: Align(
                alignment: Alignment.centerRight,
                child: TextField(
                  controller: enteredCity,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                    hintText: "Enter City Name",
                  ),
                  maxLines: 1,
                  style: TextStyle(fontSize: 20, height: 1.5),
                  onChanged: (newValue) {},
                )),
          ),
        ),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: RaisedButton(
                child: _selectedIndex == 0
                    ? Text("Place in Map")
                    : Text("City List"),
                onPressed: () async {
                  var url =
                      'http://api.weatherstack.com/current?access_key=7ae6d45c98ecb36de7c43e1d00592396&query=${enteredCity.text}';

                  weatherJSON = await http.post(url);
                  weatherJSON = json.decode(weatherJSON.body);
                  print(weatherJSON.length);
                  print(weatherJSON);
                  if (weatherJSON["success"] == false) {
                    utilitybasic.toastfun(weatherJSON["error"]["info"]);
                  } else {
                    setState(() {
                      // weatherJSON = json.decode(weatherJSON.body);
                      weatherDetails = [weatherJSON];

                      lat = double.parse(
                          weatherJSON["location"]["lat"].toString());
                      long = double.parse(
                          weatherJSON["location"]["lon"].toString());
                      center = LatLng(lat, long);
                      _onMapCreated(mapController);
                      icon = weatherDetails[0]["current"]["weather_icons"][0];
                      cityName = weatherDetails[0]["location"]["name"];
                      country = weatherDetails[0]["location"]["country"];
                    });

                    print(lat);
                    print(long);
                    print(weatherDetails);
                    print(weatherDetails.length);
                  }
                  setState(() {});
                })),
        Expanded(
          flex: 1,
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Map'),
          ),
          /*  BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Map2'),
          ), */
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            title: Text('ListView'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class ListedCities extends StatefulWidget {
  final String icon;
  final String cityName;
  final String country;
  ListedCities({Key key, this.icon, this.cityName, this.country})
      : super(key: key);

  @override
  _ListedCitiesState createState() => _ListedCitiesState();
}

class _ListedCitiesState extends State<ListedCities> {
  @override
  void initState() {
    super.initState();
    /* setState(() {
      icon = weatherJSON["current"]["weather_icons"][0];
                      cityName = weatherDetails["location"]["name"];
                      country = weatherDetails["location"]["country"];
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            /* Container(
            margin: EdgeInsets.all(10),
            child:  */
            weatherDetails != null
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: weatherDetails.length,
                    itemBuilder: (context, index) {
                      return
                          /*  Column(
                children: <Widget>[ */
                          Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0)),
                        elevation: 20.0,
                        margin: EdgeInsets.only(
                            top: 5.0, left: 5.0, right: 5.0, bottom: 5.0),
                        child: new ListTile(
                          leading: Image.network(
                              // "${weatherDetails["current"]["weather_icons"]}"),
                              "${weatherDetails[index]["current"]["weather_icons"][0]}"),
                          title: Text(
                              "${weatherDetails[index]["location"]["name"]}"), // Text("${weatherDetails["location"]["name"]}"),
                          subtitle:
                              //Text("${weatherDetails["location"]["country"]}"),
                              Text(
                                  "${weatherDetails[index]["location"]["country"]}"),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TableViewList()),
                            );
                          },
                        ),
                      );
                      /*  ],
              ) */
                    })
                : SizedBox()); // );
  }
}

class MyApp12 extends StatefulWidget {
  final double lat;
  final double long;

  const MyApp12({Key key, @required this.lat, @required this.long})
      : super(key: key);
  @override
  _MyApp12State createState() => _MyApp12State();
}

GoogleMapController mapController;
LatLng center = LatLng(lat, long);
Map<String, Marker> markers; // = {};
var marker; // = new Marker();
void _onMapCreated(GoogleMapController controller) {
  mapController = controller;

  controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      //bearing: 192.8334901395799,
      target: center, // LatLng(lat, long),
      // tilt: 59.440717697143555,
      zoom: 11)));
  marker = Marker(
    markerId: MarkerId(weatherDetails[0]["location"]["name"]),
    position: LatLng(lat, long),
    infoWindow: InfoWindow(
      title: "weather details",
      snippet: "Temp: ${weatherDetails[0]["current"]["temperature"]}",
    ),
  );
}

class _MyApp12State extends State<MyApp12> {
  @override
  void initState() {
    this.fn1();
    super.initState();

    center = LatLng(lat, long);
  }

  fn1() {
    setState(() {
      center = LatLng(lat, long);
    });
  }

  fn() async {
    var url =
        'http://api.weatherstack.com/current?access_key=7ae6d45c98ecb36de7c43e1d00592396&query=${enteredCity.text}';
    // var url1 = url+ accessKey + citySelected;
    weatherJSON = await http.post(url);
    weatherJSON = json.decode(weatherJSON.body);
    print(weatherJSON.length);
    print(weatherJSON);
    setState(() {
      // weatherJSON = json.decode(weatherJSON.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          /* Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[ */
          Container(
        height: 300.0,
        child: GoogleMap(
          myLocationEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            bearing: 192.8334901395799,
            target: LatLng(lat, long),
            zoom: 11.0,
          ),
          markers: marker,
        ),
      ),
      /*  weatherDetails != null
              ? Expanded(
                  child: ListTile(
                  leading: Image.network(
                      "${weatherDetails["current"]["weather_icons"]}"),
                  title: Text("${weatherDetails["location"]["name"]}"),
                  subtitle: Text("${weatherDetails["location"]["country"]}"),
                  trailing: Text("${weatherDetails["current"]["temperature"]}"),
                ))
              : Expanded(child: SizedBox()) */
      /* ] ,
      ), */
    );
  }
}
