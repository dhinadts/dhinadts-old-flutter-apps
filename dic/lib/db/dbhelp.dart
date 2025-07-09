import 'package:path/path.dart';
import 'package:dictionary/imports.dart';

class DatabaseHelper {
  // static final tamil_quiz = 'tamil_quiz';

  var databasesPath;
  var path;
  var utilityBasic = Utility_Basic();
  var prefs = Shared_Preference();

  /*Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
      _database = await _initDatabase();

    return _database;
  }*/

  dbMove() async {
    databasesPath = await getDatabasesPath();
    path = join(databasesPath, "dic_new.db");

    try {
      await Directory(dirname(path)).create(recursive: true);
      ByteData data =
          await rootBundle.load(join("assets", "dic_new.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

      // var db =
      await openDatabase(path);
      utilityBasic.toastfun("Play Now..");

      await prefs.setint("dbMove", 1);

      print(await prefs.getInt("dbMove"));
    } catch (Exception) {
      utilityBasic.toastfun('Db failed ' + Exception.toString());
    }
  }

  // this opens the database and create if not exist
  _initDatabase(String dbName) async {
    databasesPath = await getDatabasesPath();
    path = join(databasesPath, dbName);

    return await openDatabase(path, version: 1);
  }

  // open db any database
  opendb(String dbName) async {
    databasesPath = await getDatabasesPath();
    path = join(databasesPath, "$dbName");
    return await openDatabase(path, version: 1);
  }

  // create  any database
  createDB(String dbName) async {
    //var db =
    await _initDatabase(dbName);
  }

//create table
  Future createTable(String tableName, String query, String dbName) async {
    var db = await _initDatabase(dbName);

    await db.execute('''CREATE TABLE $tableName ($query)''');
  }

  //getdata

  /* Future<List<Getter_setter>> get_list(String query, String db_name) async {
    var db = await _initDatabase(db_name);
    List<Map> list = await db.rawQuery(query);
    var data = list.length;
    print("data count " + data.toString());
    print("data category " + list[0]['category']);
    List<Getter_setter> list_values = new List();
    int len = list.length - 1;
    for (int i = 0; i <= len; i++) {
      Getter_setter values = new Getter_setter();
      values.id = list[i]['id'];
      values.cat_id = list[i]['cat_id'];
      values.category = list[i]['category'];
      values.question = list[i]['question'];
      print("data question " + list[i]['question']);
      values.option1 = list[i]['option1'];
      values.option2 = list[i]['option2'];
      values.option3 = list[i]['option3'];
      values.option4 = list[i]['option4'];
      values.answer = list[i]['answer'];
      values.ans_pos = list[i]['ans_pos'];
      values.checking = list[i]['checking'];
      list_values.add(values);
    }
    return list_values;
  }*/

  anyQuery(String query, String dbName) async {
    var db = await _initDatabase(dbName);
    return db.rawQuery(query);
  }

  closeDb(String dbName) async {
    var db = await _initDatabase(dbName);
    return await db.close();
  }

/*  Future<int> getCount(String query, String db_name) async {
    //database connection
    var db = await _initDatabase(db_name);
    var x = await db.rawQuery(query);
        int count = Sqflite.firstIntValue(x);
    return count;
  }*/

}

// _showBusy() {
//   return showDialog(
//       context: null,
//       barrierDismissible: true,
//       builder: (context) {
//         // prefix0.num _value;
//         return new CircularProgressIndicator(
//           valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
//         );
//       });

// }
