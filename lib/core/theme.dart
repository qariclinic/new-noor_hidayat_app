import 'package:flutter/material.dart';
import '../models/user_role.dart';

ThemeData themeFor(UserRole? role) {
  final seed = switch (role) {
    UserRole.child => const Color(0xFFFF9800),
    UserRole.woman => const Color(0xFF8E24AA),
    UserRole.man => const Color(0xFF00695C),
    null => const Color(0xFF00695C),
  };
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: seed),
    // fontFamily: 'NotoNastaliq',  // فونٹ شامل کرنے کے بعد کھولیں
  );
}
