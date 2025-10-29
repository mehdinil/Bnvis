import 'package:isar/isar.dart';

part 'goal.g.dart';

/// مدل هدف با OKR
@collection
class Goal {
  Id id = Isar.autoIncrement;

  @Index()
  late String title;

  String? description;

  /// نوع هدف (personal, work, health, financial, learning)
  @enumerated
  late GoalCategory category;

  /// پیشرفت (0.0 تا 1.0)
  double progress = 0.0;

  /// وضعیت
  @enumerated
  GoalStatus status = GoalStatus.active;

  /// ددلاین
  DateTime? deadline;

  /// تاریخ ایجاد
  DateTime createdAt = DateTime.now();

  /// تاریخ آخرین بروزرسانی
  DateTime updatedAt = DateTime.now();

  /// معیارهای موفقیت (Key Results)
  List<String>? keyResults;

  /// یادآوری فعال
  bool reminderEnabled = false;
}

enum GoalCategory {
  personal,
  work,
  health,
  financial,
  learning,
  other,
}

enum GoalStatus {
  active,
  completed,
  paused,
  archived,
}
