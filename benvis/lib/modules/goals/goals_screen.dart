import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../../core/models/goal.dart';
import '../../core/services/isar_service.dart';
import '../../theme.dart';
import '../../widgets/glass.dart';

/// صفحه اهداف
class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  late Isar _isar;
  List<Goal> _goals = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadGoals();
  }

  Future<void> _loadGoals() async {
    _isar = await IsarService.getInstance();
    final goals = await _isar.goals.where().findAll();
    setState(() {
      _goals = goals;
      _loading = false;
    });
  }

  Future<void> _addGoal() async {
    final result = await showDialog<Goal>(
      context: context,
      builder: (context) => const _GoalDialog(),
    );

    if (result != null) {
      await _isar.writeTxn(() async {
        await _isar.goals.put(result);
      });
      _loadGoals();
    }
  }

  Future<void> _editGoal(Goal goal) async {
    final result = await showDialog<Goal>(
      context: context,
      builder: (context) => _GoalDialog(goal: goal),
    );

    if (result != null) {
      await _isar.writeTxn(() async {
        result.updatedAt = DateTime.now();
        await _isar.goals.put(result);
      });
      _loadGoals();
    }
  }

  Future<void> _deleteGoal(Goal goal) async {
    await _isar.writeTxn(() async {
      await _isar.goals.delete(goal.id);
    });
    _loadGoals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اهداف'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: فیلتر
            },
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _goals.isEmpty
              ? _buildEmptyState()
              : _buildGoalsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addGoal,
        backgroundColor: BenvisTheme.purple,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.flag_outlined, size: 80, color: Colors.white.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text(
            'هنوز هدفی نداری!',
            style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.6)),
          ),
          const SizedBox(height: 8),
          const Text('با دکمه + اولین هدفت رو اضافه کن'),
        ],
      ),
    );
  }

  Widget _buildGoalsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _goals.length,
      itemBuilder: (context, index) {
        final goal = _goals[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Glass(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _getCategoryColor(goal.category).withOpacity(0.3),
                child: Icon(_getCategoryIcon(goal.category), color: _getCategoryColor(goal.category)),
              ),
              title: Text(goal.title, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (goal.description != null) ...[
                    const SizedBox(height: 4),
                    Text(goal.description!, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: goal.progress,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    valueColor: AlwaysStoppedAnimation(_getCategoryColor(goal.category)),
                  ),
                  const SizedBox(height: 4),
                  Text('${(goal.progress * 100).toInt()}%', style: const TextStyle(fontSize: 12)),
                ],
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    _editGoal(goal);
                  } else if (value == 'delete') {
                    _deleteGoal(goal);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text('ویرایش')),
                  const PopupMenuItem(value: 'delete', child: Text('حذف')),
                ],
              ),
              onTap: () => _editGoal(goal),
            ),
          ),
        );
      },
    );
  }

  Color _getCategoryColor(GoalCategory category) {
    switch (category) {
      case GoalCategory.work:
        return Colors.blue;
      case GoalCategory.health:
        return Colors.green;
      case GoalCategory.financial:
        return Colors.orange;
      case GoalCategory.learning:
        return Colors.purple;
      case GoalCategory.personal:
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(GoalCategory category) {
    switch (category) {
      case GoalCategory.work:
        return Icons.work;
      case GoalCategory.health:
        return Icons.favorite;
      case GoalCategory.financial:
        return Icons.attach_money;
      case GoalCategory.learning:
        return Icons.school;
      case GoalCategory.personal:
        return Icons.person;
      default:
        return Icons.flag;
    }
  }
}

/// دیالوگ افزودن/ویرایش هدف
class _GoalDialog extends StatefulWidget {
  final Goal? goal;

  const _GoalDialog({this.goal});

  @override
  State<_GoalDialog> createState() => _GoalDialogState();
}

class _GoalDialogState extends State<_GoalDialog> {
  late TextEditingController _titleCtrl;
  late TextEditingController _descCtrl;
  GoalCategory _category = GoalCategory.personal;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.goal?.title ?? '');
    _descCtrl = TextEditingController(text: widget.goal?.description ?? '');
    _category = widget.goal?.category ?? GoalCategory.personal;
    _progress = widget.goal?.progress ?? 0.0;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.goal == null ? 'هدف جدید' : 'ویرایش هدف'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleCtrl,
              decoration: const InputDecoration(
                labelText: 'عنوان هدف',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descCtrl,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'توضیحات (اختیاری)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<GoalCategory>(
              value: _category,
              decoration: const InputDecoration(
                labelText: 'دسته‌بندی',
                border: OutlineInputBorder(),
              ),
              items: GoalCategory.values.map((cat) {
                return DropdownMenuItem(
                  value: cat,
                  child: Text(_getCategoryName(cat)),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) setState(() => _category = value);
              },
            ),
            const SizedBox(height: 16),
            Text('پیشرفت: ${(_progress * 100).toInt()}%'),
            Slider(
              value: _progress,
              onChanged: (value) => setState(() => _progress = value),
              activeColor: BenvisTheme.purple,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('لغو'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_titleCtrl.text.trim().isEmpty) return;

            final goal = widget.goal ?? Goal();
            goal.title = _titleCtrl.text.trim();
            goal.description = _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim();
            goal.category = _category;
            goal.progress = _progress;
            goal.updatedAt = DateTime.now();

            Navigator.pop(context, goal);
          },
          style: ElevatedButton.styleFrom(backgroundColor: BenvisTheme.purple),
          child: const Text('ذخیره'),
        ),
      ],
    );
  }

  String _getCategoryName(GoalCategory cat) {
    switch (cat) {
      case GoalCategory.work:
        return 'کاری';
      case GoalCategory.health:
        return 'سلامت';
      case GoalCategory.financial:
        return 'مالی';
      case GoalCategory.learning:
        return 'یادگیری';
      case GoalCategory.personal:
        return 'شخصی';
      default:
        return 'سایر';
    }
  }
}
