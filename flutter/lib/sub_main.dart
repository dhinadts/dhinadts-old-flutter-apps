import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
 
class Post {
  final String email;
  final String comments;
 
  Post({ this.email, this.comments});
 
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      // userId: json['userId'],
      // id: json['id'],
      email: json['email'],
      comments: json['comments'],
    );
  }
 
  Map toMap() {
    var map = new Map<String, dynamic>();
    
    map["email"] = email;
    map["comments"] = comments;
 
    return map;
  }
}
 
Future<Post> createPost(String url, {Map body}) async {
  return http.post(url, body: body ).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Post.fromJson(json.decode(response.body));
  });
}
 
class MyApp1 extends StatelessWidget {
  final Future<Post> post;
 
  MyApp1({Key key, this.post}) : super(key: key);
  static final CREATE_POST_URL = "http://localhost:3000/addfeedback";
  TextEditingController emailControler = new TextEditingController();
  TextEditingController commentsControler = new TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: "WEB SERVICE",
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Create Post'),
          ),
          body: new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new Column(
              children: <Widget>[
                new TextField(
                  controller: emailControler,
                  decoration: InputDecoration(
                      hintText: "email....", labelText: 'Post Title'),
                ),
                new TextField(
                  controller: commentsControler,
                  decoration: InputDecoration(
                      hintText: "comments....", labelText: 'Post Body'),
                ),
                new RaisedButton(
                  onPressed: () async {
// http.Response response = await http.post(CREATE_POST_URL, headers: {
//     "Accept": "application/json",
//     // "Accesstoken": "Bearer $access_token"
//   }, body:  {'email': emailControler.text ,'comments': commentsControler.text});
//   print("Result: ${response.body}");
//   return json.decode(response.body);
                    Post newPost = new Post(
                        email: emailControler.text, comments: commentsControler.text);
                    Post p = await createPost(CREATE_POST_URL,
                        body: newPost.toMap());
                    print(p.comments);
                 },
                  child: const Text("Create"),
                )
              ],
            ),
          )),
    );
  }
}
 
void main() => runApp(MyApp1());