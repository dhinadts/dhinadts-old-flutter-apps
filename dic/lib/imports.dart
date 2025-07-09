export 'dart:async';
export 'dart:core';
export 'dart:io';
export 'dart:math';
export 'dart:convert';
export 'package:flutter/material.dart';
export 'package:flutter/painting.dart';
export 'package:flutter/services.dart';
export 'package:gradient_widgets/gradient_widgets.dart';
//export 'package:admob_flutter/admob_flutter.dart';
export 'package:percent_indicator/linear_percent_indicator.dart';
export 'package:progress_dialog/progress_dialog.dart';
export 'package:quiver/async.dart';
export 'package:share/share.dart';
export 'package:sqflite/sqflite.dart';
export 'package:connectivity/connectivity.dart';
export 'package:device_info/device_info.dart';
export 'package:fluttertoast/fluttertoast.dart';
export 'package:launch_review/launch_review.dart';
export 'package:package_info/package_info.dart';
export 'package:url_launcher/url_launcher.dart';
export 'package:shared_preferences/shared_preferences.dart';
//export 'package:firebase_admob/firebase_admob.dart';


export 'db/dbhelp.dart';
export 'db/sharedprefs.dart';
export 'all_dialog.dart';
export 'utility/mycolors.dart';
export 'feedback_ex.dart';
export 'privacy_link.dart';
export 'ScreenUtil.dart';
export 'main.dart';
export 'db/utility_basics.dart';
export 'utility/mycolors.dart';


//global declaration
import 'db/dbhelp.dart';
import 'db/sharedprefs.dart';
import 'db/utility_basics.dart';

var databaseHelper = DatabaseHelper();
var shared_preference = Shared_Preference();
var utility_basic = Utility_Basic();
var feedback_url = 'https://www.nithra.mobi/apps/appfeedback.php';
var fcm_reg_url = 'https://www.nithra.mobi/appgcm/gcmiostamilquiz/register.php';

//test
//String viewer_ins_ad='ca-app-pub-3940256099942544/1033173712';
//String main_ins_ad='ca-app-pub-3940256099942544/1033173712';
String appId = "ca-app-pub-4267540560263635~5808818549";


String viewer_ins_ad='ca-app-pub-4267540560263635/7257631587';
String main_ins_ad='ca-app-pub-4267540560263635/4625946425';
String Banneradid = "ca-app-pub-4267540560263635/3504436442";

