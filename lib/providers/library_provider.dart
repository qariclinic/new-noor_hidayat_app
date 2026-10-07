import 'package:flutter/foundation.dart';
import '../models/content_item.dart';
import '../models/user_role.dart';
import '../services/content_service.dart';
import '../services/storage_service.dart';

String _ymd(DateTime d) =>
    '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

class LibraryProvider extends ChangeNotifier {
  LibraryProvider(this._s);
  final StorageService _s;

  List<ContentItem> all = [];
  Set<String> bookmarks = {};
  Set<String> completed = {};
  int streak = 0;
  String query = '';
  String? category;
  String? mediaType;
  String? _pid;

  Future<void> load() async {
    all = await ContentService.loadAll();
    notifyListeners();
  }

  void bindProfile(String? id) {
    if (id == _pid) return;
    _pid = id;
    Future.microtask(() {
      if (id == null) {
        bookmarks = {};
        completed = {};
        streak = 0;
      } else {
        bookmarks = _s.getSet('bm_$id');
        completed = _s.getSet('done_$id');
        streak = _s.getInt('streak_$id');
      }
      notifyListeners();
    });
  }

  List<ContentItem> forRole(UserRole r) =>
      all.where((c) => c.audiences.contains(r.name) || c.audiences.contains('all')).toList();

  List<ContentItem> visible(UserRole r) => forRole(r).where((c) {
        final q = query.trim();
        final okQ = q.isEmpty || c.title.contains(q) || c.body.contains(q);
        final okC = category == null || c.category == category;
        final okM = mediaType == null || c.mediaType == mediaType;
        return okQ && okC && okM;
      }).toList();

  List<String> categories(UserRole r) =>
      forRole(r).map((c) => c.category).toSet().toList();

  void setQuery(String v) { query = v; notifyListeners(); }
  void setCategory(String? v) { category = v; notifyListeners(); }
  void setMediaType(String? v) { mediaType = v; notifyListeners(); }

  bool isBookmarked(String id) => bookmarks.contains(id);
  bool isDone(String id) => completed.contains(id);

  Future<void> toggleBookmark(String id) async {
    bookmarks.contains(id) ? bookmarks.remove(id) : bookmarks.add(id);
    if (_pid != null) await _s.setSet('bm_$_pid', bookmarks);
    notifyListeners();
  }

  Future<void> markDone(String id) async {
    if (_pid == null || completed.contains(id)) return;
    completed.add(id);
    await _s.setSet('done_$_pid', completed);
    final today = _ymd(DateTime.now());
    final last = _s.getString('last_$_pid');
    if (last != today) {
      final yesterday = _ymd(DateTime.now().subtract(const Duration(days: 1)));
      streak = last == yesterday ? streak + 1 : 1;
      await _s.setInt('streak_$_pid', streak);
      await _s.setString('last_$_pid', today);
    }
    notifyListeners();
  }

  double percent(UserRole r) {
    final items = forRole(r);
    if (items.isEmpty) return 0;
    return items.where((c) => completed.contains(c.id)).length / items.length;
  }
}
