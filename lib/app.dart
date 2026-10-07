import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme.dart';
import 'providers/profile_provider.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen.dart';

class NoorApp extends StatelessWidget {
  const NoorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final profiles = context.watch<ProfileProvider>();
    return MaterialApp(
      title: 'نورِ ہدایت',
      debugShowCheckedModeBanner: false,
      theme: themeFor(profiles.active?.role),
      locale: const Locale('ur'),
      builder: (context, child) =>
          Directionality(textDirection: TextDirection.rtl, child: child!),
      home: !profiles.loaded
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : profiles.active == null
              ? const OnboardingScreen()
              : const HomeScreen(),
    );
  }
}
