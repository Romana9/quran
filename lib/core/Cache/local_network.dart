import 'package:shared_preferences/shared_preferences.dart';

class CacheNetwork {
  static late SharedPreferences sharedPreferences;
  static Future cacheInitilzation() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> insertToCache(
      {required String key, required String value}) async {
    return await sharedPreferences.setString(key, value);
  }

  static String getCacheData({required String key}) {
    return sharedPreferences.getString(key) ?? "";
  }

  static Future<bool> deleteCacheData({required String key}) {
    return sharedPreferences.remove(key);
  }

  static Future<bool> update({required String key, required String newValue}) {
    return sharedPreferences.setString(key, newValue);
  }
}
