// import 'dart:core';
// import 'dart:io';

// import 'package:flutter/services.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:dhina/db/sharedpref.dart';
// import 'package:dhina/utility/utility_basic.dart';
// import 'package:dhina/model/Getter_setter.dart';

// class DatabaseHelper {
//   static final tamil_quiz = 'tamil_quiz';

//   var databasesPath;
//   var path;
//   var utility_basic = Utility_Basic();
//   var shared_preference = Shared_Preference();

//   /*Future<Database> get database async {
//     if (_database != null) return _database;
//     // lazily instantiate the db the first time it is accessed
//       _database = await _initDatabase();

//     return _database;
//   }*/

//   db_move() async {
//     var sp = await shared_preference.getInt("db_move");

//     print("spp  $sp" );

//     if(await shared_preference.getInt("db_move")==0){
//       databasesPath = await getDatabasesPath();
//       path = join(databasesPath, "modi_kural_comp.db");

//       try {
//         await Directory(dirname(path)).create(recursive: true);
//         ByteData data = await rootBundle.load(join("assets", "modi_kural_comp.db"));
//         List<int> bytes =
//             data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

//         // Write and flush the bytes written
//         await File(path).writeAsBytes(bytes, flush: true);

//         var db = await openDatabase(path);
//         utility_basic.toastfun("db_moved");
//         await shared_preference.setint("db_move", 1);

//         print(await shared_preference.getInt("db_move"));
//       } catch (Exception) {
//         utility_basic.toastfun('Db failed ' + Exception.toString());
//       }
//     }
//   }

//   // this opens the database and create if not exist
//   _initDatabase(String dbName) async {
//     databasesPath = await getDatabasesPath();
//     path = join(databasesPath, dbName);

//     return await openDatabase(path, version: 1);
//   }

//   // open db any database
//   opendb(String dbName) async {
//     databasesPath = await getDatabasesPath();
//     path = join(databasesPath, "$dbName");
//     return await openDatabase(path, version: 1);
//   }

//   // create  any database
//   create_db(String dbName) async {
//     var db = await _initDatabase(dbName);
//   }

// //create table
//   Future create_table(String tableName, String query, String dbName) async {
//     var db = await _initDatabase(dbName);

//     await db.execute('''CREATE TABLE $tableName ($query)''');
//   }

//   //getdata

//  /* Future<List<Getter_setter>> get_list(String query, String db_name) async {
//     var db = await _initDatabase(db_name);
//     List<Map> list = await db.rawQuery(query);
//     var data = list.length;
//     print("data count " + data.toString());
//     print("data category " + list[0]['category']);
//     List<Getter_setter> list_values = new List();
//     int len = list.length - 1;
//     for (int i = 0; i <= len; i++) {
//       Getter_setter values = new Getter_setter();
//       values.id = list[i]['id'];
//       values.cat_id = list[i]['cat_id'];
//       values.category = list[i]['category'];
//       values.question = list[i]['question'];
//       print("data question " + list[i]['question']);
//       values.option1 = list[i]['option1'];
//       values.option2 = list[i]['option2'];
//       values.option3 = list[i]['option3'];
//       values.option4 = list[i]['option4'];
//       values.answer = list[i]['answer'];
//       values.ans_pos = list[i]['ans_pos'];
//       values.checking = list[i]['checking'];
//       list_values.add(values);
//     }
//     return list_values;
//   }*/

//   any_query(String query, String dbName) async {
//     var db = await _initDatabase(dbName);
//    return db.rawQuery(query);
//   }

//   close_db(String dbName) async {
//     var db = await _initDatabase(dbName);
//    return await db.close();
//   }



// /*  Future<int> getCount(String query, String db_name) async {
//     //database connection
//     var db = await _initDatabase(db_name);
//     var x = await db.rawQuery(query);
//         int count = Sqflite.firstIntValue(x);
//     return count;
//   }*/


// }
