import 'package:shared_preferences/shared_preferences.dart'; 

export 'cache_constants.dart';

class CacheService {
  Future<String?> getString(String key) async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  Future<void> setString(String key, String value) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setString(key, value);
  }

  Future<bool?> getBool(String key) async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool(key);
  }

  Future<void> setBool(String key, bool value) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setBool(key, value);
  }

  Future<int?> getInt(String key) async {
    var pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }

  Future<void> setInt(String key, int value) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setInt(key, value);
  }

  Future<double?> getDouble(String key) async {
    var pref = await SharedPreferences.getInstance();
    return pref.getDouble(key);
  }

  Future<void> setDouble(String key, double value) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setDouble(key, value);
  }

  Future<void> remove(String key) async {
    var pref = await SharedPreferences.getInstance();
    await pref.remove(key);
  }

  Future<void> clear() async {
    var pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}

final cacheService = CacheService();
