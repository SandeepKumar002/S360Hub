import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'async_value_widget.dart';
import 'package:intl/intl.dart';

class LogEntry {
  final String id;
  final String action;
  final DateTime createdAt;
  final Map<String, dynamic> changedFields;
  final String? performedBy;

  LogEntry({
    required this.id,
    required this.action,
    required this.createdAt,
    required this.changedFields,
    this.performedBy,
  });

  factory LogEntry.fromJson(Map<String, dynamic> json) {
    return LogEntry(
      id: json['id'] as String,
      action: json['action'] as String? ?? 'UNKNOWN',
      createdAt: DateTime.parse(json['created_at'] as String),
      changedFields: json['changes'] as Map<String, dynamic>? ?? {},
      performedBy: json['performed_by'] as String?,
    );
  }
}

final logHistoryProvider = FutureProvider.family<List<LogEntry>, ({String table, String recordId})>((ref, params) async {
  final supabase = Supabase.instance.client;
  
  // Extract schema from table name e.g. 'nexus.persons' -> schema 'nexus', table 'persons' (not used query directly against log_history)
  final parts = params.table.split('.');
  final schema = parts.length > 1 ? parts[0] : 'public';
  
  final response = await supabase
      .from('$schema.log_history') 
      .select()
      .eq('record_id', params.recordId) 
      .order('created_at', ascending: false);

  return (response as List).map((e) => LogEntry.fromJson(e)).toList();
});

class LogHistoryWidget extends ConsumerWidget {
  final String tableName; 
  final String recordId;

  const LogHistoryWidget({
    super.key,
    required this.tableName,
    required this.recordId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(logHistoryProvider((table: tableName, recordId: recordId)));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Audit Log',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            AsyncValueWidget<List<LogEntry>>(
              value: historyAsync,
              data: (logs) {
                if (logs.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('No history available.'),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: logs.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final log = logs[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _getActionColor(log.action),
                        radius: 16,
                        child: Icon(_getActionIcon(log.action), size: 16, color: Colors.white),
                      ),
                      title: Text(log.action),
                      subtitle: Text(
                        '${DateFormat.yMMMd().add_jm().format(log.createdAt.toLocal())}\n${log.performedBy ?? "Unknown User"}',
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getActionColor(String action) {
    switch (action.toUpperCase()) {
      case 'CREATE':
      case 'INSERT':
        return Colors.green;
      case 'UPDATE':
        return Colors.blue;
      case 'DELETE':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getActionIcon(String action) {
    switch (action.toUpperCase()) {
      case 'CREATE':
      case 'INSERT':
        return Icons.add;
      case 'UPDATE':
        return Icons.edit;
      case 'DELETE':
        return Icons.delete;
      default:
        return Icons.info;
    }
  }
}
