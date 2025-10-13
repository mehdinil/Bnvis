import 'package:hive/hive.dart';
import 'task.dart';
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
  @HiveField(7)
  double progress; // 0.0 .. 100.0

  Goal({
    required this.id,
    required this.title,
    this.why,
    this.priority = 2,
    this.dueDate,
    this.status = GoalStatus.active,
    List<String>? tags,
    this.progress = 0.0,
  }) : tags = tags ?? [];

  // Recalculate progress based on provided tasks for this goal
  void updateProgress(List<Task> allTasks) {
    final related = allTasks.where((t) => t.goalId == id).toList();
    if (related.isEmpty) {
      progress = 0.0;
      return;
    }
    final completed = related.where((t) => t.done).length;
    progress = (completed / related.length) * 100.0;
  }

  // JSON serialization
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'why': why,
    'priority': priority,
    'dueDate': dueDate?.toIso8601String(),
    'status': status.name,
    'tags': tags,
    'progress': progress,
  };

  factory Goal.fromJson(Map<String, dynamic> json) => Goal(
    id: json['id'] as String,
    title: json['title'] as String,
    why: json['why'] as String?,
    priority: json['priority'] as int? ?? 2,
    dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate'] as String) : null,
    status: GoalStatus.values.firstWhere(
      (e) => e.name == json['status'],
      orElse: () => GoalStatus.active,
    ),
    tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    // default to 0.0 if missing
    progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
  );
}
