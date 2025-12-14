import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/tds_transactions_repository.dart';
import '../models/tds_transaction_model.dart';

class TaxforgeTdsTransactionDetailPage extends ConsumerWidget {
  final String id;
  const TaxforgeTdsTransactionDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(taxforgeTdsTransactionDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/taxforge/tds-transactions/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<TaxforgeTdsTransaction>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('ReferenceTable'), subtitle: Text(item.referenceTable.toString())),
              ListTile(title: Text('ReferenceId'), subtitle: Text(item.referenceId.toString())),
              ListTile(title: Text('TdsDetailId'), subtitle: Text(item.tdsDetailId.toString())),
              ListTile(title: Text('TransactionDate'), subtitle: Text(item.transactionDate.toString())),
              ListTile(title: Text('BaseAmount'), subtitle: Text(item.baseAmount.toString())),
              ListTile(title: Text('TdsRatePercent'), subtitle: Text(item.tdsRatePercent.toString())),
              ListTile(title: Text('TdsAmount'), subtitle: Text(item.tdsAmount.toString())),
              ListTile(title: Text('DepositedDate'), subtitle: Text(item.depositedDate.toString())),
              ListTile(title: Text('ChallanNo'), subtitle: Text(item.challanNo.toString())),
              ListTile(title: Text('DeductedBy'), subtitle: Text(item.deductedBy.toString())),
              ListTile(title: Text('ItcApplicability'), subtitle: Text(item.itcApplicability.toString())),
              ListTile(title: Text('AcknowledgementNumber'), subtitle: Text(item.acknowledgementNumber.toString())),
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
