
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:school/ScreenUtil.dart';

import 'package:school/db/utility_basics.dart';
import 'package:school/main.dart';




var utilitybasic = Utility_Basic();

class NotificationBoard extends StatefulWidget {
  @override
  NotificationBoardReg createState() {
    return new NotificationBoardReg();
  }
}

class NotificationBoardReg extends State<NotificationBoard> {
  TextEditingController titleC = new TextEditingController();
  TextEditingController messageC = new TextEditingController();
  TextEditingController byC = new TextEditingController();
  TextEditingController dateCC = new TextEditingController();
  var todayDate;


  @override
  void initState() { 
    super.initState();
dateCheck();    
  }
  dateCheck() async {
    var now1 = DateTime.now();
    todayDate = DateFormat("dd\/MM\/yyyy").format(now1);
    setState(() {
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "NoticeBoard",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: ScreenUtil().setSp(60)),
        ),
      ),
      body: Container(
        color: appcolor,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              /* Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Add Class & Sections",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(60)),
                ),
              ), */
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Text(
                          "Notice Board",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    /* Container(decoration: BoxDecoration()),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "From :",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: fromAcadYear,
                                decoration: InputDecoration(
                                  hintText: "dd/yyyy",
                                ),
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "To :",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: toAcadYear,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "dd/yyyy",
                                ),
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ), */
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Title",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 20),
                            ))),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            border: new Border.all(
                                style: BorderStyle.solid,
                                color: Colors.black45),
                            borderRadius: BorderRadius.circular(5)),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: TextField(
                              controller: titleC,
                              keyboardType: TextInputType.multiline,
                              maxLength: 2,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(8.0),
                                  hintText: "Enter Title"),
                              style: TextStyle(fontSize: 20, height: 1.5),
                            )),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Description",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 20),
                            ))),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            border: new Border.all(
                                style: BorderStyle.solid,
                                color: Colors.black45),
                            borderRadius: BorderRadius.circular(5)),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: TextField(
                              controller: messageC,
                              keyboardType: TextInputType.multiline,
                              maxLength: 2,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(8.0),
                                  hintText: "Enter Description"),
                              style: TextStyle(fontSize: 20, height: 1.5),
                            )),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Announced By",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 20),
                            ))),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            border: new Border.all(
                                style: BorderStyle.solid,
                                color: Colors.black45),
                            borderRadius: BorderRadius.circular(5)),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: TextField(
                              controller: byC,
                              keyboardType: TextInputType.multiline,
                              maxLength: 2,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(8.0),
                                  hintText: "By NAme"),
                              style: TextStyle(fontSize: 20, height: 1.5),
                            )),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Date",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 20),
                            ))),
                            
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            border: new Border.all(
                                style: BorderStyle.solid,
                                color: Colors.black45),
                            borderRadius: BorderRadius.circular(5)),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text("$todayDate",  style: TextStyle(fontSize: 20),)),
                      ),
                    ),
                    /* Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Title",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                  // controller: fromAcadYear,
                                  keyboardType: TextInputType.multiline,
                                  style: TextStyle(fontSize: 18),
                                  
                                  ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Description",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                  // controller: toAcadYear,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  style: TextStyle(fontSize: 18),
                                  
                                  ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Announced By: ",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                  // controller: toAcadYear,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  style: TextStyle(fontSize: 18),
                                  
                                  ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Date: ",
                                style: TextStyle(fontSize: 20),
                              )),
                          Expanded(
                              flex: 1,
                              child: Text("$todayDate"))
                        ],
                      ),
                    ), */
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: ButtonTheme(
                              minWidth: ScreenUtil().setWidth(400),
                              height: ScreenUtil().setHeight(130),
                              child: RaisedButton(
                                onPressed: () async {
                                  titleC.clear();
                                  messageC.clear();
                                  byC.clear();
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                color: appcolor,
                                child: Text(
                                  "  CANCEL  ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(50)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: ButtonTheme(
                              minWidth: ScreenUtil().setWidth(400),
                              height: ScreenUtil().setHeight(130),
                              child: RaisedButton(
                                onPressed: () async {
                                  titleC.clear();
                                  messageC.clear();
                                  byC.clear();
                                  
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                color: appcolor,
                                child: Text(
                                  "  Send  ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(50)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ButtonTheme(
                        minWidth: ScreenUtil().setWidth(400),
                        height: ScreenUtil().setHeight(130),
                        child: RaisedButton(
                          onPressed: () async {
                            Dialog errorDialog = Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0 *
                                          MediaQuery.of(context)
                                              .devicePixelRatio))),
                              child: Container(
                                height: 150.0,
                                color: appcolor,
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                
                                  children: <Widget>[
                                  Text("Academic Year",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20, color: Colors.white)),
                                  Text("$academicLabel",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20, color: Colors.white)),
                                ]),
                              ),
                            );
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) => errorDialog,
                              barrierDismissible: false,
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          color: appcolor,
                          child: Text(
                            "  View  ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(50)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
