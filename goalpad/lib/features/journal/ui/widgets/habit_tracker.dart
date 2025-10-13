import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../logic/providers.dart';
import '../../models/habit.dart';

class HabitTracker extends ConsumerWidget {
  final Habit habit;
  const HabitTracker({super.key, required this.habit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final alreadyTicked = habit.log.any((date) => 
      DateTime(date.year, date.month, date.day) == todayDate);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    habit.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                _StreakBadge(streak: habit.streak),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  habit.frequency == HabitFrequency.daily 
                      ? Icons.today 
                      : Icons.date_range,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  habit.frequency.name.toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const Spacer(),
                if (alreadyTicked)
                  const Icon(Icons.check_circle, color: Colors.green, size: 20)
                else
                  IconButton(
                    onPressed: () async {
                      await ref.read(habitsProvider.notifier).tickHabit(habit.id);
                    },
                    icon: const Icon(Icons.add_circle_outline),
                    color: Theme.of(context).primaryColor,
                    tooltip: 'Tick habit',
                  ),
              ],
            ),
            if (habit.log.isNotEmpty) ...[
              const SizedBox(height: 12),
              _RecentActivity(habit: habit),
            ],
          ],
        ),
      ),
    );
  }
}

class _StreakBadge extends StatelessWidget {
  final int streak;
  const _StreakBadge({required this.streak});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: streak > 0 ? Colors.orange : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$streak day${streak != 1 ? 's' : ''}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _RecentActivity extends StatelessWidget {
  final Habit habit;
  const _RecentActivity({required this.habit});

  @override
  Widget build(BuildContext context) {
    final recentLogs = habit.log.take(7).toList();
    final today = DateTime.now();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(7, (index) {
            final date = today.subtract(Duration(days: 6 - index));
            final isLogged = recentLogs.any((logDate) => 
              DateTime(logDate.year, logDate.month, logDate.day) == 
              DateTime(date.year, date.month, date.day));
            
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                height: 32,
                decoration: BoxDecoration(
                  color: isLogged ? Colors.green : Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(
                      color: isLogged ? Colors.white : Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

