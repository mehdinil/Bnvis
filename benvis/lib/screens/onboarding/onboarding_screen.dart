import 'package:flutter/material.dart';
import '../../config/app_config.dart';
import '../../services/profile_service.dart';
import '../../models/user_profile.dart';
import '../../theme.dart';
import '../../widgets/glass.dart';

/// صفحه خوش‌آمدگویی و ورود پروفایل
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _service = ProfileService();
  bool _loading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _continueAsGuest() async {
    setState(() => _loading = true);
    try {
      await _service.saveProfile(const UserProfile(fullName: 'کاربر میهمان'));
      await _service.setOnboarded(true);
      if (mounted) {
        // رفرش اپ
        Navigator.of(context).pushReplacementNamed('/');
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      final profile = UserProfile(
        fullName: _nameCtrl.text.trim(),
        email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
        phone: _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
      );
      await _service.saveProfile(profile);
      await _service.setOnboarded(true);
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/');
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                // لوگو/عنوان
                const Icon(Icons.rocket_launch, size: 80, color: BenvisTheme.purple),
                const SizedBox(height: 24),
                const Text(
                  'به بنویس خوش آمدید!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                Text(
                  'سامانه هوشمند مدیریت زندگی',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 40),

                // فرم ورود
                Glass(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameCtrl,
                        enabled: !_loading,
                        decoration: const InputDecoration(
                          labelText: 'نام و نام خانوادگی',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (v) =>
                            (v?.trim().isEmpty ?? true) ? 'نام را وارد کنید' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailCtrl,
                        enabled: !_loading,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'ایمیل (اختیاری)',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _phoneCtrl,
                        enabled: !_loading,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'تلفن (اختیاری)',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // دکمه شروع
                ElevatedButton(
                  onPressed: _loading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BenvisTheme.purple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('شروع کنیم', style: TextStyle(fontSize: 16)),
                ),

                // دکمه میهمان (فقط در دمو مود یا همیشه)
                if (kDemoMode || true) ...[
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: _loading ? null : _continueAsGuest,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'استفاده به‌صورت میهمان',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
