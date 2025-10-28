import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:goalpad/features/journal/models/habit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter(HabitFrequencyAdapter())
      ..registerAdapter(HabitAdapter());
  });

  test('Habit tick functionality', () async {
    final box = await Hive.openBox<Habit>('habits_test');
    final id = const Uuid().v4();
    final habit = Habit(
      id: id,
      name: 'Test Habit',
      frequency: HabitFrequency.daily,
    );
    
    // Initial state
    expect(habit.streak, 0);
    expect(habit.log, isEmpty);
    
    // Add to box
    await box.put(id, habit);
    
    // Simulate tick
    final today = DateTime.now();
    habit.log.add(today);
    habit.streak++;
    await box.put(id, habit);
    
    // Verify tick
    final updatedHabit = box.get(id)!;
    expect(updatedHabit.streak, 1);
    expect(updatedHabit.log.length, 1);
    
    await box.close();
  });
}

