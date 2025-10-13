import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../logic/providers.dart';
import '../../models/habit.dart';
import '../widgets/habit_tracker.dart';

class HabitsPage extends ConsumerWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Habits')),
      body: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (_, i) => HabitTracker(habit: habits[i]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final id = const Uuid().v4();
          final habit = Habit(
            id: id,
            name: 'New Habit',
            frequency: HabitFrequency.daily,
          );
          await ref.read(habitsProvider.notifier).add(habit);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

