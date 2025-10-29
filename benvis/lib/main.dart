import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'config/app_config.dart';
import 'services/profile_service.dart';
import 'models/user_profile.dart';
import 'theme.dart';
import 'screens/onboarding/smart_onboarding_wizard.dart';
import 'screens/profile/profile_edit_screen.dart';
import 'pages/home_page.dart';
import 'modules/goals/goals_screen.dart';
import 'modules/habits/habits_screen.dart';
import 'modules/journal/journal_screen.dart';
import 'pages/settings_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BenvisApp());
}

class BenvisApp extends StatelessWidget {
  const BenvisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Benvis',
      theme: BenvisTheme.dark,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', 'IR'), // فارسی
        Locale('en', 'US'), // انگلیسی
      ],
      locale: const Locale('fa', 'IR'),
      // RTL support
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      routes: {
        '/': (context) => const _Root(),
        '/profile-edit': (context) => const ProfileEditScreen(),
      },
      home: const _Root(),
    );
  }
}

/// روت اصلی - تصمیم‌گیری بین Onboarding و Home
class _Root extends StatefulWidget {
  const _Root();

  @override
  State<_Root> createState() => _RootState();
}

class _RootState extends State<_Root> {
  final _service = ProfileService();
  bool? _onboarded;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final ok = await _service.isOnboarded();
    if (!ok && kDemoMode) {
      // اگر دمو مود فعال بود و هنوز آن‌بوردینگ نشده، پروفایل میهمان بساز
      await _service.saveProfile(const UserProfile(fullName: 'کاربر میهمان'));
      await _service.setOnboarded(true);
      if (mounted) setState(() => _onboarded = true);
    } else {
      if (mounted) setState(() => _onboarded = ok);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_onboarded == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return _onboarded! ? const MainScaffold() : const SmartOnboardingWizard();
  }
}

/// اسکلت اصلی با NavigationBar و 5 تب
class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  // لیست صفحات
  final List<Widget> _pages = const [
    HomePage(),
    GoalsScreen(),
    HabitsScreen(),
    JournalScreen(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'خانه',
          ),
          NavigationDestination(
            icon: Icon(Icons.flag_outlined),
            selectedIcon: Icon(Icons.flag),
            label: 'اهداف',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline),
            selectedIcon: Icon(Icons.check_circle),
            label: 'عادات',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_outlined),
            selectedIcon: Icon(Icons.book),
            label: 'ژورنال',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'تنظیمات',
          ),
        ],
      ),
    );
  }
}
