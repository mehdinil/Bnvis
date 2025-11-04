
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/journal/data/local/hive_boxes.dart';
import 'features/journal/ui/app_shell.dart';
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

  runApp(const ProviderScope(child: BenevisApp()));
}

class BenevisApp extends StatelessWidget {
  const BenevisApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color deepViolet = Color(0xFF1B1335);
    const Color neonBlue = Color(0xFF41C9E2);
    const Color electricMagenta = Color(0xFFC94FF7);
    const Color whiteText = Colors.white;

    final textTheme = Theme.of(context).textTheme.apply(
          bodyColor: whiteText,
          displayColor: whiteText,
          fontFamily: GoogleFonts.vazirmatn().fontFamily,
        );

    return MaterialApp(
      title: 'Benevis | Life OS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: deepViolet,
        colorScheme: const ColorScheme.dark(
          primary: neonBlue,
          secondary: electricMagenta,
          background: deepViolet,
          surface: deepViolet,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onBackground: whiteText,
          onSurface: whiteText,
          error: Color(0xFFF24C4C),
          onError: Colors.black,
        ),
        textTheme: GoogleFonts.vazirmatnTextTheme(textTheme),
        appBarTheme: AppBarTheme(
          backgroundColor: deepViolet,
          elevation: 0,
          titleTextStyle: GoogleFonts.vazirmatn(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: whiteText,
          ),
          iconTheme: const IconThemeData(color: neonBlue),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: deepViolet.withOpacity(0.9),
          selectedItemColor: neonBlue,
          unselectedItemColor: Colors.grey[400],
          elevation: 8,
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF2A1B4D),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: electricMagenta,
          foregroundColor: Colors.white,
        ),
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      home: const AppShell(),
    );
  }
}
