import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/library_provider.dart';
import '../providers/profile_provider.dart';
import '../widgets/content_card.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final me = context.watch<ProfileProvider>().active!;
    final lib = context.watch<LibraryProvider>();
    final items = lib.forRole(me.role).where((c) => lib.isBookmarked(c.id)).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('محفوظ شدہ')),
      body: items.isEmpty
          ? const Center(child: Text('ابھی کچھ محفوظ نہیں کیا'))
          : ListView(children: [for (final i in items) ContentCard(item: i)]),
    );
  }
}
