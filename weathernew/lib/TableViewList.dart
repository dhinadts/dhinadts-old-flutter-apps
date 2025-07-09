import 'package:flutter/material.dart';
import 'package:weathernew/main.dart';

class TableViewList extends StatefulWidget {
  TableViewList({Key key}) : super(key: key);

  @override
  _TableViewListState createState() => _TableViewListState();
}

class _TableViewListState extends State<TableViewList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text(
            "${weatherDetails[0]["location"]["name"]}",
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text("${weatherDetails[0]["location"]["country"]}",
              style: TextStyle(color: Colors.white)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 300.0,
            child: Table(
              border: TableBorder.all(),

              children: [
                TableRow(children: [
                  Column(children: [Text('Temp in Deg')]),
                  Column(children: [Text('observed time')]),
                  Column(children: [Text('weather descriptions')]),
                  Column(children: [Text('humidity')]),
                ]),
                TableRow(children: [
                  Center(
                      child: Text(
                          "${weatherDetails[0]["current"]["temperature"]}")),
                  Center(
                      child: Text(
                          '${weatherDetails[0]["current"]["observation_time"]}')),
                  Center(
                      child: Text(
                          '${weatherDetails[0]["current"]["weather_descriptions"][0]}')),
                  Center(
                      child:
                          Text('${weatherDetails[0]["current"]["humidity"]}')),
                ]),
              ],
              //      )  ,),
            )),
      ),
    );
  }
}
