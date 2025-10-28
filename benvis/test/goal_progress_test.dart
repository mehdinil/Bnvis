import 'package:flutter_test/flutter_test.dart';
import 'package:goalpad/features/journal/models/goal.dart';
import 'package:goalpad/features/journal/models/task.dart';

void main() {
  group('Goal.updateProgress', () {
    test('no tasks -> 0%', () {
      final g = Goal(id: 'g1', title: 'Test');
      g.updateProgress(const []);
      expect(g.progress, 0.0);
    });

    test('half of tasks completed -> 50%', () {
      final g = Goal(id: 'g1', title: 'Test');
      final tasks = [
        Task(id: 't1', goalId: 'g1', title: 'A', done: true),
        Task(id: 't2', goalId: 'g1', title: 'B', done: false),
      ];
      g.updateProgress(tasks);
      expect(g.progress, closeTo(50.0, 0.0001));
    });

    test('only counts tasks of this goal', () {
      final g = Goal(id: 'g1', title: 'Test');
      final tasks = [
        Task(id: 't1', goalId: 'g1', title: 'A', done: true),
        Task(id: 't2', goalId: 'g2', title: 'Other', done: true),
      ];
      g.updateProgress(tasks);
      expect(g.progress, 100.0);
    });
  });
}


