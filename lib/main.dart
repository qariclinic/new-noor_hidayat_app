import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'providers/library_provider.dart';
import 'providers/profile_provider.dart';
import 'services/storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await StorageService.create();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileProvider(storage)..load()),
        ChangeNotifierProxyProvider<ProfileProvider, LibraryProvider>(
          create: (_) => LibraryProvider(storage)..load(),
          update: (_, profiles, lib) => lib!..bindProfile(profiles.active?.id),
        ),
      ],
      child: const NoorApp(),
    ),
  );
}
