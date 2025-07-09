import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ScreenUtil.dart';


class EvaluateHomework extends StatefulWidget {
  @override
  EvaluateHomeworkDetails createState() {
    return new EvaluateHomeworkDetails();
  }
}

class EvaluateHomeworkDetails extends State<EvaluateHomework> {
  String isClassradio = "";
  int ict = 0;
  File _imageFile;
  bool _isUploading = false;

  String baseUrl =
      'http://13.127.33.107//upload/dhanraj/homework/api/file_upload.php';

  var listtt = new List();
  ScrollController _scrollController = new ScrollController();


  @override
  Widget build(BuildContext context) {
    ScrollController _scrollViewController;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Evaluation of Homework",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: ScreenUtil().setSp(50)),
        ),
      ),
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Class",
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.grey)),
                      ),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Section",
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.grey)),
                      ),
                    ),
                  )),
                ],
              ),
              Text("Subject",
                  style: TextStyle(
                      color: Colors.black, fontSize: ScreenUtil().setSp(40))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Description / Comments",
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.grey)),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: listtt.length != 0
                          ? ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.all(0.5),
                        itemCount: listtt.length,
                        itemBuilder: (context, index) {
                          if (index == listtt.length) {
                            return Center(
                                child: Text(
                                  "No data",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ));
                          } else {
                            return GestureDetector(
                              onTap: () async {

                              },
                              child: Card(
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(
                                        listtt[index]["profile"],
                                        height: ScreenUtil().setHeight(200),
                                        width: ScreenUtil().setWidth(200),
                                      ),
                                    ),
                                    Expanded(
                                        child: Text('${listtt[index]["view_txt"]}')),
                                    Column(
                                      children: <Widget>[
                                        RaisedButton(
                                          onPressed: () async {},
                                          color: Color(0xFF3AE37A),
                                          child: Text(
                                            "  Edit  ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: ScreenUtil().setSp(25)),
                                          ),
                                        ),

                                        RaisedButton(
                                          onPressed: () async {},
                                          color: Color(0xFFFB509B),
                                          child: Text(
                                            "  View  ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: ScreenUtil().setSp(25)),
                                          ),
                                        ),
                                        //Text("Edit"),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      )
                          : Center(
                          child: Text("No Students Founds",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold))),
                    ),
                  ],
                ),
              ),
              _buildUploadBtn(),
            ],
          ),
        ),
      ),
    );
  }




  Widget _buildUploadBtn() {
    Widget btnWidget = Container();

      btnWidget = Container(
        margin: EdgeInsets.only(top: 10.0),
        child: FlatButton(
          child: Text('Save To Student Report Page'),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          onPressed: () {

          },
          color: Color(0xFFDFFAE8),
          textColor: Color(0xFF24C38A),
        ),
      );

    return btnWidget;
  }
}
