import 'package:flutter/material.dart';
import '../widgets/glass.dart';
import '../theme.dart';

/// صفحه مهارت‌ها و آموزش
class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '📚 مهارت‌های من',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 24),

            // مهارت‌های در حال یادگیری
            Glass(
              child: _SkillsSection(),
            ),
            SizedBox(height: 16),

            // دوره‌های پیشنهادی
            Glass(
              child: _RecommendedCourses(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillsSection extends StatelessWidget {
  const _SkillsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'در حال یادگیری',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        ...[
          ('Flutter Development', 0.85, Icons.phone_android, BenvisTheme.blue),
          ('UI/UX Design', 0.60, Icons.design_services, BenvisTheme.purple),
          ('Marketing', 0.35, Icons.trending_up, Colors.orange),
        ].map((skill) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _SkillItem(
                title: skill.$1,
                progress: skill.$2,
                icon: skill.$3,
                color: skill.$4,
              ),
            )),
      ],
    );
  }
}

class _SkillItem extends StatelessWidget {

  const _SkillItem({
    required this.title,
    required this.progress,
    required this.icon,
    required this.color,
  });
  final String title;
  final double progress;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: TextStyle(color: Colors.white.withOpacity(0.6)),
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
          ),
        ),
      ],
    );
  }
}

class _RecommendedCourses extends StatelessWidget {
  const _RecommendedCourses();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'پیشنهاد شده',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        ...[
          ('دوره جامع دارت', '32 ساعت'),
          ('Figma for Developers', '18 ساعت'),
          ('استراتژی محتوا', '24 ساعت'),
        ].map((course) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  const Icon(Icons.play_circle_outline, color: BenvisTheme.purple),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(course.$1),
                  ),
                  Text(
                    course.$2,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

