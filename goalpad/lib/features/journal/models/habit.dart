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

  // JSON serialization
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'frequency': frequency.name,
    'streak': streak,
    'log': log.map((d) => d.toIso8601String()).toList(),
  };

  factory Habit.fromJson(Map<String, dynamic> json) => Habit(
    id: json['id'] as String,
    name: json['name'] as String,
    frequency: HabitFrequency.values.firstWhere(
      (e) => e.name == json['frequency'],
      orElse: () => HabitFrequency.daily,
    ),
    streak: json['streak'] as int? ?? 0,
    log: (json['log'] as List<dynamic>?)
        ?.map((e) => DateTime.parse(e as String))
        .toList(),
  );
}
