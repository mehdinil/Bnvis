
import 'package:flutter/material.dart';
import 'views/coach_view.dart';
import 'views/home_view.dart';
import 'views/settings_view.dart';
import 'views/skills_view.dart';
import 'views/business_view.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  static const List<Widget> _views = <Widget>[
    HomeView(),
    SkillsView(),
    BusinessView(),
    CoachView(),
    SettingsView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _views.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'خانه',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            label: 'مهارت‌ها',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center),
            label: 'کسب‌وکار',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology_alt),
            label: 'کوچ AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'تنظیمات',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
