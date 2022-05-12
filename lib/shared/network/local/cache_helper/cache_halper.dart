import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences shared;

  static init() async {
    shared = await SharedPreferences.getInstance();
  }

// here get and put bool
  static Future<bool> putBoolData({
    required String key,
    required bool? value,
  }) async {
    return await shared.setBool(key, value!);
  }

  static getBoolData({
    required String key,
  }) {
    return shared.getBool(key);
  }

// here get and put string

  static Future<bool> putStringData({
    required String key,
    required String? value,
  }) async {
    return await shared.setString(key, value!);
  }

  static getStringData({
    required String key,
  }) {
    return shared.getString(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await shared.remove(key);
  }
}
