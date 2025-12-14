import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/journal_entries_repository.dart';
import '../models/journal_entrie_model.dart';

class FinacJournalEntrieDetailPage extends ConsumerWidget {
  final String id;
  const FinacJournalEntrieDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(finacJournalEntrieDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/finac/journal-entries/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<FinacJournalEntrie>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('JournalNumber'), subtitle: Text(item.journalNumber.toString())),
              ListTile(title: Text('JournalDate'), subtitle: Text(item.journalDate.toString())),
              ListTile(title: Text('EntryType'), subtitle: Text(item.entryType.toString())),
              ListTile(title: Text('ReferenceTable'), subtitle: Text(item.referenceTable.toString())),
              ListTile(title: Text('ReferenceId'), subtitle: Text(item.referenceId.toString())),
              ListTile(title: Text('Description'), subtitle: Text(item.description.toString())),
              ListTile(title: Text('TotalDebit'), subtitle: Text(item.totalDebit.toString())),
              ListTile(title: Text('TotalCredit'), subtitle: Text(item.totalCredit.toString())),
              ListTile(title: Text('Status'), subtitle: Text(item.status.toString())),
              ListTile(title: Text('PostedAt'), subtitle: Text(item.postedAt.toString())),
              ListTile(title: Text('PostedBy'), subtitle: Text(item.postedBy.toString())),
              ListTile(title: Text('Reversed'), subtitle: Text(item.reversed.toString())),
              ListTile(title: Text('ReversedById'), subtitle: Text(item.reversedById.toString())),
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
