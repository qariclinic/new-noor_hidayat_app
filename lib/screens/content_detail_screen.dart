import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import '../models/content_item.dart';
import '../providers/library_provider.dart';

class ContentDetailScreen extends StatefulWidget {
  const ContentDetailScreen({super.key, required this.item});
  final ContentItem item;
  @override
  State<ContentDetailScreen> createState() => _ContentDetailScreenState();
}

class _ContentDetailScreenState extends State<ContentDetailScreen> {
  AudioPlayer? _player;

  @override
  void initState() {
    super.initState();
    final it = widget.item;
    if (it.mediaType == 'audio' && it.mediaUrl.isNotEmpty) {
      _player = AudioPlayer();
      (it.mediaUrl.startsWith('assets/')
              ? _player!.setAsset(it.mediaUrl)
              : _player!.setUrl(it.mediaUrl))
          .catchError((_) => null);
    }
  }

  @override
  void dispose() {
    _player?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lib = context.watch<LibraryProvider>();
    final it = widget.item;
    return Scaffold(
      appBar: AppBar(
        title: Text(it.title),
        actions: [
          IconButton(
            icon: Icon(lib.isBookmarked(it.id) ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () => lib.toggleBookmark(it.id),
          ),
        ],
      ),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Text(it.body, style: const TextStyle(fontSize: 22, height: 2)),
        if (_player != null)
          StreamBuilder<PlayerState>(
            stream: _player!.playerStateStream,
            builder: (_, snap) {
              final playing = snap.data?.playing ?? false;
              return IconButton(
                iconSize: 56,
                icon: Icon(playing ? Icons.pause_circle : Icons.play_circle),
                onPressed: () => playing ? _player!.pause() : _player!.play(),
              );
            },
          ),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: lib.isDone(it.id) ? null : () => lib.markDone(it.id),
          icon: const Icon(Icons.check),
          label: Text(lib.isDone(it.id) ? 'مکمل ہو چکا' : 'مکمل کریں'),
        ),
      ]),
    );
  }
}
