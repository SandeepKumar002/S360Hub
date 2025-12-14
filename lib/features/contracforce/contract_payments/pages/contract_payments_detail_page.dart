import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/contract_payments_repository.dart';
import '../models/contract_payment_model.dart';

class ContracforceContractPaymentDetailPage extends ConsumerWidget {
  final String id;
  const ContracforceContractPaymentDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(contracforceContractPaymentDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/contracforce/contract-payments/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<ContracforceContractPayment>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('ContractId'), subtitle: Text(item.contractId.toString())),
              ListTile(title: Text('PaymentNumber'), subtitle: Text(item.paymentNumber.toString())),
              ListTile(title: Text('InvoiceNumber'), subtitle: Text(item.invoiceNumber.toString())),
              ListTile(title: Text('InvoiceDate'), subtitle: Text(item.invoiceDate.toString())),
              ListTile(title: Text('PaymentPeriodStart'), subtitle: Text(item.paymentPeriodStart.toString())),
              ListTile(title: Text('PaymentPeriodEnd'), subtitle: Text(item.paymentPeriodEnd.toString())),
              ListTile(title: Text('GrossAmount'), subtitle: Text(item.grossAmount.toString())),
              ListTile(title: Text('Deductions'), subtitle: Text(item.deductions.toString())),
              ListTile(title: Text('NetAmount'), subtitle: Text(item.netAmount.toString())),
              ListTile(title: Text('GstAmount'), subtitle: Text(item.gstAmount.toString())),
              ListTile(title: Text('TdsAmount'), subtitle: Text(item.tdsAmount.toString())),
              ListTile(title: Text('TotalPayable'), subtitle: Text(item.totalPayable.toString())),
              ListTile(title: Text('PaymentDate'), subtitle: Text(item.paymentDate.toString())),
              ListTile(title: Text('PaymentReference'), subtitle: Text(item.paymentReference.toString())),
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
