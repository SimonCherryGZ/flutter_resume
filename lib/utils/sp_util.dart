import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  static SpUtil? _instance;

  static Future<SpUtil> get instance async {
    return await getInstance();
  }

  SharedPreferences? _spf;

  SpUtil._();

  Future _init() async {
    _spf = await SharedPreferences.getInstance();
  }

  static Completer<void>? _completer;

  static Future<SpUtil> getInstance() async {
    if (_completer != null) {
      await _completer?.future;
    }
    _completer = Completer();
    try {
      if (_instance == null) {
        SpUtil instance = SpUtil._();
        await instance._init();
        _instance = instance;
      }
    } finally {
      _completer?.complete();
      _completer = null;
    }
    return _instance!;
  }

  bool _beforeCheck() {
    if (_spf == null) {
      return true;
    }
    return false;
  }

  bool hasKey(String key) {
    Set? keys = getKeys();
    return keys?.contains(key) ?? false;
  }

  Set<String>? getKeys() {
    if (_beforeCheck()) return null;
    return _spf!.getKeys();
  }

  get(String key) {
    if (_beforeCheck()) return null;
    return _spf!.get(key);
  }

  getString(String key) {
    if (_beforeCheck()) return null;
    return _spf!.getString(key);
  }

  Future<bool>? putString(String key, String value) {
    if (_beforeCheck()) return null;
    return _spf!.setString(key, value);
  }

  bool? getBool(String key) {
    if (_beforeCheck()) return null;
    return _spf!.getBool(key);
  }

  Future<bool>? putBool(String key, bool value) {
    if (_beforeCheck()) return null;
    return _spf!.setBool(key, value);
  }

  int? getInt(String key) {
    if (_beforeCheck()) return null;
    return _spf!.getInt(key);
  }

  Future<bool>? putInt(String key, int value) {
    if (_beforeCheck()) return null;
    return _spf!.setInt(key, value);
  }

  double? getDouble(String key) {
    if (_beforeCheck()) return null;
    return _spf!.getDouble(key);
  }

  Future<bool>? putDouble(String key, double value) {
    if (_beforeCheck()) return null;
    return _spf!.setDouble(key, value);
  }

  List<String>? getStringList(String key) {
    return _spf!.getStringList(key);
  }

  Future<bool>? putStringList(String key, List<String> value) {
    if (_beforeCheck()) return null;
    return _spf!.setStringList(key, value);
  }

  dynamic getDynamic(String key) {
    if (_beforeCheck()) return null;
    return _spf!.get(key);
  }

  Future<bool>? remove(String key) {
    if (_beforeCheck()) return null;
    return _spf!.remove(key);
  }

  Future<bool>? clear() {
    if (_beforeCheck()) return null;
    return _spf!.clear();
  }
}
