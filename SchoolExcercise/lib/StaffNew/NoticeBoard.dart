import 'package:flutter/material.dart';
import 'package:school/ScreenUtil.dart';
import 'package:school/StaffNew/AddNoticeBoard.dart';
import 'package:school/StaffNew/ViewNoticeBoard.dart';

class NoticeBoardItems extends StatefulWidget {
  NoticeBoardItems({Key key}) : super(key: key);

  @override
  _NoticeBoardItemsState createState() => _NoticeBoardItemsState();
}

class _NoticeBoardItemsState extends State<NoticeBoardItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Notice Board")),
        body: SafeArea(
            child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNoticeBoard()),
                );
              },
              child: SizedBox(
                height: ScreenUtil().setHeight(450),
                width: ScreenUtil().setWidth(500),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Color(0xFFFFBA31),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/vuas.png",
                            height: ScreenUtil().setHeight(170),
                            width: ScreenUtil().setWidth(170),
                          ),
                        ),
                        Text(
                          "Add NoticeBoard",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewNoticeBoard()),
                );
              },
              child: SizedBox(
                height: ScreenUtil().setHeight(450),
                width: ScreenUtil().setWidth(500),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Color(0xFFFFBA31),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/vuas.png",
                            height: ScreenUtil().setHeight(170),
                            width: ScreenUtil().setWidth(170),
                          ),
                        ),
                        Text(
                          "View Notice Board",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}