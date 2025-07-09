import 'dart:math';
import 'package:flutter/material.dart';

class AddMarks extends StatefulWidget {
  AddMarks({Key key}) : super(key: key);

  @override
  _AddMarksState createState() => _AddMarksState();
}

class _AddMarksState extends State<AddMarks> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(),
    );
  }
}



class ShakeCurve extends Curve {
  @override
  double transform(double t) => sin(t * pi * 2);
}