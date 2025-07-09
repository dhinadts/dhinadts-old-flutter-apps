import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var url = 'http://localhost:3000/addrating';

class Post {
  var rATE;

  Post({this.rATE});
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      rATE: json['rATE'],
    );
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["rATE"] = rATE;
  }
}

Future<Post> createPost(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    } else {
      print(Post.fromJson(json.decode(response.body)));
      return Post.fromJson(json.decode(response.body));
    }
  });
}

TextEditingController rateControler = new TextEditingController();

Future<void> _ackAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Not in stock'),
        content: const Text('This item is no longer available'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

enum ConfirmAction { CANCEL, ACCEPT }
Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Reset settings?'),
        content: const Text(
            'This will reset your device to its default factory settings.'),
        actions: <Widget>[
          FlatButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: const Text('ACCEPT'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )
        ],
      );
    },
  );
}

Future<String> _asyncInputDialog(BuildContext context) async {
  String teamName = '';
  return showDialog<String>(
    context: context,
    barrierDismissible:
        false, // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter current team'),
        content: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Team Name', hintText: 'eg. Juventus F.C.'),
              onChanged: (value) {
                teamName = value;
              },
            ))
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop(teamName);
            },
          ),
        ],
      );
    },
  );
}

enum Departments { Production, Research, Purchasing, Marketing, Accounting }

Future<Departments> _asyncSimpleDialog(BuildContext context) async {
  return await showDialog<Departments>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select Departments '),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, Departments.Production);
              },
              child: const Text('Production'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, Departments.Research);
              },
              child: const Text('Research'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, Departments.Purchasing);
              },
              child: const Text('Purchasing'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, Departments.Marketing);
              },
              child: const Text('Marketing'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, Departments.Accounting);
              },
              child: const Text('Accounting'),
            )
          ],
        );
      });
}

class exa_dias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showRatingDialog() {
      // We use the built in showDialog function to show our Rating Dialog
      showDialog(
          context: context,
          barrierDismissible:
              true, // set to false if you want to force a rating
          builder: (context) {
            return RatingDialog(
              icon: const FlutterLogo(
                  size: 100,
                  colors: Colors.red), // set your own image/icon widget
              title: "The Rating Dialog",
              description:
                  "Tap a star to set your rating. Add more description here if you want.",
              submitButton: "SUBMIT",
              alternativeButton: "Contact us instead?", // optional
              positiveComment: "We are so happy to hear :)", // optional
              negativeComment: "We're sad to hear :(", // optional
              accentColor: Colors.red, // optional
              onSubmitPressed: (int rating) async {
                print("onSubmitPressed: rating = $rating");
                // int a = rating;
                Post newPost = new Post(
                  rATE: rating,
                );
                // Post p = await createPost(CREATE_POST_URL,
                //     body: newPost.toMap(); //);
                // print(p.email);
                var response = await http.post(url, body: newPost.toMap());
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');

                print('req.body is $rating and ${newPost.rATE}');

                // todo: open the app's page on Google Play / Apple App Store
              },
              onAlternativePressed: () {
                print("onAlternativePressed: do something");
                // todo: maybe you want the user to contact you instead of rating a bad review
              },
            );
          });
    }

    // todo: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text("Dialog"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
              onPressed: () {
                _ackAlert(context);
              },
              child: const Text("Ack Dialog"),
            ),
            new RaisedButton(
              onPressed: () async {
                final ConfirmAction action = await _asyncConfirmDialog(context);
                print("Confirm Action $action");
              },
              child: const Text("Confirm Dialog"),
            ),
            new RaisedButton(
              onPressed: () async {
                final Departments deptName = await _asyncSimpleDialog(context);
                print("Selected Departement is $deptName");
              },
              child: const Text("Simple dialog"),
            ),
            new RaisedButton(
              onPressed: ()  {
                _showRatingDialog();
                // final String currentTeam = await _asyncInputDialog(context);
                // print("Current team name is $currentTeam");
              },
              child: const Text("Input Dialog"),
            ),
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(new MaterialApp(home: new MyApp()));
// }
