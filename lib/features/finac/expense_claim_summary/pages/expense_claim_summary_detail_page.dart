import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/expense_claim_summary_repository.dart';
import '../models/expense_claim_summary_model.dart';

class FinacExpenseClaimSummaryDetailPage extends ConsumerWidget {
  final String id;
  const FinacExpenseClaimSummaryDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(finacExpenseClaimSummaryDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/finac/expense-claim-summary/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<FinacExpenseClaimSummary>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('ClaimNumber'), subtitle: Text(item.claimNumber.toString())),
              ListTile(title: Text('ClaimantId'), subtitle: Text(item.claimantId.toString())),
              ListTile(title: Text('EntityId'), subtitle: Text(item.entityId.toString())),
              ListTile(title: Text('ClaimDate'), subtitle: Text(item.claimDate.toString())),
              ListTile(title: Text('TotalTaxableAmount'), subtitle: Text(item.totalTaxableAmount.toString())),
              ListTile(title: Text('TotalGstAmount'), subtitle: Text(item.totalGstAmount.toString())),
              ListTile(title: Text('TotalTdsAmount'), subtitle: Text(item.totalTdsAmount.toString())),
              ListTile(title: Text('TotalAmount'), subtitle: Text(item.totalAmount.toString())),
              ListTile(title: Text('NetPayableAmount'), subtitle: Text(item.netPayableAmount.toString())),
              ListTile(title: Text('ReimbursementType'), subtitle: Text(item.reimbursementType.toString())),
              ListTile(title: Text('PaymentAccountId'), subtitle: Text(item.paymentAccountId.toString())),
              ListTile(title: Text('Status'), subtitle: Text(item.status.toString())),
              ListTile(title: Text('SubmittedAt'), subtitle: Text(item.submittedAt.toString())),
              ListTile(title: Text('ApprovedAt'), subtitle: Text(item.approvedAt.toString())),
              ListTile(title: Text('ApprovedBy'), subtitle: Text(item.approvedBy.toString())),
              ListTile(title: Text('PaidAt'), subtitle: Text(item.paidAt.toString())),
              ListTile(title: Text('PaymentReference'), subtitle: Text(item.paymentReference.toString())),
              ListTile(title: Text('PolicyViolations'), subtitle: Text(item.policyViolations.toString())),
              ListTile(title: Text('Notes'), subtitle: Text(item.notes.toString())),
              ListTile(title: Text('Metadata'), subtitle: Text(item.metadata.toString())),
              ListTile(title: Text('CreatedAt'), subtitle: Text(item.createdAt.toString())),
              ListTile(title: Text('CreatedBy'), subtitle: Text(item.createdBy.toString())),
              ListTile(title: Text('UpdatedAt'), subtitle: Text(item.updatedAt.toString())),
              ListTile(title: Text('UpdatedBy'), subtitle: Text(item.updatedBy.toString())),
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
