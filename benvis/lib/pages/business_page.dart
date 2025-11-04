import 'package:flutter/material.dart';
import '../widgets/glass.dart';
import '../theme.dart';

/// صفحه بیزینس و کسب‌وکار
class BusinessPage extends StatelessWidget {
  const BusinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '💼 کسب‌وکار من',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 24),

            // مترک‌های مالی
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: const [
                _BusinessMetric(
                  title: 'درآمد ماهانه',
                  value: '12.5M',
                  trend: '+15%',
                  isPositive: true,
                ),
                _BusinessMetric(
                  title: 'هزینه‌ها',
                  value: '4.2M',
                  trend: '-5%',
                  isPositive: true,
                ),
                _BusinessMetric(
                  title: 'سود خالص',
                  value: '8.3M',
                  trend: '+22%',
                  isPositive: true,
                ),
                _BusinessMetric(
                  title: 'مشتریان',
                  value: '324',
                  trend: '+8%',
                  isPositive: true,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // پروژه‌های فعال
            const Glass(
              child: _ActiveProjects(),
            ),
          ],
        ),
      ),
    );
  }
}

class _BusinessMetric extends StatelessWidget {

  const _BusinessMetric({
    required this.title,
    required this.value,
    required this.trend,
    required this.isPositive,
  });
  final String title;
  final String value;
  final String trend;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    return Glass(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                size: 14,
                color: isPositive ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 4),
              Text(
                trend,
                style: TextStyle(
                  fontSize: 12,
                  color: isPositive ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActiveProjects extends StatelessWidget {
  const _ActiveProjects();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'پروژه‌های فعال',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        ...[
          ('توسعه اپلیکیشن موبایل', 'در حال انجام', BenvisTheme.blue),
          ('طراحی وبسایت', 'بررسی نهایی', Colors.orange),
          ('کمپین مارکتینگ', 'آماده راه‌اندازی', BenvisTheme.purple),
        ].map((project) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: project.$3,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.$1,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          project.$2,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

