import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/committee_members_repository.dart';
import '../models/committee_member_model.dart';

class CommitteeCommitteeMemberDetailPage extends ConsumerWidget {
  final String id;
  const CommitteeCommitteeMemberDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(committeeCommitteeMemberDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/committee/committee-members/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<CommitteeCommitteeMember>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('CommitteeId'), subtitle: Text(item.committeeId.toString())),
              ListTile(title: Text('PersonId'), subtitle: Text(item.personId.toString())),
              ListTile(title: Text('MemberRole'), subtitle: Text(item.memberRole.toString())),
              ListTile(title: Text('AppointmentDate'), subtitle: Text(item.appointmentDate.toString())),
              ListTile(title: Text('TermEndDate'), subtitle: Text(item.termEndDate.toString())),
              ListTile(title: Text('IsActive'), subtitle: Text(item.isActive.toString())),
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
