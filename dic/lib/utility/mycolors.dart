import 'package:flutter/widgets.dart';
class MyColorGradients {
  static AlignmentGeometry _beginAlignment = Alignment.topLeft;
  static AlignmentGeometry _endAlignment = Alignment.bottomRight;

  static LinearGradient buildGradient(AlignmentGeometry begin, AlignmentGeometry end, List<Color> colors) =>
      LinearGradient(begin: begin, end: end, colors: colors);

  static const app_gradient = LinearGradient(
      colors: const [Color(0xFF2196F3), Color(0xFF40C4FF)], begin: Alignment.centerLeft, end: Alignment.centerRight);

  static LinearGradient coralCandyGradient =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xffD79838), Color(0xffFFB8C6)]);

 static LinearGradient orange =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xffFA480F), Color(0xffFAA347)]);
 static LinearGradient red =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xffFF0000), Color(0xffFADB3F)]);
 static LinearGradient green =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xff06ab2f), Color(0xffa8e063)]);
 static LinearGradient violet =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xff3160CB), Color(0xffA831CB)]);

 static LinearGradient orangecheckbox =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xffEF3133), Color(0xffFF7210)]);

static LinearGradient sea_blue =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xff2b5876), Color(0xff4e4376)]);

static LinearGradient blody_mary =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xffff512f), Color(0xffdd2476)]);

static LinearGradient cherry =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xffeb3349), Color(0xfff45c43)]);

static LinearGradient whitegradient =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xffCFDEF3), Color(0xffd1dffa)]);
static LinearGradient bluegradient =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xffb3b3cc), Color(0xffd1d1e0)]);

static LinearGradient black_white =
  buildGradient(_beginAlignment, _endAlignment, const [Color(0xff000000), Color(0xffFFFFFF)]);



}
