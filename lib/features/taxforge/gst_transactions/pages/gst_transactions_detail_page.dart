import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/gst_transactions_repository.dart';
import '../models/gst_transaction_model.dart';

class TaxforgeGstTransactionDetailPage extends ConsumerWidget {
  final String id;
  const TaxforgeGstTransactionDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(taxforgeGstTransactionDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/taxforge/gst-transactions/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<TaxforgeGstTransaction>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('ReferenceTable'), subtitle: Text(item.referenceTable.toString())),
              ListTile(title: Text('ReferenceId'), subtitle: Text(item.referenceId.toString())),
              ListTile(title: Text('GstDetailId'), subtitle: Text(item.gstDetailId.toString())),
              ListTile(title: Text('TransactionDate'), subtitle: Text(item.transactionDate.toString())),
              ListTile(title: Text('TaxableAmount'), subtitle: Text(item.taxableAmount.toString())),
              ListTile(title: Text('GstRatePercent'), subtitle: Text(item.gstRatePercent.toString())),
              ListTile(title: Text('GstType'), subtitle: Text(item.gstType.toString())),
              ListTile(title: Text('CgstAmount'), subtitle: Text(item.cgstAmount.toString())),
              ListTile(title: Text('SgstAmount'), subtitle: Text(item.sgstAmount.toString())),
              ListTile(title: Text('IgstAmount'), subtitle: Text(item.igstAmount.toString())),
              ListTile(title: Text('CessAmount'), subtitle: Text(item.cessAmount.toString())),
              ListTile(title: Text('TotalGstAmount'), subtitle: Text(item.totalGstAmount.toString())),
              ListTile(title: Text('ItcEligible'), subtitle: Text(item.itcEligible.toString())),
              ListTile(title: Text('ItcClaimed'), subtitle: Text(item.itcClaimed.toString())),
              ListTile(title: Text('InvoiceDate'), subtitle: Text(item.invoiceDate.toString())),
              ListTile(title: Text('FilingPeriod'), subtitle: Text(item.filingPeriod.toString())),
              ListTile(title: Text('DocumentRef'), subtitle: Text(item.documentRef.toString())),
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
