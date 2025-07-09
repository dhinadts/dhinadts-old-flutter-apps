import 'package:flutter/material.dart';

class ExitDial {
  Future<bool> exitApp(BuildContext context) {
    return showDialog(
          context: context,
          child: new AlertDialog(
            title: new Text('Do you want to exit?'),
            // content: new Text('We hate to see you leave...'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  var sampleItmem = [
    {"chackBool": false, "id": 1},
    {"chackBool": true, "id": 1}
  ];
  Future<bool> getCheck(BuildContext context)  {
    print(getCheck);
    return sampleItmem[3]["chackBool"] ?? false;
    
  }
}
