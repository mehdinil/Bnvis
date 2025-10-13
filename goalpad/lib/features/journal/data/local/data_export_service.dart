import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:file_picker/file_picker.dart'; // REMOVED: تا زمان ارتقا به نسخه سازگار
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
  /// TODO: فعلاً غیرفعال - نیاز به file_picker سازگار با Flutter 3.35
  static Future<ImportResult> importData() async {
    // TEMPORARY: Import feature disabled until file_picker is upgraded to v8+
    return ImportResult(
      success: false,
      message: 'Import feature temporarily disabled. Please use Export for backup.',
    );
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


