import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_role.dart';
import '../providers/library_provider.dart';
import '../providers/profile_provider.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final me = context.watch<ProfileProvider>().active!;
    final lib = context.watch<LibraryProvider>();
    final pct = lib.percent(me.role);
    final done = lib.forRole(me.role).where((c) => lib.isDone(c.id)).length;
    return Scaffold(
      appBar: AppBar(title: const Text('میری پیش رفت')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text('ماڈیول مکمل: ${(pct * 100).round()}٪', style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: pct, minHeight: 12),
          const SizedBox(height: 24),
          if (me.role == UserRole.child)
            Wrap(children: [
              for (var i = 0; i < done; i++) const Icon(Icons.star, color: Colors.amber, size: 40),
              if (done == 0) const Text('پہلا سبق مکمل کریں اور ستارہ پائیں!'),
            ])
          else
            Text('مسلسل پڑھنے کے دن: ${lib.streak}', style: const TextStyle(fontSize: 18)),
        ]),
      ),
    );
  }
}
