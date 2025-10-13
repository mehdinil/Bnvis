import 'package:hive/hive.dart';
part 'habit.g.dart';

@HiveType(typeId: 4)
enum HabitFrequency {
  @HiveField(0) daily,
  @HiveField(1) weekly,
}

@HiveType(typeId: 5)
class Habit extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  HabitFrequency frequency;
  @HiveField(3)
  int streak;
  @HiveField(4)
  List<DateTime> log;

  Habit({
    required this.id,
    required this.name,
    this.frequency = HabitFrequency.daily,
    this.streak = 0,
    List<DateTime>? log,
  }) : log = log ?? [];
}

