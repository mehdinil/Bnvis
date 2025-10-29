import 'package:flutter/material.dart';
import '../../services/profile_service.dart';
import '../../models/user_profile.dart';
import '../../theme.dart';
import '../../widgets/glass.dart';

/// ویزارد آن‌بوردینگ هوشمند ۷ مرحله‌ای
class SmartOnboardingWizard extends StatefulWidget {
  const SmartOnboardingWizard({super.key});

  @override
  State<SmartOnboardingWizard> createState() => _SmartOnboardingWizardState();
}

class _SmartOnboardingWizardState extends State<SmartOnboardingWizard> {
  final _pageController = PageController();
  final _service = ProfileService();
  int _currentPage = 0;

  // داده‌های جمع‌آوری شده
  String _name = '';
  String _mainGoal = '';
  List<String> _habits = [];
  List<String> _skills = [];
  TimeOfDay _sleepTime = const TimeOfDay(hour: 23, minute: 0);
  TimeOfDay _wakeTime = const TimeOfDay(hour: 7, minute: 0);
  String _theme = 'neon';
  String _userType = 'student';

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 6) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _complete();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _complete() async {
    final profile = UserProfile(
      fullName: _name.isEmpty ? 'کاربر' : _name,
      mainGoal: _mainGoal.isEmpty ? null : _mainGoal,
      favoriteHabits: _habits.isEmpty ? null : _habits,
      skillsToLearn: _skills.isEmpty ? null : _skills,
      sleepTime: '${_sleepTime.hour.toString().padLeft(2, '0')}:${_sleepTime.minute.toString().padLeft(2, '0')}',
      wakeTime: '${_wakeTime.hour.toString().padLeft(2, '0')}:${_wakeTime.minute.toString().padLeft(2, '0')}',
      userType: _userType,
      themeName: _theme,
    );

    await _service.saveProfile(profile);
    await _service.setOnboarded(true);

    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Padding(
              padding: const EdgeInsets.all(16),
              child: LinearProgressIndicator(
                value: (_currentPage + 1) / 7,
                backgroundColor: Colors.white.withOpacity(0.1),
                valueColor: const AlwaysStoppedAnimation(BenvisTheme.purple),
              ),
            ),

            // PageView
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                children: [
                  _buildWelcomePage(),
                  _buildNamePage(),
                  _buildHabitsPage(),
                  _buildSkillsPage(),
                  _buildRoutinePage(),
                  _buildThemePage(),
                  _buildUserTypePage(),
                ],
              ),
            ),

            // Navigation buttons
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    OutlinedButton(
                      onPressed: _previousPage,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text('قبلی'),
                    ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BenvisTheme.purple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: Text(_currentPage == 6 ? 'شروع کنیم!' : 'ادامه'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomePage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.rocket_launch, size: 100, color: BenvisTheme.purple),
            const SizedBox(height: 32),
            const Text(
              '🌟 به بنویس خوش آمدید!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            Text(
              'سیستم هوشمند مدیریت زندگی',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.7)),
            ),
            const SizedBox(height: 48),
            const Text(
              'بذار با چند سوال ساده، اپت رو شخصی‌سازی کنیم',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNamePage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'اسم شما چیه؟',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 32),
            Glass(
              child: TextField(
                autofocus: true,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  hintText: 'نام و نام خانوادگی',
                  border: InputBorder.none,
                ),
                onChanged: (value) => _name = value,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'هدف اصلی شما در زندگی چیه؟',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Glass(
              child: TextField(
                textAlign: TextAlign.center,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: 'مثال: موفقیت در کار و داشتن زندگی سالم',
                  border: InputBorder.none,
                ),
                onChanged: (value) => _mainGoal = value,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHabitsPage() {
    final habitOptions = [
      '📚 مطالعه',
      '🏃‍♂️ ورزش',
      '🧘‍♀️ مدیتیشن',
      '💧 نوشیدن آب',
      '😴 خواب منظم',
      '🥗 غذای سالم',
      '📝 یادداشت‌برداری',
      '🎨 خلاقیت',
    ];

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '۳ عادت روزانه که می‌خوای داشته باشی؟',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: habitOptions.map((habit) {
                final isSelected = _habits.contains(habit);
                return ChoiceChip(
                  label: Text(habit),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected && _habits.length < 3) {
                        _habits.add(habit);
                      } else if (!selected) {
                        _habits.remove(habit);
                      }
                    });
                  },
                  selectedColor: BenvisTheme.purple.withOpacity(0.3),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsPage() {
    final skillOptions = [
      '💻 برنامه‌نویسی',
      '🗣️ زبان انگلیسی',
      '🎨 طراحی UI/UX',
      '📊 تحلیل داده',
      '✍️ نویسندگی',
      '🎵 موسیقی',
      '📷 عکاسی',
      '🧠 هوش مصنوعی',
    ];

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'چه مهارتی می‌خوای یاد بگیری؟',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: skillOptions.map((skill) {
                final isSelected = _skills.contains(skill);
                return ChoiceChip(
                  label: Text(skill),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _skills.add(skill);
                      } else {
                        _skills.remove(skill);
                      }
                    });
                  },
                  selectedColor: BenvisTheme.blue.withOpacity(0.3),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoutinePage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'روتین خواب شما چطوره؟',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 48),
            Glass(
              child: ListTile(
                leading: const Icon(Icons.nightlight_round),
                title: const Text('ساعت خواب'),
                trailing: TextButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: _sleepTime,
                    );
                    if (time != null) {
                      setState(() => _sleepTime = time);
                    }
                  },
                  child: Text(
                    '${_sleepTime.hour}:${_sleepTime.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Glass(
              child: ListTile(
                leading: const Icon(Icons.wb_sunny),
                title: const Text('ساعت بیداری'),
                trailing: TextButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: _wakeTime,
                    );
                    if (time != null) {
                      setState(() => _wakeTime = time);
                    }
                  },
                  child: Text(
                    '${_wakeTime.hour}:${_wakeTime.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemePage() {
    final themes = [
      {'name': 'neon', 'title': 'Neon Blue', 'color': BenvisTheme.blue},
      {'name': 'purple', 'title': 'Purple Dream', 'color': BenvisTheme.purple},
      {'name': 'minimal', 'title': 'Minimal Dark', 'color': Colors.grey},
      {'name': 'light', 'title': 'Light Mode', 'color': Colors.white70},
    ];

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'تم مورد علاقه؟',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: themes.map((theme) {
                final isSelected = _theme == theme['name'];
                return GestureDetector(
                  onTap: () => setState(() => _theme = theme['name'] as String),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: (theme['color'] as Color).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? (theme['color'] as Color) : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.palette,
                            color: theme['color'] as Color,
                            size: 40,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            theme['title'] as String,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserTypePage() {
    final types = [
      {'type': 'student', 'icon': Icons.school, 'title': '🎓 دانشجو'},
      {'type': 'employee', 'icon': Icons.business_center, 'title': '💼 کارمند'},
      {'type': 'freelancer', 'icon': Icons.laptop, 'title': '💻 فریلنسر'},
      {'type': 'manager', 'icon': Icons.rocket_launch, 'title': '🚀 مدیر/کارآفرین'},
    ];

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'شما کی هستید؟',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 32),
            ...types.map((type) {
              final isSelected = _userType == type['type'];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GestureDetector(
                  onTap: () => setState(() => _userType = type['type'] as String),
                  child: Glass(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(
                          type['icon'] as IconData,
                          size: 32,
                          color: isSelected ? BenvisTheme.purple : Colors.white,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          type['title'] as String,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                        const Spacer(),
                        if (isSelected)
                          const Icon(Icons.check_circle, color: BenvisTheme.purple),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
