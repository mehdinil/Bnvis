import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/journal/data/local/hive_boxes.dart';
import 'features/journal/ui/app_shell.dart';
import 'features/journal/ui/pages/auth_page.dart';
import 'features/journal/models/goal.dart';
import 'features/journal/models/task.dart';
import 'features/journal/models/habit.dart';
import 'features/journal/models/journal_entry.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register adapters
  Hive
    ..registerAdapter(GoalStatusAdapter())
    ..registerAdapter(GoalAdapter())
    ..registerAdapter(TaskAdapter())
    ..registerAdapter(HabitFrequencyAdapter())
    ..registerAdapter(HabitAdapter())
    ..registerAdapter(JournalEntryAdapter());

  // Open boxes
  await Future.wait([
    Hive.openBox<Goal>(HiveBoxes.goals),
    Hive.openBox<Task>(HiveBoxes.tasks),
    Hive.openBox<Habit>(HiveBoxes.habits),
    Hive.openBox<JournalEntry>(HiveBoxes.journal),
  ]);

  runApp(const ProviderScope(child: GoalPadApp()));
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isAuthenticated = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isAuth = prefs.getBool('is_authenticated') ?? false;
    
    setState(() {
      _isAuthenticated = isAuth;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return _isAuthenticated ? const AppShell() : const AuthPage();
  }
}

class GoalPadApp extends StatelessWidget {
  const GoalPadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoalPad',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa'), // Persian
        Locale('en'), // English
        Locale('es'), // Spanish
        Locale('fr'), // French
        Locale('de'), // German
        Locale('ar'), // Arabic
        Locale('zh'), // Chinese (Simplified)
        Locale('ru'), // Russian
      ],
      home: const AuthWrapper(),
    );
  }
}
