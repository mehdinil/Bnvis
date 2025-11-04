import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 3)
class Task extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String goalId;
  @HiveField(2)
  String title;
  @HiveField(3)
  DateTime? due;
  @HiveField(4)
  bool done;

  Task({
    required this.id,
    required this.goalId,
    required this.title,
    this.due,
    this.done = false,
  });
}

