import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/content_item.dart';
import '../providers/library_provider.dart';
import '../screens/content_detail_screen.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({super.key, required this.item});
  final ContentItem item;

  @override
  Widget build(BuildContext context) {
    final lib = context.watch<LibraryProvider>();
    final icon = switch (item.mediaType) {
      'audio' => Icons.headphones,
      'video' => Icons.play_circle,
      _ => Icons.menu_book,
    };
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Icon(icon),
        title: Text(item.title),
        subtitle: Text(item.category),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          if (lib.isDone(item.id)) const Icon(Icons.check_circle, color: Colors.green),
          IconButton(
            icon: Icon(lib.isBookmarked(item.id) ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () => lib.toggleBookmark(item.id),
          ),
        ]),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ContentDetailScreen(item: item)),
        ),
      ),
    );
  }
}
