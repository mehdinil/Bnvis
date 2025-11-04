
import 'package:hive/hive.dart';

part 'habit.g.dart';

@HiveType(typeId: 4)
enum HabitFrequency {
  @HiveField(0)
  daily,
  @HiveField(1)
  weekly,
  @HiveField(2)
  monthly,
}

@HiveType(typeId: 5)
class Habit extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  late HabitFrequency frequency;

  @HiveField(4)
  late List<DateTime> completedDates;

  @HiveField(5)
  late DateTime createdAt;

  @HiveField(6)
  late DateTime updatedAt;

  Habit({
    required this.title,
    this.description,
    required this.frequency,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
    createdAt = DateTime.now();
    updatedAt = DateTime.now();
    completedDates = [];
  }
}
