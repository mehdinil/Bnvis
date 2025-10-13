import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../logic/providers.dart';
import '../../models/goal.dart';
import 'goal_detail_page.dart';

class GoalsPage extends ConsumerWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goals = ref.watch(goalsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Goals')),
      body: ListView.builder(
        itemCount: goals.length,
        itemBuilder: (_, i) => _GoalTile(goal: goals[i]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final id = const Uuid().v4();
          final g = Goal(id: id, title: 'New Goal', priority: 2, status: GoalStatus.active);
          await ref.read(goalsProvider.notifier).add(g);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _GoalTile extends ConsumerWidget {
  final Goal goal;
  const _GoalTile({required this.goal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        title: Text(goal.title),
        subtitle: Text('Priority ${goal.priority} • ${goal.status.name}'),
        trailing: PopupMenuButton<String>(
          onSelected: (v) {
            final updated = Goal(
              id: goal.id,
              title: goal.title,
              why: goal.why,
              priority: goal.priority,
              dueDate: goal.dueDate,
              status: v == 'done' ? GoalStatus.done : GoalStatus.active,
              tags: goal.tags,
            );
            ref.read(goalsProvider.notifier).update(updated);
          },
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'active', child: Text('Mark Active')),
            PopupMenuItem(value: 'done', child: Text('Mark Done')),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => GoalDetailPage(goal: goal),
            ),
          );
        },
      ),
    );
  }
}
