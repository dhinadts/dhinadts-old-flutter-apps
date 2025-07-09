import 'package:flutter/material.dart';
import 'package:school/ScreenUtil.dart';
import 'package:school/StaffNew/News.dart';

class GeneralItems extends StatefulWidget {
  GeneralItems({Key key}) : super(key: key);

  @override
  _GeneralItemsState createState() => _GeneralItemsState();
}

class _GeneralItemsState extends State<GeneralItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("General")),
        body: SafeArea(
            child: Column(
              children: <Widget>[
                Row(
          children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => News()),
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
                              "News",
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
                      MaterialPageRoute(builder: (context) => Events()),
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
                              "Events",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
          ],
        ),
        Row(
          children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Gallaery()),
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
                              "Gallaery",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox()
          ],
        ),
              ],
            )
        ));
  }
}
