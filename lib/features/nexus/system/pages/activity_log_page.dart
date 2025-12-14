import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/widgets/common/async_value_widget.dart';

class ActivityLogPage extends ConsumerWidget {
  const ActivityLogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Simple fetch directly in provider here since it's just a view
    final logsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
         final response = await Supabase.instance.client
             .from('nexus.activity_log')
             .select()
             .order('timestamp', ascending: false)
             .limit(50);
         return List<Map<String, dynamic>>.from(response);
    });
    
    final logsAsync = ref.watch(logsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('System Activity Log')),
      body: AsyncValueWidget<List<Map<String, dynamic>>>(
        value: logsAsync,
        data: (logs) {
           if (logs.isEmpty) return const Center(child: Text('No activity logs found'));
           return ListView.separated(
               itemCount: logs.length,
               separatorBuilder: (context, index) => const Divider(),
               itemBuilder: (context, index) {
                   final log = logs[index];
                   return ListTile(
                       leading: const Icon(Icons.history),
                       title: Text(log['action'] ?? 'Unknown Action'),
                       subtitle: Text('${log['module'] ?? "-"} • ${log['timestamp']}'),
                       trailing: Text(log['user_id'] ?? ''),
                   );
               },
           );
        },
      ),
    );
  }
}
