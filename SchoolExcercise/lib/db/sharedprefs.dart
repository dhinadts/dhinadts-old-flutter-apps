import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceS {
  Future setString(String key, String string) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, string);
  }

  Future setint(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  Future setBool(String key, bool boolValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, boolValue);
  }

  Future getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey(key);
    if (checkValue == null) {
      prefs.setString(key, "");
    }
    return prefs.getString(key);
  }

  Future getInt(String key, [double dummy]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey(key);
    if (checkValue == false) {
      await prefs.setInt(key, 0);
    }
    return  prefs.getInt(key);
  }

  Future getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey(key);
    if (checkValue == false) {
      prefs.setBool(key, false);
    }
    return prefs.getBool(key);
  }


 Future setdouble(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }


  // Future setdouble(String key, double value) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setDouble(key, value);
  // }

  Future getDouble(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey(key);
    if (checkValue == false) {
      await prefs.setDouble(key, 0.0);
    }
    return  prefs.getDouble(key);
  }
}
//   Future getdouble(String key, double fontSize11) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool checkValue = prefs.containsKey(key);
//     if (checkValue == false) {
//       await prefs.setDouble(key, 0);
//     }
//     return await prefs.getDouble(key);
//   }
// }
