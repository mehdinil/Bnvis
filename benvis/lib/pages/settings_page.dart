import 'package:flutter/material.dart';
import '../widgets/glass.dart';
import '../theme.dart';

/// صفحه تنظیمات
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '⚙️ تنظیمات',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 24),

            // پروفایل
            const Glass(
              child: _ProfileSection(),
            ),
            const SizedBox(height: 16),

            // تنظیمات عمومی
            const Glass(
              child: _GeneralSettings(),
            ),
            const SizedBox(height: 16),

            // درباره
            const Glass(
              child: _AboutSection(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: BenvisTheme.purple.withOpacity(0.2),
          child: const Icon(Icons.person, size: 40, color: BenvisTheme.purple),
        ),
        const SizedBox(height: 12),
        const Text(
          'کاربر بنویس',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(
          'user@benvis.app',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.edit),
          label: const Text('ویرایش پروفایل'),
          style: ElevatedButton.styleFrom(
            backgroundColor: BenvisTheme.purple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}

class _GeneralSettings extends StatelessWidget {
  const _GeneralSettings();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'عمومی',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        ...[
          (Icons.language, 'زبان', 'فارسی'),
          (Icons.notifications_outlined, 'اعلان‌ها', 'فعال'),
          (Icons.dark_mode_outlined, 'حالت تاریک', 'فعال'),
          (Icons.lock_outline, 'امنیت', 'قفل با اثر انگشت'),
        ].map((item) => _SettingItem(
              icon: item.$1,
              title: item.$2,
              value: item.$3,
            )),
      ],
    );
  }
}

class _SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _SettingItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 24, color: BenvisTheme.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title, style: const TextStyle(fontSize: 16)),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, size: 20),
        ],
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'درباره',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('نسخه'),
            Text(
              '1.0.1 (2)',
              style: TextStyle(color: Colors.white.withOpacity(0.6)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('پکیج'),
            Text(
              'com.benvis.app',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            '© 2025 Benvis Life OS',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.4),
            ),
          ),
        ),
      ],
    );
  }
}

