import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/journal_entry_lines_repository.dart';
import '../models/journal_entry_line_model.dart';

class FinacJournalEntryLineDetailPage extends ConsumerWidget {
  final String id;
  const FinacJournalEntryLineDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(finacJournalEntryLineDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/finac/journal-entry-lines/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<FinacJournalEntryLine>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('JournalEntryId'), subtitle: Text(item.journalEntryId.toString())),
              ListTile(title: Text('LineNumber'), subtitle: Text(item.lineNumber.toString())),
              ListTile(title: Text('AccountCode'), subtitle: Text(item.accountCode.toString())),
              ListTile(title: Text('AccountName'), subtitle: Text(item.accountName.toString())),
              ListTile(title: Text('DebitAmount'), subtitle: Text(item.debitAmount.toString())),
              ListTile(title: Text('CreditAmount'), subtitle: Text(item.creditAmount.toString())),
              ListTile(title: Text('Description'), subtitle: Text(item.description.toString())),
              ListTile(title: Text('CostCenter'), subtitle: Text(item.costCenter.toString())),
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
