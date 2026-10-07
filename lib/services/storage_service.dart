import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService._(this._p);
  final SharedPreferences _p;

  static Future<StorageService> create() async =>
      StorageService._(await SharedPreferences.getInstance());

  String? getString(String k) => _p.getString(k);
  Future<void> setString(String k, String v) => _p.setString(k, v);
  int getInt(String k) => _p.getInt(k) ?? 0;
  Future<void> setInt(String k, int v) => _p.setInt(k, v);
  Set<String> getSet(String k) => (_p.getStringList(k) ?? []).toSet();
  Future<void> setSet(String k, Set<String> v) => _p.setStringList(k, v.toList());
}
