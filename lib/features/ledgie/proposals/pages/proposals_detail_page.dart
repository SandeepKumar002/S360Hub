import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/proposals_repository.dart';
import '../models/proposal_model.dart';

class LedgieProposalDetailPage extends ConsumerWidget {
  final String id;
  const LedgieProposalDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(ledgieProposalDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/ledgie/proposals/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<LedgieProposal>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('EntityId'), subtitle: Text(item.entityId.toString())),
              ListTile(title: Text('ProposalCode'), subtitle: Text(item.proposalCode.toString())),
              ListTile(title: Text('Title'), subtitle: Text(item.title.toString())),
              ListTile(title: Text('Sector'), subtitle: Text(item.sector.toString())),
              ListTile(title: Text('ProposalScope'), subtitle: Text(item.proposalScope.toString())),
              ListTile(title: Text('Status'), subtitle: Text(item.status.toString())),
              ListTile(title: Text('SubmittedDate'), subtitle: Text(item.submittedDate.toString())),
              ListTile(title: Text('ValidUntil'), subtitle: Text(item.validUntil.toString())),
              ListTile(title: Text('Remarks'), subtitle: Text(item.remarks.toString())),
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
              ListTile(title: Text('LeadsProspectId'), subtitle: Text(item.leadsProspectId.toString())),
            ],
          );
        },
      ),
    );
  }
}
