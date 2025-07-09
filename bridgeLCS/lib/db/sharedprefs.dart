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
    return prefs.getInt(key);
  }
}
