import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../logic/providers.dart';
import '../../models/goal.dart';
import '../../models/task.dart';

class GoalDetailPage extends ConsumerWidget {
  final Goal goal;
  const GoalDetailPage({super.key, required this.goal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    final goalTasks = tasks.where((task) => task.goalId == goal.id).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(goal.title),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'delete') {
                await ref.read(goalsProvider.notifier).remove(goal.id);
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'delete', child: Text('Delete Goal')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Goal Info Card
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          goal.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Chip(
                        label: Text(goal.status.name.toUpperCase()),
                        backgroundColor: goal.status == GoalStatus.done
                            ? Colors.green
                            : goal.status == GoalStatus.active
                                ? Colors.blue
                                : Colors.grey,
                      ),
                    ],
                  ),
                  if (goal.why != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Why: ${goal.why}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.flag, size: 16, color: _getPriorityColor(goal.priority)),
                      const SizedBox(width: 4),
                      Text('Priority ${goal.priority}'),
                      if (goal.dueDate != null) ...[
                        const SizedBox(width: 16),
                        Icon(Icons.schedule, size: 16),
                        const SizedBox(width: 4),
                        Text('Due: ${_formatDate(goal.dueDate!)}'),
                      ],
                    ],
                  ),
                  if (goal.tags.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      children: goal.tags.map((tag) => Chip(
                        label: Text(tag),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      )).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
          // Tasks Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Tasks (${goalTasks.length})',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: goalTasks.length,
                    itemBuilder: (context, index) {
                      final task = goalTasks[index];
                      return _TaskTile(task: task);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1: return Colors.red;
      case 2: return Colors.orange;
      case 3: return Colors.green;
      default: return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Task Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.schedule),
                title: Text(selectedDate == null 
                    ? 'No due date' 
                    : _formatDate(selectedDate!)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    setState(() => selectedDate = date);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty) {
                  final task = Task(
                    id: const Uuid().v4(),
                    goalId: goal.id,
                    title: titleController.text,
                    due: selectedDate,
                  );
                  await ref.read(tasksProvider.notifier).add(task);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskTile extends ConsumerWidget {
  final Task task;
  const _TaskTile({required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Checkbox(
          value: task.done,
          onChanged: (value) async {
            final updatedTask = Task(
              id: task.id,
              goalId: task.goalId,
              title: task.title,
              due: task.due,
              done: value ?? false,
            );
            await ref.read(tasksProvider.notifier).update(updatedTask);
          },
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.done ? TextDecoration.lineThrough : null,
            color: task.done ? Colors.grey : null,
          ),
        ),
        subtitle: task.due != null 
            ? Text('Due: ${_formatDate(task.due!)}')
            : null,
        trailing: PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'delete') {
              await ref.read(tasksProvider.notifier).remove(task.id);
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'delete', child: Text('Delete')),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

