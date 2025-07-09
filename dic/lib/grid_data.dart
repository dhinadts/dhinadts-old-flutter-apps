

import 'package:flutter/material.dart';

import 'ScreenUtil.dart';

class Grid_design extends StatefulWidget {
  String title;
  String image;

  Grid_design({Key key, @required this.title,this.image}) : super(key: key);


  @override
  Grid_designState createState() {
    return new Grid_designState();
  }
}

class Grid_designState extends State<Grid_design> {
  LinearGradient rr;

  Grid_designState();



  @override
  Widget build(BuildContext context) {


    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            '${widget.image}',
            height: ScreenUtil().setHeight(120),
            width: ScreenUtil().setWidth(120),
          ),
          SizedBox(
            child: Text(
              '${widget.title}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );

  }

  @override
  void initState() {
    super.initState();

  }



}
