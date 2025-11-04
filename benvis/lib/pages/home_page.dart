import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../widgets/glass.dart';
import '../theme.dart';
import '../services/profile_service.dart';
import '../core/services/isar_service.dart';
import '../core/services/ai_coach_service.dart';
import '../core/models/goal.dart';
import '../core/models/habit.dart';
import '../core/models/journal_entry.dart';
import 'package:intl/intl.dart';

/// صفحه اصلی با داشبورد و متریک‌ها
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _service = ProfileService();
  final _aiCoach = AiCoachService();
  String _userName = 'کاربر';
  late Isar _isar;
  
  // Stats
  int _activeGoals = 0;
  int _todayHabits = 0;
  int _habitStreak = 0;
  int _journalCount = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final profile = await _service.loadProfile();
    if (profile != null && mounted) {
      setState(() {
        _userName = profile.fullName;
      });
    }

    _isar = await IsarService.getInstance();
    
    // Load stats
    final goals = await _isar.goals.where().filter().statusEqualTo(GoalStatus.active).findAll();
    final habits = await _isar.habits.where().findAll();
    final journals = await _isar.journalEntrys.where().findAll();
    
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final todayHabits = habits.where((h) => h.completedDates.contains(today)).length;
    final maxStreak = habits.isNotEmpty ? habits.map((h) => h.currentStreak).reduce((a, b) => a > b ? a : b) : 0;

    if (mounted) {
      setState(() {
        _activeGoals = goals.length;
        _todayHabits = todayHabits;
        _habitStreak = maxStreak;
        _journalCount = journals.length;
      });
    }
  }

  Future<void> _resetOnboarding() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('بازنشانی آن‌بوردینگ'),
        content: const Text('آیا می‌خواهید به صفحه خوش‌آمدگویی برگردید؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child: const Text('لغو'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(c, true),
            child: const Text('بله'),
          ),
        ],
      ),
    );
    if (confirm == true && mounted) {
      await _service.resetAll();
      // رفرش اپ
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // هدر خوش‌آمدگویی
            _buildHeader(context),
            const SizedBox(height: 24),

            // کارت پیشرفت
            const Glass(
              child: _ProgressCard(),
            ),
            const SizedBox(height: 24),

            // گرید متریک‌ها
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.3,
              children: [
                _MetricCard(
                  title: 'اهداف فعال',
                  value: '$_activeGoals',
                  icon: Icons.flag,
                  color: BenvisTheme.purple,
                ),
                _MetricCard(
                  title: 'Streak روزانه',
                  value: '$_habitStreak',
                  suffix: 'روز',
                  icon: Icons.local_fire_department,
                  color: Colors.orange,
                ),
                _MetricCard(
                  title: 'عادات امروز',
                  value: '$_todayHabits',
                  icon: Icons.check_circle_outline,
                  color: Colors.green,
                ),
                _MetricCard(
                  title: 'یادداشت‌ها',
                  value: '$_journalCount',
                  icon: Icons.book,
                  color: BenvisTheme.blue,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // AI Coach Insight
            Glass(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.psychology, color: BenvisTheme.purple, size: 24),
                        SizedBox(width: 8),
                        Text(
                          'AI Coach',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _aiCoach.getDailyQuote(),
                      style: const TextStyle(fontSize: 14, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🌟 سلام، $_userName',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'امروز یک روز عالی برای پیشرفت است!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) async {
                if (value == 'edit') {
                  await Navigator.of(context).pushNamed('/profile-edit');
                  _loadProfile(); // رفرش پروفایل
                } else if (value == 'reset') {
                  _resetOnboarding();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('ویرایش پروفایل'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'reset',
                  child: Row(
                    children: [
                      Icon(Icons.refresh),
                      SizedBox(width: 8),
                      Text('بازنشانی آن‌بوردینگ'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// کارت پیشرفت امروز
class _ProgressCard extends StatelessWidget {
  const _ProgressCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'پیشرفت امروز',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: BenvisTheme.purple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('62%', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: 0.62,
            minHeight: 8,
            backgroundColor: Colors.white.withOpacity(0.1),
            valueColor: const AlwaysStoppedAnimation(BenvisTheme.purple),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '8 از 13 تسک تکمیل شده',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}

/// کارت متریک
class _MetricCard extends StatelessWidget {

  const _MetricCard({
    required this.title,
    required this.value,
    this.suffix,
    required this.icon,
    required this.color,
  });
  final String title;
  final String value;
  final String? suffix;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Glass(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (suffix != null) ...[
                const SizedBox(width: 4),
                Text(
                  suffix!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

/// اهداف اخیر
class _RecentGoals extends StatelessWidget {
  const _RecentGoals();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'اهداف اخیر',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        ...[
          ('یادگیری Flutter پیشرفته', 0.75, BenvisTheme.purple),
          ('تمرین ورزشی روزانه', 0.45, BenvisTheme.blue),
          ('مطالعه کتاب', 0.30, Colors.orange),
        ].map((goal) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _GoalItem(
                title: goal.$1,
                progress: goal.$2,
                color: goal.$3,
              ),
            )),
      ],
    );
  }
}

class _GoalItem extends StatelessWidget {

  const _GoalItem({
    required this.title,
    required this.progress,
    required this.color,
  });
  final String title;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 14)),
            Text(
              '${(progress * 100).toInt()}%',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: Colors.white.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}

