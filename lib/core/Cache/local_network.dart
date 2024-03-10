import 'dart:convert';

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

  static Future<bool> insertNumToCache(
      {required String key, required double value}) async {
    return await sharedPreferences.setDouble(key, value);
  }

  static String getCacheData({required String key}) {
    return sharedPreferences.getString(key) ?? "";
  }

  static double getNumCacheData({required String key}) {
    return sharedPreferences.getDouble(key) ?? 0;
  }

  static Future<bool> deleteCacheData({required String key}) {
    return sharedPreferences.remove(key);
  }

  static Future<bool> update({required String key, required String newValue}) {
    return sharedPreferences.setString(key, newValue);
  }

  static Future<bool> updateNum({required String key, required double newValue}) {
    return sharedPreferences.setDouble(key, newValue);
  }

  static Future<void> addMapToList(Map newData) async {
    // Retrieve existing data from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final jsonDataList = prefs.getStringList('dataList');

    List dataList = [];

    if (jsonDataList != null) {
      // Convert JSON strings to Map objects
      dataList = jsonDataList.map((jsonData) => jsonDecode(jsonData)).toList();
    }

    // Add the new map to the list
    dataList.add(newData);

    // Convert the list of maps back to JSON strings
    final updatedJsonDataList =
        dataList.map((data) => jsonEncode(data)).toList();

    // Save the updated list to SharedPreferences
    prefs.setStringList('dataList', updatedJsonDataList);
  }

  static Future<List> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonDataList = prefs.getStringList('dataList');

    if (jsonDataList == null) {
      return [];
    }

    return jsonDataList.map((jsonData) => jsonDecode(jsonData)).toList();
  }

  static Future<void> removeItemFromList(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonDataList = prefs.getStringList('dataList');

    List dataList = [];

    if (jsonDataList != null) {
      // Convert JSON strings to Map objects
      dataList = jsonDataList.map((jsonData) => jsonDecode(jsonData)).toList();
    }

    // Remove the item at the specified index
    dataList.removeWhere((item) => item['name'] == name);

    // Convert the list of maps back to JSON strings
    final updatedJsonDataList =
        dataList.map((data) => jsonEncode(data)).toList();

    // Save the updated list to SharedPreferences
    prefs.setStringList('dataList', updatedJsonDataList);
  }
}
