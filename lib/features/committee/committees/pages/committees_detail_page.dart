import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/committees_repository.dart';
import '../models/committee_model.dart';

class CommitteeCommitteeDetailPage extends ConsumerWidget {
  final String id;
  const CommitteeCommitteeDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(committeeCommitteeDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/committee/committees/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<CommitteeCommittee>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('CommitteeName'), subtitle: Text(item.committeeName.toString())),
              ListTile(title: Text('CommitteeType'), subtitle: Text(item.committeeType.toString())),
              ListTile(title: Text('FormationDate'), subtitle: Text(item.formationDate.toString())),
              ListTile(title: Text('ValidityPeriod'), subtitle: Text(item.validityPeriod.toString())),
              ListTile(title: Text('DissolutionDate'), subtitle: Text(item.dissolutionDate.toString())),
              ListTile(title: Text('CommitteeObjective'), subtitle: Text(item.committeeObjective.toString())),
              ListTile(title: Text('CommitteeStatus'), subtitle: Text(item.committeeStatus.toString())),
              ListTile(title: Text('CharterFileId'), subtitle: Text(item.charterFileId.toString())),
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
