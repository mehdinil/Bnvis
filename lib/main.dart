import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  runApp(const ProviderScope(child: GoalPadApp()));
}

class GoalPadApp extends StatelessWidget {
  const GoalPadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoalPad',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const AppShell(),
    );
  }
}

