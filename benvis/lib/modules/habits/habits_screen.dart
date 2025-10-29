import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:intl/intl.dart';
import '../../core/models/habit.dart';
import '../../core/services/isar_service.dart';
import '../../theme.dart';
import '../../widgets/glass.dart';

/// صفحه عادات
class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  late Isar _isar;
  List<Habit> _habits = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    _isar = await IsarService.getInstance();
    final habits = await _isar.habits.where().findAll();
    setState(() {
      _habits = habits;
      _loading = false;
    });
  }

  Future<void> _addHabit() async {
    final result = await showDialog<Habit>(
      context: context,
      builder: (context) => const _HabitDialog(),
    );

    if (result != null) {
      await _isar.writeTxn(() async {
        await _isar.habits.put(result);
      });
      _loadHabits();
    }
  }

  Future<void> _checkIn(Habit habit) async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    if (habit.completedDates.contains(today)) {
      // لغو چک‌این
      habit.completedDates.remove(today);
      habit.currentStreak = _calculateStreak(habit.completedDates);
    } else {
      // چک‌این امروز
      habit.completedDates.add(today);
      habit.currentStreak = _calculateStreak(habit.completedDates);
      if (habit.currentStreak > habit.bestStreak) {
        habit.bestStreak = habit.currentStreak;
      }
    }

    await _isar.writeTxn(() async {
      await _isar.habits.put(habit);
    });

    _loadHabits();
  }

  int _calculateStreak(List<String> dates) {
    if (dates.isEmpty) return 0;

    dates.sort();
    int streak = 1;
    final now = DateTime.now();
    final today = DateFormat('yyyy-MM-dd').format(now);

    if (!dates.contains(today)) {
      // اگر امروز چک نشده، از دیروز شروع کن
      final yesterday = DateFormat('yyyy-MM-dd').format(now.subtract(const Duration(days: 1)));
      if (!dates.contains(yesterday)) return 0;
    }

    for (int i = dates.length - 2; i >= 0; i--) {
      final current = DateTime.parse(dates[i + 1]);
      final previous = DateTime.parse(dates[i]);
      if (current.difference(previous).inDays == 1) {
        streak++;
      } else {
        break;
      }
    }

    return streak;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('عادات'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _habits.isEmpty
              ? _buildEmptyState()
              : _buildHabitsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addHabit,
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
          Icon(Icons.check_circle_outline, size: 80, color: Colors.white.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text(
            'هنوز عادتی نداری!',
            style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.6)),
          ),
          const SizedBox(height: 8),
          const Text('عادت‌های خوب زندگیت رو اضافه کن'),
        ],
      ),
    );
  }

  Widget _buildHabitsList() {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _habits.length,
      itemBuilder: (context, index) {
        final habit = _habits[index];
        final isDone = habit.completedDates.contains(today);

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Glass(
            child: ListTile(
              leading: GestureDetector(
                onTap: () => _checkIn(habit),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isDone
                        ? BenvisTheme.purple.withOpacity(0.3)
                        : Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDone ? BenvisTheme.purple : Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    isDone ? Icons.check : Icons.circle_outlined,
                    color: isDone ? BenvisTheme.purple : Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
              title: Text(habit.title, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Row(
                children: [
                  const Icon(Icons.local_fire_department, color: Colors.orange, size: 16),
                  const SizedBox(width: 4),
                  Text('${habit.currentStreak} روز'),
                  const SizedBox(width: 16),
                  Text('بهترین: ${habit.bestStreak}', style: TextStyle(color: Colors.white.withOpacity(0.6))),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// دیالوگ افزودن عادت
class _HabitDialog extends StatefulWidget {
  const _HabitDialog();

  @override
  State<_HabitDialog> createState() => _HabitDialogState();
}

class _HabitDialogState extends State<_HabitDialog> {
  final _titleCtrl = TextEditingController();
  HabitFrequency _frequency = HabitFrequency.daily;

  @override
  void dispose() {
    _titleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('عادت جدید'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleCtrl,
            decoration: const InputDecoration(
              labelText: 'عنوان عادت',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<HabitFrequency>(
            value: _frequency,
            decoration: const InputDecoration(
              labelText: 'تکرار',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: HabitFrequency.daily, child: Text('روزانه')),
              DropdownMenuItem(value: HabitFrequency.weekly, child: Text('هفتگی')),
              DropdownMenuItem(value: HabitFrequency.monthly, child: Text('ماهانه')),
            ],
            onChanged: (value) {
              if (value != null) setState(() => _frequency = value);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('لغو'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_titleCtrl.text.trim().isEmpty) return;

            final habit = Habit()
              ..title = _titleCtrl.text.trim()
              ..frequency = _frequency;

            Navigator.pop(context, habit);
          },
          style: ElevatedButton.styleFrom(backgroundColor: BenvisTheme.purple),
          child: const Text('ذخیره'),
        ),
      ],
    );
  }
}
