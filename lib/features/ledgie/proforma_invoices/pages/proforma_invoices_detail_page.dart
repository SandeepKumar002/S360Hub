import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/proforma_invoices_repository.dart';
import '../models/proforma_invoice_model.dart';

class LedgieProformaInvoiceDetailPage extends ConsumerWidget {
  final String id;
  const LedgieProformaInvoiceDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(ledgieProformaInvoiceDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/ledgie/proforma-invoices/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<LedgieProformaInvoice>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('EntityType'), subtitle: Text(item.entityType.toString())),
              ListTile(title: Text('ProformaType'), subtitle: Text(item.proformaType.toString())),
              ListTile(title: Text('ServiceOrderId'), subtitle: Text(item.serviceOrderId.toString())),
              ListTile(title: Text('ProposalId'), subtitle: Text(item.proposalId.toString())),
              ListTile(title: Text('EstimateId'), subtitle: Text(item.estimateId.toString())),
              ListTile(title: Text('ProformaNumber'), subtitle: Text(item.proformaNumber.toString())),
              ListTile(title: Text('InvoiceToName'), subtitle: Text(item.invoiceToName.toString())),
              ListTile(title: Text('EntityId'), subtitle: Text(item.entityId.toString())),
              ListTile(title: Text('EntityCode'), subtitle: Text(item.entityCode.toString())),
              ListTile(title: Text('ContactName'), subtitle: Text(item.contactName.toString())),
              ListTile(title: Text('Country'), subtitle: Text(item.country.toString())),
              ListTile(title: Text('State'), subtitle: Text(item.state.toString())),
              ListTile(title: Text('District'), subtitle: Text(item.district.toString())),
              ListTile(title: Text('SubDistrict'), subtitle: Text(item.subDistrict.toString())),
              ListTile(title: Text('Address'), subtitle: Text(item.address.toString())),
              ListTile(title: Text('Pincode'), subtitle: Text(item.pincode.toString())),
              ListTile(title: Text('Gstin'), subtitle: Text(item.gstin.toString())),
              ListTile(title: Text('Pan'), subtitle: Text(item.pan.toString())),
              ListTile(title: Text('PaymentType'), subtitle: Text(item.paymentType.toString())),
              ListTile(title: Text('PaymentTermDays'), subtitle: Text(item.paymentTermDays.toString())),
              ListTile(title: Text('InvoiceDate'), subtitle: Text(item.invoiceDate.toString())),
              ListTile(title: Text('DueDate'), subtitle: Text(item.dueDate.toString())),
              ListTile(title: Text('Currency'), subtitle: Text(item.currency.toString())),
              ListTile(title: Text('AgreedValue'), subtitle: Text(item.agreedValue.toString())),
              ListTile(title: Text('InvoiceValue'), subtitle: Text(item.invoiceValue.toString())),
              ListTile(title: Text('TdsPercent'), subtitle: Text(item.tdsPercent.toString())),
              ListTile(title: Text('TdsValue'), subtitle: Text(item.tdsValue.toString())),
              ListTile(title: Text('CgstPercent'), subtitle: Text(item.cgstPercent.toString())),
              ListTile(title: Text('SgstPercent'), subtitle: Text(item.sgstPercent.toString())),
              ListTile(title: Text('IgstPercent'), subtitle: Text(item.igstPercent.toString())),
              ListTile(title: Text('CgstValue'), subtitle: Text(item.cgstValue.toString())),
              ListTile(title: Text('SgstValue'), subtitle: Text(item.sgstValue.toString())),
              ListTile(title: Text('IgstValue'), subtitle: Text(item.igstValue.toString())),
              ListTile(title: Text('TotalValue'), subtitle: Text(item.totalValue.toString())),
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
