import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/committee_meetings_repository.dart';
import '../models/committee_meeting_model.dart';

class CommitteeCommitteeMeetingDetailPage extends ConsumerWidget {
  final String id;
  const CommitteeCommitteeMeetingDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(committeeCommitteeMeetingDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/committee/committee-meetings/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<CommitteeCommitteeMeeting>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('CommitteeId'), subtitle: Text(item.committeeId.toString())),
              ListTile(title: Text('MeetingNumber'), subtitle: Text(item.meetingNumber.toString())),
              ListTile(title: Text('MeetingDate'), subtitle: Text(item.meetingDate.toString())),
              ListTile(title: Text('MeetingTime'), subtitle: Text(item.meetingTime.toString())),
              ListTile(title: Text('Location'), subtitle: Text(item.location.toString())),
              ListTile(title: Text('Agenda'), subtitle: Text(item.agenda.toString())),
              ListTile(title: Text('Status'), subtitle: Text(item.status.toString())),
              ListTile(title: Text('Attendees'), subtitle: Text(item.attendees.toString())),
              ListTile(title: Text('MinutesFileId'), subtitle: Text(item.minutesFileId.toString())),
              ListTile(title: Text('Metadata'), subtitle: Text(item.metadata.toString())),
              ListTile(title: Text('CreatedAt'), subtitle: Text(item.createdAt.toString())),
              ListTile(title: Text('CreatedBy'), subtitle: Text(item.createdBy.toString())),
              ListTile(title: Text('UpdatedAt'), subtitle: Text(item.updatedAt.toString())),
              ListTile(title: Text('UpdatedBy'), subtitle: Text(item.updatedBy.toString())),
              ListTile(title: Text('ApprovedAt'), subtitle: Text(item.approvedAt.toString())),
              ListTile(title: Text('ApprovedBy'), subtitle: Text(item.approvedBy.toString())),
              ListTile(title: Text('DeletedAt'), subtitle: Text(item.deletedAt.toString())),
              ListTile(title: Text('DeletedBy'), subtitle: Text(item.deletedBy.toString())),
              ListTile(title: Text('DeleteType'), subtitle: Text(item.deleteType.toString())),
              ListTile(title: Text('IsDeleted'), subtitle: Text(item.isDeleted.toString())),
            ],
          );
        },
      ),
    );
  }
}
