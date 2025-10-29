import 'package:isar/isar.dart';

part 'journal_entry.g.dart';

/// مدل یادداشت روزانه
@collection
class JournalEntry {
  Id id = Isar.autoIncrement;

  /// تاریخ (YYYY-MM-DD)
  @Index()
  late String date;

  /// محتوا (متن)
  late String content;

  /// خلق و خو (mood)
  @enumerated
  Mood? mood;

  /// تگ‌ها
  List<String>? tags;

  /// مسیر عکس‌ها (local path)
  List<String>? photos;

  /// مسیر صدا (local path)
  String? audioPath;

  /// نکات AI Coach
  String? aiInsight;

  /// تاریخ ایجاد
  DateTime createdAt = DateTime.now();

  /// تاریخ ویرایش
  DateTime updatedAt = DateTime.now();
}

enum Mood {
  amazing,   // 😍
  happy,     // 😊
  neutral,   // 😐
  sad,       // 😢
  angry,     // 😠
  tired,     // 😴
}
