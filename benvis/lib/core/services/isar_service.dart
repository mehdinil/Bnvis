import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/goal.dart';
import '../models/habit.dart';
import '../models/journal_entry.dart';

/// سرویس مدیریت Isar Database
class IsarService {
  static Isar? _isar;

  /// دریافت نمونه Isar
  static Future<Isar> getInstance() async {
    if (_isar != null) return _isar!;

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        GoalSchema,
        HabitSchema,
        JournalEntrySchema,
      ],
      directory: dir.path,
      inspector: true, // برای دیباگ
    );
    return _isar!;
  }

  /// بستن دیتابیس
  static Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }
}
