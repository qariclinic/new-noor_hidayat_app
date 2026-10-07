import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/content_item.dart';

/// فی الحال مواد assets/data/content.json سے آتا ہے۔
/// بعد میں اسے Firebase/Supabase کی کال سے بدلیں (docs/backend_schema.md دیکھیں)۔
class ContentService {
  static Future<List<ContentItem>> loadAll() async {
    final raw = await rootBundle.loadString('assets/data/content.json');
    final list = jsonDecode(raw) as List;
    return list
        .map((e) => ContentItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
