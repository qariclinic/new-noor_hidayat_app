import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/profile.dart';
import '../models/user_role.dart';
import '../services/storage_service.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider(this._s);
  final StorageService _s;

  List<Profile> profiles = [];
  String? activeId;
  String? parentPin;
  bool loaded = false;

  Profile? get active => profiles.where((p) => p.id == activeId).firstOrNull;

  void load() {
    final raw = _s.getString('profiles');
    if (raw != null) {
      profiles = (jsonDecode(raw) as List)
          .map((e) => Profile.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    activeId = _s.getString('activeId');
    parentPin = _s.getString('parentPin');
    loaded = true;
    notifyListeners();
  }

  Future<void> _save() async {
    await _s.setString('profiles', jsonEncode(profiles.map((e) => e.toJson()).toList()));
    if (activeId != null) await _s.setString('activeId', activeId!);
  }

  Future<void> addProfile(String name, UserRole role) async {
    final p = Profile(id: DateTime.now().millisecondsSinceEpoch.toString(), name: name, role: role);
    profiles.add(p);
    activeId = p.id;
    await _save();
    notifyListeners();
  }

  Future<void> switchTo(String id) async {
    activeId = id;
    await _save();
    notifyListeners();
  }

  Future<void> setParentPin(String pin) async {
    parentPin = pin;
    await _s.setString('parentPin', pin);
    notifyListeners();
  }

  bool verifyPin(String pin) => pin == parentPin;
}
