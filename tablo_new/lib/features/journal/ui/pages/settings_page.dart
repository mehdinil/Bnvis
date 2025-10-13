import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/local/data_export_service.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool _isExporting = false;
  bool _isImporting = false;
  Map<String, int>? _stats;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  void _loadStats() {
    setState(() {
      _stats = DataExportService.getDataStats();
    });
  }

  Future<void> _handleExport() async {
    setState(() => _isExporting = true);
    
    try {
      final result = await DataExportService.exportData();
      
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                result.success ? Icons.check_circle : Icons.error,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.success ? 'Export Successful!' : 'Export Failed',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (result.itemsExported != null)
                      Text('${result.itemsExported} items exported'),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: result.success ? Colors.green : Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }

  Future<void> _handleImport() async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.upload_file),
        title: const Text('Import Data'),
        content: const Text(
          'This will import data from a backup file. Existing items with the same ID will be kept (no overwrite).\n\nContinue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Import'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isImporting = true);

    try {
      final result = await DataExportService.importData();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                result.success ? Icons.check_circle : Icons.error,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.success ? 'Import Successful!' : 'Import Failed',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (result.itemsImported != null)
                      Text('${result.itemsImported} items imported'),
                    if (result.itemsSkipped != null && result.itemsSkipped! > 0)
                      Text('${result.itemsSkipped} items skipped (already exist)'),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: result.success ? Colors.green : Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 5),
        ),
      );

      // Refresh stats after successful import
      if (result.success) {
        _loadStats();
      }
    } finally {
      if (mounted) {
        setState(() => _isImporting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(
                    Icons.settings_rounded,
                    size: 64,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tablo Settings',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Manage your data and preferences',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Data Statistics Section
          Text(
            'DATA OVERVIEW',
            style: theme.textTheme.labelLarge?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          if (_stats != null) ...[
            _buildStatCard(
              icon: Icons.flag_rounded,
              label: 'Goals',
              count: _stats!['goals']!,
              color: Colors.blue,
            ),
            const SizedBox(height: 8),
            _buildStatCard(
              icon: Icons.task_rounded,
              label: 'Tasks',
              count: _stats!['tasks']!,
              color: Colors.orange,
            ),
            const SizedBox(height: 8),
            _buildStatCard(
              icon: Icons.check_circle_rounded,
              label: 'Habits',
              count: _stats!['habits']!,
              color: Colors.green,
            ),
            const SizedBox(height: 8),
            _buildStatCard(
              icon: Icons.edit_note_rounded,
              label: 'Journal Entries',
              count: _stats!['journal']!,
              color: Colors.purple,
            ),
          ],

          const SizedBox(height: 32),

          // Backup & Restore Section
          Text(
            'BACKUP & RESTORE',
            style: theme.textTheme.labelLarge?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Export Button
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: colorScheme.primaryContainer,
                child: Icon(
                  Icons.download_rounded,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              title: const Text('Export Data'),
              subtitle: const Text('Save all your data to a JSON file'),
              trailing: _isExporting
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
              onTap: _isExporting ? null : _handleExport,
            ),
          ),

          const SizedBox(height: 8),

          // Import Button
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: colorScheme.secondaryContainer,
                child: Icon(
                  Icons.upload_rounded,
                  color: colorScheme.onSecondaryContainer,
                ),
              ),
              title: const Text('Import Data'),
              subtitle: const Text('Restore from a backup file'),
              trailing: _isImporting
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
              onTap: _isImporting ? null : _handleImport,
            ),
          ),

          const SizedBox(height: 32),

          // Info Card
          Card(
            color: colorScheme.surfaceVariant.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Your data is stored locally on your device. Export regularly to keep backups safe!',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Version Info
          Center(
            child: Text(
              'Tablo v1.0.0',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required int count,
    required Color color,
  }) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(label),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            count.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}


