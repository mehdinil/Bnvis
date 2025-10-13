import 'package:hive/hive.dart';
part 'goal.g.dart';

@HiveType(typeId: 1)
enum GoalStatus {
  @HiveField(0) draft,
  @HiveField(1) active,
  @HiveField(2) done,
}

@HiveType(typeId: 2)
class Goal extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String? why;
  @HiveField(3)
  int priority; // 1..3
  @HiveField(4)
  DateTime? dueDate;
  @HiveField(5)
  GoalStatus status;
  @HiveField(6)
  List<String> tags;

  Goal({
    required this.id,
    required this.title,
    this.why,
    this.priority = 2,
    this.dueDate,
    this.status = GoalStatus.active,
    List<String>? tags,
  }) : tags = tags ?? [];
}

