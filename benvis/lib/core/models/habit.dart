import 'package:isar/isar.dart';

part 'habit.g.dart';

/// مدل عادت با Streak
@collection
class Habit {
  Id id = Isar.autoIncrement;

  @Index()
  late String title;

  String? description;

  /// آیکون (emoji یا icon name)
  String? icon;

  /// رنگ
  String? color;

  /// تکرار (روزانه، هفتگی، ماهانه)
  @enumerated
  HabitFrequency frequency = HabitFrequency.daily;

  /// روزهای هفته (برای هفتگی): 1=Mon, 7=Sun
  List<int>? weekDays;

  /// تعداد تکرار در روز (مثلاً ۳ بار ورزش)
  int targetCount = 1;

  /// Streak فعلی
  int currentStreak = 0;

  /// بهترین Streak
  int bestStreak = 0;

  /// تاریخ‌های تکمیل شده (YYYY-MM-DD)
  List<String> completedDates = [];

  /// یادآوری
  bool reminderEnabled = false;
  String? reminderTime; // HH:mm

  /// تاریخ ایجاد
  DateTime createdAt = DateTime.now();

  /// وضعیت
  @enumerated
  HabitStatus status = HabitStatus.active;
}

enum HabitFrequency {
  daily,
  weekly,
  monthly,
}

enum HabitStatus {
  active,
  paused,
  archived,
}
