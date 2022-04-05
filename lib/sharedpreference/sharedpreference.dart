import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceClass {
  static dynamic getString(key) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String? _res = prefs.getString("$key");

    return _res;
  }

  static dynamic putString(key, val) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var _res = prefs.setString("$key", val);
    return _res;
  }

  static dynamic deleteString(key) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var _res = prefs.remove("$key");
    return _res;
  }
}
