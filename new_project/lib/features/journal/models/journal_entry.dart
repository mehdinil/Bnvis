import 'package:hive/hive.dart';
part 'journal_entry.g.dart';

@HiveType(typeId: 6)
class JournalEntry extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  DateTime date;
  @HiveField(2)
  int mood; // 1..5
  @HiveField(3)
  String text;
  @HiveField(4)
  List<String> tags;

  JournalEntry({
    required this.id,
    required this.date,
    required this.mood,
    required this.text,
    List<String>? tags,
  }) : tags = tags ?? [];
}

