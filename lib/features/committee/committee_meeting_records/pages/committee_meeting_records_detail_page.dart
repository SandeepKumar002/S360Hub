import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/committee_meeting_records_repository.dart';
import '../models/committee_meeting_record_model.dart';

class CommitteeCommitteeMeetingRecordDetailPage extends ConsumerWidget {
  final String id;
  const CommitteeCommitteeMeetingRecordDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(committeeCommitteeMeetingRecordDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/committee/committee-meeting-records/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<CommitteeCommitteeMeetingRecord>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('MeetingId'), subtitle: Text(item.meetingId.toString())),
              ListTile(title: Text('AgendaItem'), subtitle: Text(item.agendaItem.toString())),
              ListTile(title: Text('Discussion'), subtitle: Text(item.discussion.toString())),
              ListTile(title: Text('Decision'), subtitle: Text(item.decision.toString())),
              ListTile(title: Text('ActionItems'), subtitle: Text(item.actionItems.toString())),
              ListTile(title: Text('ResponsiblePersonId'), subtitle: Text(item.responsiblePersonId.toString())),
              ListTile(title: Text('DueDate'), subtitle: Text(item.dueDate.toString())),
              ListTile(title: Text('Status'), subtitle: Text(item.status.toString())),
              ListTile(title: Text('Metadata'), subtitle: Text(item.metadata.toString())),
              ListTile(title: Text('CreatedAt'), subtitle: Text(item.createdAt.toString())),
              ListTile(title: Text('CreatedBy'), subtitle: Text(item.createdBy.toString())),
              ListTile(title: Text('UpdatedAt'), subtitle: Text(item.updatedAt.toString())),
              ListTile(title: Text('UpdatedBy'), subtitle: Text(item.updatedBy.toString())),
            ],
          );
        },
      ),
    );
  }
}
