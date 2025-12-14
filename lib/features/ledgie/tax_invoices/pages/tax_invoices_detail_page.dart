import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/tax_invoices_repository.dart';
import '../models/tax_invoice_model.dart';

class LedgieTaxInvoiceDetailPage extends ConsumerWidget {
  final String id;
  const LedgieTaxInvoiceDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(ledgieTaxInvoiceDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/ledgie/tax-invoices/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<LedgieTaxInvoice>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('ProformaInvoiceId'), subtitle: Text(item.proformaInvoiceId.toString())),
              ListTile(title: Text('InvoiceNumber'), subtitle: Text(item.invoiceNumber.toString())),
              ListTile(title: Text('InvoiceDate'), subtitle: Text(item.invoiceDate.toString())),
              ListTile(title: Text('Currency'), subtitle: Text(item.currency.toString())),
              ListTile(title: Text('InvoiceValue'), subtitle: Text(item.invoiceValue.toString())),
              ListTile(title: Text('TaxBreakup'), subtitle: Text(item.taxBreakup.toString())),
              ListTile(title: Text('TotalValue'), subtitle: Text(item.totalValue.toString())),
              ListTile(title: Text('AmountPaid'), subtitle: Text(item.amountPaid.toString())),
              ListTile(title: Text('BalanceDue'), subtitle: Text(item.balanceDue.toString())),
              ListTile(title: Text('Remarks'), subtitle: Text(item.remarks.toString())),
              ListTile(title: Text('Status'), subtitle: Text(item.status.toString())),
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
