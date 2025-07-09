import 'package:flutter/material.dart';

// void main(){
//   runApp(new MaterialApp(
//     home: new MyApp(),
//   ));
// }
double _value = 0.0;
  

class SIMpleSlider extends StatefulWidget {
  @override
  _State createState() => new _State();
}

//State is information of the application that can change over time or when some actions are taken.
class _State extends State<SIMpleSlider>{

  void _setvalue(double value) => setState(() => _value = value);
Widget alert1() {
        return AlertDialog(
        title: Text('Rewind and remember'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Slider(value: _value, onChanged: _setvalue),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Regret'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
}
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Name here'),
      ),
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text('Value: ${(_value * 100).round()}'),
              new Slider(value: _value, onChanged: _setvalue),
              new AlertDialog(
        title: Text('Rewind and remember'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Slider(value: _value, onChanged: _setvalue),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Regret'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      IconButton(
              icon: const Icon(Icons.text_format),
              onPressed: () async {
                print("text font varying");
                return showDialog(
        context: context,
        builder: (context) {
          return alert1();
                  });
            
                        },
                      ),
          
          
                      ],
                    ),
                  ),
                ),
              );
            }
          }
          
          