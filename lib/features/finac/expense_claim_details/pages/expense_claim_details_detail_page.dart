import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/expense_claim_details_repository.dart';
import '../models/expense_claim_detail_model.dart';

class FinacExpenseClaimDetailDetailPage extends ConsumerWidget {
  final String id;
  const FinacExpenseClaimDetailDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(finacExpenseClaimDetailDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/finac/expense-claim-details/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<FinacExpenseClaimDetail>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('ClaimId'), subtitle: Text(item.claimId.toString())),
              ListTile(title: Text('LineNumber'), subtitle: Text(item.lineNumber.toString())),
              ListTile(title: Text('ExpenseDate'), subtitle: Text(item.expenseDate.toString())),
              ListTile(title: Text('Category'), subtitle: Text(item.category.toString())),
              ListTile(title: Text('SubCategory'), subtitle: Text(item.subCategory.toString())),
              ListTile(title: Text('Description'), subtitle: Text(item.description.toString())),
              ListTile(title: Text('SupplierName'), subtitle: Text(item.supplierName.toString())),
              ListTile(title: Text('SupplierGstin'), subtitle: Text(item.supplierGstin.toString())),
              ListTile(title: Text('SupplierPan'), subtitle: Text(item.supplierPan.toString())),
              ListTile(title: Text('InvoiceNumber'), subtitle: Text(item.invoiceNumber.toString())),
              ListTile(title: Text('InvoiceDate'), subtitle: Text(item.invoiceDate.toString())),
              ListTile(title: Text('TaxableAmount'), subtitle: Text(item.taxableAmount.toString())),
              ListTile(title: Text('GstRatePercent'), subtitle: Text(item.gstRatePercent.toString())),
              ListTile(title: Text('GstType'), subtitle: Text(item.gstType.toString())),
              ListTile(title: Text('CgstAmount'), subtitle: Text(item.cgstAmount.toString())),
              ListTile(title: Text('SgstAmount'), subtitle: Text(item.sgstAmount.toString())),
              ListTile(title: Text('IgstAmount'), subtitle: Text(item.igstAmount.toString())),
              ListTile(title: Text('CessAmount'), subtitle: Text(item.cessAmount.toString())),
              ListTile(title: Text('TotalLineAmount'), subtitle: Text(item.totalLineAmount.toString())),
              ListTile(title: Text('TdsApplicable'), subtitle: Text(item.tdsApplicable.toString())),
              ListTile(title: Text('TdsSection'), subtitle: Text(item.tdsSection.toString())),
              ListTile(title: Text('TdsRatePercent'), subtitle: Text(item.tdsRatePercent.toString())),
              ListTile(title: Text('TdsAmount'), subtitle: Text(item.tdsAmount.toString())),
              ListTile(title: Text('Reimbursable'), subtitle: Text(item.reimbursable.toString())),
              ListTile(title: Text('CostCenter'), subtitle: Text(item.costCenter.toString())),
              ListTile(title: Text('ProjectCode'), subtitle: Text(item.projectCode.toString())),
              ListTile(title: Text('HsnSacId'), subtitle: Text(item.hsnSacId.toString())),
              ListTile(title: Text('Attachments'), subtitle: Text(item.attachments.toString())),
              ListTile(title: Text('ComplianceFlags'), subtitle: Text(item.complianceFlags.toString())),
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
