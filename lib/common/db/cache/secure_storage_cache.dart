import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'cache.dart';

final class SecureStorageCache extends Cache {
  late FlutterSecureStorage _storage;
  Map<String, String> _temp = {};

  @override
  Future<void> init() async {
    _storage = const FlutterSecureStorage();
    _temp = await _storage.readAll();
  }

  @override
  Future<void> clear() async {
    await _storage.deleteAll();
    await init();
  }

  @override
  bool? getBool(String key) {
    if (_temp[key] == 'true') {
      return true;
    }
    if (_temp[key] == 'false') {
      return false;
    }
    return null;
  }

  @override
  double? getDouble(String key) {
    try {
      return double.parse(_temp['key']!);
    } catch (_) {}
    return null;
  }

  @override
  int? getInt(String key) {
    try {
      return int.parse(_temp[key]!);
    } catch (_) {}
    return null;
  }

  @override
  Map<String, dynamic>? getMap(String key) {
    try {
      String value = _temp[key]!;
      Map<String, dynamic> map = jsonDecode(value);
      return map;
    } catch (_) {}
    return null;
  }

  @override
  String? getString(String key) {
    return _temp[key];
  }

  @override
  List<String>? getStringList(String key) {
    String value = _temp[key]!;
    List<dynamic> decoded = jsonDecode(value);
    List<String> list = List<String>.from(decoded);
    return list;
  }

  @override
  Future<void> remove(String key) async {
    await _storage.delete(key: key);
    _temp.remove(key);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    String v = value.toString();
    await _storage.write(key: key, value: v);
    _temp[key] = v;
  }

  @override
  Future<void> setDouble(String key, double value) async {
    String v = value.toString();
    await _storage.write(key: key, value: v);
    _temp[key] = v;
  }

  @override
  Future<void> setInt(String key, int value) async {
    String v = value.toString();
    await _storage.write(key: key, value: v);
    _temp[key] = v;
  }

  @override
  Future<void> setMap(String key, Map<String, dynamic> value) async {
    String v = jsonEncode(value);
    await _storage.write(key: key, value: v);
    _temp[key] = v;
  }

  @override
  Future<void> setString(String key, String value) async {
    await _storage.write(key: key, value: value);
    _temp[key] = value;
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    String v = jsonEncode(value);
    await _storage.write(key: key, value: v);
    _temp[key] = v;
  }
}
