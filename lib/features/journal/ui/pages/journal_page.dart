import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../logic/providers.dart';
import '../../models/journal_entry.dart';

class JournalPage extends ConsumerWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = DateTime.now();
    final entries = ref.watch(journalProvider.notifier).getEntriesForDate(today);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Journal')),
      body: entries.isEmpty
          ? const Center(child: Text('No entries for today'))
          : ListView.builder(
              itemCount: entries.length,
              itemBuilder: (_, i) => _JournalEntryTile(entry: entries[i]),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final id = const Uuid().v4();
          final entry = JournalEntry(
            id: id,
            date: today,
            mood: 3,
            text: 'New journal entry',
          );
          await ref.read(journalProvider.notifier).add(entry);
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
        subtitle: Text('Mood: ${entry.mood}/5'),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => ref.read(journalProvider.notifier).remove(entry.id),
        ),
      ),
    );
  }
}

