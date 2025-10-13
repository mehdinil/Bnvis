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

final goalsProvider = NotifierProvider<GoalsController, List<Goal>>(GoalsController.new);

class GoalsController extends Notifier<List<Goal>> {
  late Box<Goal> box;

  @override
  List<Goal> build() {
    box = ref.read(goalsBoxProvider);
    box.watch().listen((_) => _refresh());
    return box.values.toList();
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

final tasksProvider = NotifierProvider<TasksController, List<Task>>(TasksController.new);

class TasksController extends Notifier<List<Task>> {
  late Box<Task> box;

  @override
  List<Task> build() {
    box = ref.read(tasksBoxProvider);
    box.watch().listen((_) => _refresh());
    return box.values.toList();
  }

  void _refresh() => state = box.values.toList();

  Future<void> add(Task t) async {
    await box.put(t.id, t);
    _refresh();
    _recomputeGoalProgressFor(t.goalId);
  }

  Future<void> update(Task t) async {
    await box.put(t.id, t);
    _refresh();
    _recomputeGoalProgressFor(t.goalId);
  }

  Future<void> remove(String id) async {
    await box.delete(id);
    _refresh();
    // best-effort: try to find the goalId from previous state
    // if not found, recompute all goals
    _recomputeAllGoalsProgress();
  }

  List<Task> getTasksForGoal(String goalId) {
    return state.where((task) => task.goalId == goalId).toList();
  }

  void _recomputeGoalProgressFor(String goalId) {
    final goalsBox = Hive.box<Goal>(HiveBoxes.goals);
    final goal = goalsBox.get(goalId);
    if (goal != null) {
      goal.updateProgress(state);
      goalsBox.put(goalId, goal);
    }
  }

  void _recomputeAllGoalsProgress() {
    final goalsBox = Hive.box<Goal>(HiveBoxes.goals);
    for (final goal in goalsBox.values) {
      goal.updateProgress(state);
      goalsBox.put(goal.id, goal);
    }
  }
}

// Habits
final habitsBoxProvider = Provider<Box<Habit>>((ref) {
  return Hive.box<Habit>(HiveBoxes.habits);
});

final habitsProvider = NotifierProvider<HabitsController, List<Habit>>(HabitsController.new);

class HabitsController extends Notifier<List<Habit>> {
  late Box<Habit> box;

  @override
  List<Habit> build() {
    box = ref.read(habitsBoxProvider);
    box.watch().listen((_) => _refresh());
    return box.values.toList();
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

final journalProvider = NotifierProvider<JournalController, List<JournalEntry>>(JournalController.new);

class JournalController extends Notifier<List<JournalEntry>> {
  late Box<JournalEntry> box;

  @override
  List<JournalEntry> build() {
    box = ref.read(journalBoxProvider);
    box.watch().listen((_) => _refresh());
    return box.values.toList();
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
