import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utilities/get_it.dart';
import 'localization/app_localization.dart';

class PrefKeys {
  static const String LANGCODE = 'lang_code';
  static const String USER = 'User';
  static const String FCM = 'Fcm';
  static const String CARTGUESTKEY = 'CARTGUESTKEY';
  static const String LOGINEDCARTGUESTKEY = 'LOGINEDCARTGUESTKEY';
}

class Prefrence {
  static SharedPreferences? _sb;
  static init() async {
    if (_sb == null) _sb = await SharedPreferences.getInstance();
  }

  static Future<String?> getString(String key) async {
    try {
      return _sb!.getString(key);
    } catch (e) {
      debugPrint(e.toString() + 'eeeeeeeeeee');
      return null;
    }
  }

  static Future<String>? getLanguageCode() async {
    try {
      await init();
      var x = _sb!.getString(PrefKeys.LANGCODE);
      debugPrint('***************************************');
      debugPrint('Lang from pref $x');
      debugPrint('***************************************');
      if (x == null) {
        locator<LocalizationProvider>().setLocal('en');
      } else {
        locator<LocalizationProvider>().setLocal(x);
      }
      return x!;
    } catch (e) {
      debugPrint(e.toString() + 'eeeeeeeeeee');
      return null!;
    }
  }

  static Future<int?> getInt(String key) async {
    try {
      return _sb!.getInt(key);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> getBool(String key) async {
    try {
      return _sb!.getBool(key);
    } catch (e) {
     // debugPrint(e);
      return null;
    }
  }

  static Future<bool?> setString(String key, String value) async {
    try {
      await init();
      return _sb!.setString(key, value);
    } catch (e) {
     //debugPrint(e);
      return null;
    }
  }

  static Future<bool?> setInt(String key, int value) async {
    try {
      return _sb!.setInt(key, value);
    } catch (e) {
     // debugPrint();
      return null;
    }
  }

  static Future<bool?> setBool(String key, bool value) async {
    try {
      return await _sb!.setBool(key, value);
    } catch (e) {
      //debugPrint(e);
      return null;
    }
  }

  static Future<bool?> remove(String key) async {
    try {
      return await _sb!.remove(key);
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> clear() async {
    try {
      return await _sb!.clear();
    } catch (e) {
      return null;
    }
  }
}
