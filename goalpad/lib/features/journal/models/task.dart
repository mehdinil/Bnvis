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

  // JSON serialization
  Map<String, dynamic> toJson() => {
    'id': id,
    'goalId': goalId,
    'title': title,
    'due': due?.toIso8601String(),
    'done': done,
  };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'] as String,
    goalId: json['goalId'] as String,
    title: json['title'] as String,
    due: json['due'] != null ? DateTime.parse(json['due'] as String) : null,
    done: json['done'] as bool? ?? false,
  );
}
