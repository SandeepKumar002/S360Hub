import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/log_history_repository.dart';
import '../models/log_history_model.dart';

class CommitteeLogHistoryDetailPage extends ConsumerWidget {
  final String id;
  const CommitteeLogHistoryDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(committeeLogHistoryDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/committee/log-history/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<CommitteeLogHistory>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('SchemaName'), subtitle: Text(item.schemaName.toString())),
              ListTile(title: Text('TableName'), subtitle: Text(item.tableName.toString())),
              ListTile(title: Text('RecordId'), subtitle: Text(item.recordId.toString())),
              ListTile(title: Text('Operation'), subtitle: Text(item.operation.toString())),
              ListTile(title: Text('ChangedBy'), subtitle: Text(item.changedBy.toString())),
              ListTile(title: Text('ChangedById'), subtitle: Text(item.changedById.toString())),
              ListTile(title: Text('ChangedAt'), subtitle: Text(item.changedAt.toString())),
              ListTile(title: Text('OldData'), subtitle: Text(item.oldData.toString())),
              ListTile(title: Text('NewData'), subtitle: Text(item.newData.toString())),
              ListTile(title: Text('Comment'), subtitle: Text(item.comment.toString())),
              ListTile(title: Text('Metadata'), subtitle: Text(item.metadata.toString())),
              ListTile(title: Text('ChangedFields'), subtitle: Text(item.changedFields.toString())),
              ListTile(title: Text('IpAddress'), subtitle: Text(item.ipAddress.toString())),
              ListTile(title: Text('UserAgent'), subtitle: Text(item.userAgent.toString())),
              ListTile(title: Text('SessionId'), subtitle: Text(item.sessionId.toString())),
              ListTile(title: Text('RequestId'), subtitle: Text(item.requestId.toString())),
            ],
          );
        },
      ),
    );
  }
}
