import 'package:flutter/material.dart';
import 'pages/goals_page.dart';
import 'pages/journal_page.dart';
import 'pages/habits_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;

  final pages = const [
    GoalsPage(),
    JournalPage(),
    HabitsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.flag_outlined), label: 'Goals'),
          NavigationDestination(icon: Icon(Icons.edit_note_outlined), label: 'Journal'),
          NavigationDestination(icon: Icon(Icons.check_circle_outlined), label: 'Habits'),
        ],
      ),
    );
  }
}

