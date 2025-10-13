import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import '../../models/goal.dart';
import '../../models/task.dart';
import '../../models/habit.dart';
import '../../models/journal_entry.dart';
import 'hive_boxes.dart';

/// Service for exporting and importing all app data as JSON
class DataExportService {
  /// Export all data to JSON file and share it
  static Future<ExportResult> exportData() async {
    try {
      // Get all boxes
      final goalsBox = Hive.box<Goal>(HiveBoxes.goals);
      final tasksBox = Hive.box<Task>(HiveBoxes.tasks);
      final habitsBox = Hive.box<Habit>(HiveBoxes.habits);
      final journalBox = Hive.box<JournalEntry>(HiveBoxes.journal);

      // Serialize all data
      final exportData = {
        'version': '1.0.0',
        'exportDate': DateTime.now().toIso8601String(),
        'data': {
          'goals': goalsBox.values.map((g) => g.toJson()).toList(),
          'tasks': tasksBox.values.map((t) => t.toJson()).toList(),
          'habits': habitsBox.values.map((h) => h.toJson()).toList(),
          'journal': journalBox.values.map((j) => j.toJson()).toList(),
        },
        'metadata': {
          'totalGoals': goalsBox.length,
          'totalTasks': tasksBox.length,
          'totalHabits': habitsBox.length,
          'totalJournalEntries': journalBox.length,
        },
      };

      // Convert to JSON string with pretty print
      final jsonString = const JsonEncoder.withIndent('  ').convert(exportData);

      // Get temp directory and create file
      final tempDir = await getTemporaryDirectory();
      final fileName = 'tablo_backup_${DateTime.now().millisecondsSinceEpoch}.json';
      final file = File('${tempDir.path}/$fileName');
      await file.writeAsString(jsonString);

      // Share the file
      final result = await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'Tablo Data Backup',
        text: 'Your Tablo data export from ${DateTime.now().toString().split('.')[0]}',
      );

      return ExportResult(
        success: true,
        message: 'Data exported successfully!',
        itemsExported: goalsBox.length + tasksBox.length + habitsBox.length + journalBox.length,
      );
    } catch (e, stackTrace) {
      debugPrint('Export error: $e\n$stackTrace');
      return ExportResult(
        success: false,
        message: 'Export failed: ${e.toString()}',
      );
    }
  }

  /// Import data from JSON file with smart merge (no overwrite)
  static Future<ImportResult> importData() async {
    try {
      // Pick file
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) {
        return ImportResult(
          success: false,
          message: 'No file selected',
        );
      }

      // Read file content
      final filePath = result.files.single.path;
      if (filePath == null) {
        return ImportResult(
          success: false,
          message: 'Could not read file path',
        );
      }

      final file = File(filePath);
      final jsonString = await file.readAsString();
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

      // Validate format
      if (!jsonData.containsKey('data') || !jsonData.containsKey('version')) {
        return ImportResult(
          success: false,
          message: 'Invalid backup file format',
        );
      }

      final data = jsonData['data'] as Map<String, dynamic>;
      int imported = 0;
      int skipped = 0;

      // Get boxes
      final goalsBox = Hive.box<Goal>(HiveBoxes.goals);
      final tasksBox = Hive.box<Task>(HiveBoxes.tasks);
      final habitsBox = Hive.box<Habit>(HiveBoxes.habits);
      final journalBox = Hive.box<JournalEntry>(HiveBoxes.journal);

      // Import goals (merge, don't overwrite)
      if (data.containsKey('goals')) {
        final goals = data['goals'] as List<dynamic>;
        for (final goalJson in goals) {
          try {
            final goal = Goal.fromJson(goalJson as Map<String, dynamic>);
            if (!goalsBox.containsKey(goal.id)) {
              await goalsBox.put(goal.id, goal);
              imported++;
            } else {
              skipped++;
            }
          } catch (e) {
            debugPrint('Error importing goal: $e');
          }
        }
      }

      // Import tasks
      if (data.containsKey('tasks')) {
        final tasks = data['tasks'] as List<dynamic>;
        for (final taskJson in tasks) {
          try {
            final task = Task.fromJson(taskJson as Map<String, dynamic>);
            if (!tasksBox.containsKey(task.id)) {
              await tasksBox.put(task.id, task);
              imported++;
            } else {
              skipped++;
            }
          } catch (e) {
            debugPrint('Error importing task: $e');
          }
        }
      }

      // Import habits
      if (data.containsKey('habits')) {
        final habits = data['habits'] as List<dynamic>;
        for (final habitJson in habits) {
          try {
            final habit = Habit.fromJson(habitJson as Map<String, dynamic>);
            if (!habitsBox.containsKey(habit.id)) {
              await habitsBox.put(habit.id, habit);
              imported++;
            } else {
              skipped++;
            }
          } catch (e) {
            debugPrint('Error importing habit: $e');
          }
        }
      }

      // Import journal entries
      if (data.containsKey('journal')) {
        final entries = data['journal'] as List<dynamic>;
        for (final entryJson in entries) {
          try {
            final entry = JournalEntry.fromJson(entryJson as Map<String, dynamic>);
            if (!journalBox.containsKey(entry.id)) {
              await journalBox.put(entry.id, entry);
              imported++;
            } else {
              skipped++;
            }
          } catch (e) {
            debugPrint('Error importing journal entry: $e');
          }
        }
      }

      return ImportResult(
        success: true,
        message: 'Import completed!',
        itemsImported: imported,
        itemsSkipped: skipped,
      );
    } catch (e, stackTrace) {
      debugPrint('Import error: $e\n$stackTrace');
      return ImportResult(
        success: false,
        message: 'Import failed: ${e.toString()}',
      );
    }
  }

  /// Get statistics about current data
  static Map<String, int> getDataStats() {
    return {
      'goals': Hive.box<Goal>(HiveBoxes.goals).length,
      'tasks': Hive.box<Task>(HiveBoxes.tasks).length,
      'habits': Hive.box<Habit>(HiveBoxes.habits).length,
      'journal': Hive.box<JournalEntry>(HiveBoxes.journal).length,
    };
  }
}

/// Result of export operation
class ExportResult {
  final bool success;
  final String message;
  final int? itemsExported;

  ExportResult({
    required this.success,
    required this.message,
    this.itemsExported,
  });
}

/// Result of import operation
class ImportResult {
  final bool success;
  final String message;
  final int? itemsImported;
  final int? itemsSkipped;

  ImportResult({
    required this.success,
    required this.message,
    this.itemsImported,
    this.itemsSkipped,
  });
}


