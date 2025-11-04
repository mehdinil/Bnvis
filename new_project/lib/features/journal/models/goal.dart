
import 'package:hive/hive.dart';

part 'goal.g.dart';

@HiveType(typeId: 1)
enum GoalStatus {
  @HiveField(0)
  inProgress,
  @HiveField(1)
  completed,
  @HiveField(2)
  archived,
}

@HiveType(typeId: 2)
class Goal extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  late GoalStatus status;

  @HiveField(4)
  DateTime? dueDate;

  @HiveField(5)
  late DateTime createdAt;

  @HiveField(6)
  late DateTime updatedAt;

  Goal({
    required this.title,
    this.description,
    this.status = GoalStatus.inProgress,
    this.dueDate,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
    createdAt = DateTime.now();
    updatedAt = DateTime.now();
  }
}
