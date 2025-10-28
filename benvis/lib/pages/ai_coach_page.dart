import 'package:flutter/material.dart';
import '../widgets/glass.dart';
import '../theme.dart';

/// صفحه AI Coach و دستیار هوشمند
class AiCoachPage extends StatelessWidget {
  const AiCoachPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '🤖 AI Coach',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              'دستیار هوشمند شما برای موفقیت',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 24),

            // پیشنهادات امروز
            const Glass(
              child: _TodaySuggestions(),
            ),
            const SizedBox(height: 16),

            // آمار هفتگی
            const Glass(
              child: _WeeklyStats(),
            ),
            const SizedBox(height: 16),

            // تحلیل‌های AI
            const Glass(
              child: _AiInsights(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TodaySuggestions extends StatelessWidget {
  const _TodaySuggestions();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: BenvisTheme.purple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.lightbulb_outline, color: BenvisTheme.purple),
            ),
            const SizedBox(width: 12),
            const Text(
              'پیشنهادات امروز',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...[
          (Icons.fitness_center, 'زمان ورزش! 30 دقیقه تمرین کاردیو'),
          (Icons.book, 'مطالعه فصل جدید کتاب در صف انتظار'),
          (Icons.water_drop, 'فراموش نکن: 2 لیتر آب امروز'),
        ].map((suggestion) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Icon(
                    suggestion.$1,
                    size: 20,
                    color: BenvisTheme.blue,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(suggestion.$2),
                  ),
                  IconButton(
                    icon: const Icon(Icons.check_circle_outline, size: 20),
                    onPressed: () {},
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

class _WeeklyStats extends StatelessWidget {
  const _WeeklyStats();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'آمار هفته',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _StatItem(
              label: 'تسک‌ها',
              value: '42',
              color: BenvisTheme.purple,
            ),
            _StatItem(
              label: 'ساعت کار',
              value: '28',
              color: BenvisTheme.blue,
            ),
            _StatItem(
              label: 'اهداف',
              value: '7',
              color: Colors.green,
            ),
          ],
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}

class _AiInsights extends StatelessWidget {
  const _AiInsights();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.analytics, color: BenvisTheme.blue, size: 20),
            const SizedBox(width: 8),
            const Text(
              'تحلیل هوشمند',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: BenvisTheme.purple.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: BenvisTheme.purple.withOpacity(0.3),
            ),
          ),
          child: Text(
            '💡 بر اساس الگوی کاری شما، بهترین زمان برای تمرکز روی اهداف مهم ساعت 9-11 صبح است. در این بازه زمانی بیشترین بهره‌وری را دارید.',
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ),
      ],
    );
  }
}

