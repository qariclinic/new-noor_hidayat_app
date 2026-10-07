class ContentItem {
  ContentItem({
    required this.id,
    required this.title,
    required this.body,
    required this.category,
    required this.audiences,
    required this.mediaType,
    required this.mediaUrl,
  });

  final String id, title, body, category, mediaType, mediaUrl;
  final List<String> audiences; // child / woman / man / all

  factory ContentItem.fromJson(Map<String, dynamic> j) => ContentItem(
        id: j['id'] as String,
        title: j['title'] as String,
        body: (j['body'] ?? '') as String,
        category: (j['category'] ?? '') as String,
        audiences: List<String>.from(j['audiences'] as List),
        mediaType: (j['mediaType'] ?? 'text') as String,
        mediaUrl: (j['mediaUrl'] ?? '') as String,
      );
}
