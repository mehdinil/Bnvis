import 'package:flutter_test/flutter_test.dart';
import 'package:goalpad/features/journal/models/goal.dart';
import 'package:goalpad/features/journal/models/task.dart';
import 'package:goalpad/features/journal/models/habit.dart';
import 'package:goalpad/features/journal/models/journal_entry.dart';

void main() {
  group('JSON Serialization Tests', () {
    test('Goal toJson and fromJson should work correctly', () {
      final goal = Goal(
        id: 'test-1',
        title: 'Test Goal',
        why: 'For testing',
        priority: 1,
        dueDate: DateTime(2025, 12, 31),
        status: GoalStatus.active,
        tags: ['work', 'urgent'],
      );

      final json = goal.toJson();
      final restored = Goal.fromJson(json);

      expect(restored.id, goal.id);
      expect(restored.title, goal.title);
      expect(restored.why, goal.why);
      expect(restored.priority, goal.priority);
      expect(restored.status, goal.status);
      expect(restored.tags, goal.tags);
      expect(restored.dueDate?.year, goal.dueDate?.year);
    });

    test('Task toJson and fromJson should work correctly', () {
      final task = Task(
        id: 'task-1',
        goalId: 'goal-1',
        title: 'Test Task',
        due: DateTime(2025, 10, 15),
        done: true,
      );

      final json = task.toJson();
      final restored = Task.fromJson(json);

      expect(restored.id, task.id);
      expect(restored.goalId, task.goalId);
      expect(restored.title, task.title);
      expect(restored.done, task.done);
      expect(restored.due?.year, task.due?.year);
    });

    test('Habit toJson and fromJson should work correctly', () {
      final habit = Habit(
        id: 'habit-1',
        name: 'Morning Exercise',
        frequency: HabitFrequency.daily,
        streak: 7,
        log: [
          DateTime(2025, 10, 1),
          DateTime(2025, 10, 2),
        ],
      );

      final json = habit.toJson();
      final restored = Habit.fromJson(json);

      expect(restored.id, habit.id);
      expect(restored.name, habit.name);
      expect(restored.frequency, habit.frequency);
      expect(restored.streak, habit.streak);
      expect(restored.log.length, habit.log.length);
    });

    test('JournalEntry toJson and fromJson should work correctly', () {
      final entry = JournalEntry(
        id: 'entry-1',
        date: DateTime(2025, 10, 1, 14, 30),
        mood: 5,
        text: 'Great day today!',
        tags: ['happy', 'productive'],
      );

      final json = entry.toJson();
      final restored = JournalEntry.fromJson(json);

      expect(restored.id, entry.id);
      expect(restored.mood, entry.mood);
      expect(restored.text, entry.text);
      expect(restored.tags, entry.tags);
      expect(restored.date.year, entry.date.year);
      expect(restored.date.month, entry.date.month);
    });

    test('Goal with null optional fields should serialize correctly', () {
      final goal = Goal(
        id: 'test-2',
        title: 'Simple Goal',
      );

      final json = goal.toJson();
      final restored = Goal.fromJson(json);

      expect(restored.id, goal.id);
      expect(restored.title, goal.title);
      expect(restored.why, isNull);
      expect(restored.dueDate, isNull);
      expect(restored.tags, isEmpty);
    });
  });
}


