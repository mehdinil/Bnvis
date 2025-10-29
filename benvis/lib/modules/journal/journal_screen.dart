import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:intl/intl.dart';
import '../../core/models/journal_entry.dart';
import '../../core/services/isar_service.dart';
import '../../core/services/ai_coach_service.dart';
import '../../theme.dart';
import '../../widgets/glass.dart';

/// صفحه ژورنال
class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  late Isar _isar;
  List<JournalEntry> _entries = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    _isar = await IsarService.getInstance();
    final entries = await _isar.journalEntrys.where().sortByDateDesc().findAll();
    setState(() {
      _entries = entries;
      _loading = false;
    });
  }

  Future<void> _addEntry() async {
    final result = await Navigator.push<JournalEntry>(
      context,
      MaterialPageRoute(builder: (context) => const JournalEntryScreen()),
    );

    if (result != null) {
      await _isar.writeTxn(() async {
        await _isar.journalEntrys.put(result);
      });
      _loadEntries();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ژورنال'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _entries.isEmpty
              ? _buildEmptyState()
              : _buildEntriesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEntry,
        backgroundColor: BenvisTheme.purple,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.book_outlined, size: 80, color: Colors.white.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text(
            'ژورنالت خالیه!',
            style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.6)),
          ),
          const SizedBox(height: 8),
          const Text('روز امروزت رو یادداشت کن'),
        ],
      ),
    );
  }

  Widget _buildEntriesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _entries.length,
      itemBuilder: (context, index) {
        final entry = _entries[index];
        final date = DateTime.parse(entry.date);

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Glass(
            child: ListTile(
              leading: entry.mood != null
                  ? Text(_getMoodEmoji(entry.mood!), style: const TextStyle(fontSize: 32))
                  : const Icon(Icons.note),
              title: Text(
                DateFormat('d MMMM yyyy', 'fa').format(date),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    entry.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (entry.aiInsight != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: BenvisTheme.purple.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.psychology, size: 16, color: BenvisTheme.purple),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              entry.aiInsight!,
                              style: const TextStyle(fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              onTap: () async {
                final result = await Navigator.push<JournalEntry>(
                  context,
                  MaterialPageRoute(builder: (context) => JournalEntryScreen(entry: entry)),
                );

                if (result != null) {
                  await _isar.writeTxn(() async {
                    await _isar.journalEntrys.put(result);
                  });
                  _loadEntries();
                }
              },
            ),
          ),
        );
      },
    );
  }

  String _getMoodEmoji(Mood mood) {
    switch (mood) {
      case Mood.amazing:
        return '😍';
      case Mood.happy:
        return '😊';
      case Mood.neutral:
        return '😐';
      case Mood.sad:
        return '😢';
      case Mood.angry:
        return '😠';
      case Mood.tired:
        return '😴';
    }
  }
}

/// صفحه ورود/ویرایش یادداشت
class JournalEntryScreen extends StatefulWidget {
  final JournalEntry? entry;

  const JournalEntryScreen({super.key, this.entry});

  @override
  State<JournalEntryScreen> createState() => _JournalEntryScreenState();
}

class _JournalEntryScreenState extends State<JournalEntryScreen> {
  late TextEditingController _contentCtrl;
  Mood? _selectedMood;
  final _aiCoach = AiCoachService();

  @override
  void initState() {
    super.initState();
    _contentCtrl = TextEditingController(text: widget.entry?.content ?? '');
    _selectedMood = widget.entry?.mood;
  }

  @override
  void dispose() {
    _contentCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_contentCtrl.text.trim().isEmpty) return;

    final entry = widget.entry ?? JournalEntry();
    entry.date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    entry.content = _contentCtrl.text.trim();
    entry.mood = _selectedMood;
    entry.updatedAt = DateTime.now();

    // تحلیل AI
    entry.aiInsight = _aiCoach.analyzeJournal(entry.content);

    Navigator.pop(context, entry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.entry == null ? 'یادداشت جدید' : 'ویرایش'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _save,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Mood Selector
              const Text('حس امروز:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                children: Mood.values.map((mood) {
                  return GestureDetector(
                    onTap: () => setState(() => _selectedMood = mood),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: _selectedMood == mood
                            ? BenvisTheme.purple.withOpacity(0.3)
                            : Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _selectedMood == mood
                              ? BenvisTheme.purple
                              : Colors.white.withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(_getMoodEmoji(mood), style: const TextStyle(fontSize: 32)),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Content
              Glass(
                child: TextField(
                  controller: _contentCtrl,
                  maxLines: 12,
                  decoration: const InputDecoration(
                    hintText: 'امروز چطور بود؟ چه اتفاقی افتاد؟',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getMoodEmoji(Mood mood) {
    switch (mood) {
      case Mood.amazing:
        return '😍';
      case Mood.happy:
        return '😊';
      case Mood.neutral:
        return '😐';
      case Mood.sad:
        return '😢';
      case Mood.angry:
        return '😠';
      case Mood.tired:
        return '😴';
    }
  }
}
