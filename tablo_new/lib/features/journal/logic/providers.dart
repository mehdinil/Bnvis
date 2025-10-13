import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../data/local/hive_boxes.dart';
import '../models/goal.dart';
import '../models/task.dart';
import '../models/habit.dart';
import '../models/journal_entry.dart';

// Goals
final goalsBoxProvider = Provider<Box<Goal>>((ref) {
  return Hive.box<Goal>(HiveBoxes.goals);
});

final goalsProvider = StateNotifierProvider<GoalsController, List<Goal>>((ref) {
  final box = ref.watch(goalsBoxProvider);
  return GoalsController(box);
});

class GoalsController extends StateNotifier<List<Goal>> {
  final Box<Goal> box;
  GoalsController(this.box) : super(box.values.toList()) {
    box.watch().listen((_) => _refresh());
  }

  void _refresh() => state = box.values.toList();

  Future<void> add(Goal g) async {
    await box.put(g.id, g);
    _refresh();
  }

  Future<void> update(Goal g) async {
    await box.put(g.id, g);
    _refresh();
  }

  Future<void> remove(String id) async {
    await box.delete(id);
    _refresh();
  }
}

// Tasks
final tasksBoxProvider = Provider<Box<Task>>((ref) {
  return Hive.box<Task>(HiveBoxes.tasks);
});

final tasksProvider = StateNotifierProvider<TasksController, List<Task>>((ref) {
  final box = ref.watch(tasksBoxProvider);
  return TasksController(box);
});

class TasksController extends StateNotifier<List<Task>> {
  final Box<Task> box;
  TasksController(this.box) : super(box.values.toList()) {
    box.watch().listen((_) => _refresh());
  }

  void _refresh() => state = box.values.toList();

  Future<void> add(Task t) async {
    await box.put(t.id, t);
    _refresh();
  }

  Future<void> update(Task t) async {
    await box.put(t.id, t);
    _refresh();
  }

  Future<void> remove(String id) async {
    await box.delete(id);
    _refresh();
  }

  List<Task> getTasksForGoal(String goalId) {
    return state.where((task) => task.goalId == goalId).toList();
  }
}

// Habits
final habitsBoxProvider = Provider<Box<Habit>>((ref) {
  return Hive.box<Habit>(HiveBoxes.habits);
});

final habitsProvider = StateNotifierProvider<HabitsController, List<Habit>>((ref) {
  final box = ref.watch(habitsBoxProvider);
  return HabitsController(box);
});

class HabitsController extends StateNotifier<List<Habit>> {
  final Box<Habit> box;
  HabitsController(this.box) : super(box.values.toList()) {
    box.watch().listen((_) => _refresh());
  }

  void _refresh() => state = box.values.toList();

  Future<void> add(Habit h) async {
    await box.put(h.id, h);
    _refresh();
  }

  Future<void> update(Habit h) async {
    await box.put(h.id, h);
    _refresh();
  }

  Future<void> remove(String id) async {
    await box.delete(id);
    _refresh();
  }

  Future<void> tickHabit(String habitId) async {
    final habit = box.get(habitId);
    if (habit != null) {
      final today = DateTime.now();
      final todayDate = DateTime(today.year, today.month, today.day);
      
      // Check if already ticked today
      final alreadyTicked = habit.log.any((date) => 
        DateTime(date.year, date.month, date.day) == todayDate);
      
      if (!alreadyTicked) {
        habit.log.add(today);
        habit.streak++;
        await box.put(habitId, habit);
        _refresh();
      }
    }
  }
}

// Journal Entries
final journalBoxProvider = Provider<Box<JournalEntry>>((ref) {
  return Hive.box<JournalEntry>(HiveBoxes.journal);
});

final journalProvider = StateNotifierProvider<JournalController, List<JournalEntry>>((ref) {
  final box = ref.watch(journalBoxProvider);
  return JournalController(box);
});

class JournalController extends StateNotifier<List<JournalEntry>> {
  final Box<JournalEntry> box;
  JournalController(this.box) : super(box.values.toList()) {
    box.watch().listen((_) => _refresh());
  }

  void _refresh() => state = box.values.toList();

  Future<void> add(JournalEntry e) async {
    await box.put(e.id, e);
    _refresh();
  }

  Future<void> update(JournalEntry e) async {
    await box.put(e.id, e);
    _refresh();
  }

  Future<void> remove(String id) async {
    await box.delete(id);
    _refresh();
  }

  List<JournalEntry> getEntriesForDate(DateTime date) {
    final targetDate = DateTime(date.year, date.month, date.day);
    return state.where((entry) {
      final entryDate = DateTime(entry.date.year, entry.date.month, entry.date.day);
      return entryDate == targetDate;
    }).toList();
  }
}
