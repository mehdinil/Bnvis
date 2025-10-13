import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../logic/providers.dart';
import '../../models/journal_entry.dart';
import '../widgets/entry_editor.dart';

class JournalPage extends ConsumerWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = DateTime.now();
    final entries = ref.watch(journalProvider);
    final todayEntries = entries.where((entry) {
      final entryDate = DateTime(entry.date.year, entry.date.month, entry.date.day);
      final todayDate = DateTime(today.year, today.month, today.day);
      return entryDate == todayDate;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Journal')),
      body: ListView.builder(
        itemCount: todayEntries.length,
        itemBuilder: (_, i) => _JournalEntryTile(entry: todayEntries[i]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const EntryEditor(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _JournalEntryTile extends ConsumerWidget {
  final JournalEntry entry;
  const _JournalEntryTile({required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        title: Text(entry.text),
        subtitle: Text('Mood: ${entry.mood}/5 • ${entry.date.toString().split(' ')[0]}'),
        trailing: PopupMenuButton<String>(
          onSelected: (v) async {
            if (v == 'edit') {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EntryEditor(entry: entry),
                ),
              );
            } else if (v == 'delete') {
              await ref.read(journalProvider.notifier).remove(entry.id);
            }
          },
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'edit', child: Text('Edit')),
            PopupMenuItem(value: 'delete', child: Text('Delete')),
          ],
        ),
      ),
    );
  }
}
