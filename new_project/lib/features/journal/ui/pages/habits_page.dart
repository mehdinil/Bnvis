import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../logic/providers.dart';
import '../../models/habit.dart';

class HabitsPage extends ConsumerWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Habits')),
      body: habits.isEmpty
          ? const Center(child: Text('No habits yet'))
          : ListView.builder(
              itemCount: habits.length,
              itemBuilder: (_, i) => _HabitTile(habit: habits[i]),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final id = const Uuid().v4();
          final habit = Habit(id: id, name: 'New Habit');
          await ref.read(habitsProvider.notifier).add(habit);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _HabitTile extends ConsumerWidget {
  final Habit habit;
  const _HabitTile({required this.habit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final isTickedToday = habit.log.any((date) => 
      date.year == todayDate.year && 
      date.month == todayDate.month && 
      date.day == todayDate.day
    );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        title: Text(habit.name),
        subtitle: Text('Streak: ${habit.streak} days'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isTickedToday)
              const Icon(Icons.check_circle, color: Colors.green)
            else
              IconButton(
                icon: const Icon(Icons.check_circle_outline),
                onPressed: () => ref.read(habitsProvider.notifier).tickHabit(habit.id),
              ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => ref.read(habitsProvider.notifier).remove(habit.id),
            ),
          ],
        ),
      ),
    );
  }
}

