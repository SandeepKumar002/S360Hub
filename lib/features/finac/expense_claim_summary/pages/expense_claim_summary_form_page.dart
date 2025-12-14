import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/expense_claim_summary_repository.dart';

class FinacExpenseClaimSummaryFormPage extends ConsumerStatefulWidget {
  final String? id;
  const FinacExpenseClaimSummaryFormPage({super.key, this.id});

  @override
  ConsumerState<FinacExpenseClaimSummaryFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<FinacExpenseClaimSummaryFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _claimNumberController = TextEditingController();
  final _claimantIdController = TextEditingController();
  final _entityIdController = TextEditingController();
  final _claimDateController = TextEditingController();
  final _totalTaxableAmountController = TextEditingController();
  final _totalGstAmountController = TextEditingController();
  final _totalTdsAmountController = TextEditingController();
  final _totalAmountController = TextEditingController();
  final _netPayableAmountController = TextEditingController();
  final _reimbursementTypeController = TextEditingController();
  final _paymentAccountIdController = TextEditingController();
  final _statusController = TextEditingController();
  final _submittedAtController = TextEditingController();
  final _paidAtController = TextEditingController();
  final _paymentReferenceController = TextEditingController();
  final _policyViolationsController = TextEditingController();
  final _notesController = TextEditingController();
  final _deletedByController = TextEditingController();
  final _deleteTypeController = TextEditingController();
  bool _isDeleted = false;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      _loadData();
    }
  }
  
  Future<void> _loadData() async {
    // TODO: Load data for edit
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    
    final data = {
      'claim_number': _claimNumberController.text,
      'claimant_id': _claimantIdController.text,
      'entity_id': _entityIdController.text,
      'claim_date': _claimDateController.text,
      'total_taxable_amount': double.tryParse(_totalTaxableAmountController.text),
      'total_gst_amount': double.tryParse(_totalGstAmountController.text),
      'total_tds_amount': double.tryParse(_totalTdsAmountController.text),
      'total_amount': double.tryParse(_totalAmountController.text),
      'net_payable_amount': double.tryParse(_netPayableAmountController.text),
      'reimbursement_type': _reimbursementTypeController.text,
      'payment_account_id': _paymentAccountIdController.text,
      'status': _statusController.text,
      'submitted_at': _submittedAtController.text,
      'paid_at': _paidAtController.text,
      'payment_reference': _paymentReferenceController.text,
      'policy_violations': _policyViolationsController.text,
      'notes': _notesController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(finacExpenseClaimSummaryRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(finacExpenseClaimSummaryRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(finacExpenseClaimSummaryListProvider);
       if (mounted) context.pop();
    } catch (e) {
       if (mounted) FeedbackService.showError(context, e.toString());
    } finally {
       if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.id != null ? 'Edit' : 'New')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
             children: [
               TextFormField(controller: _claimNumberController, decoration: const InputDecoration(labelText: 'ClaimNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _claimantIdController, decoration: const InputDecoration(labelText: 'ClaimantId')),
               const SizedBox(height: 16),
               TextFormField(controller: _entityIdController, decoration: const InputDecoration(labelText: 'EntityId')),
               const SizedBox(height: 16),
               TextFormField(controller: _claimDateController, decoration: const InputDecoration(labelText: 'ClaimDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _totalTaxableAmountController, decoration: const InputDecoration(labelText: 'TotalTaxableAmount')),
               const SizedBox(height: 16),
               TextFormField(controller: _totalGstAmountController, decoration: const InputDecoration(labelText: 'TotalGstAmount')),
               const SizedBox(height: 16),
               TextFormField(controller: _totalTdsAmountController, decoration: const InputDecoration(labelText: 'TotalTdsAmount')),
               const SizedBox(height: 16),
               TextFormField(controller: _totalAmountController, decoration: const InputDecoration(labelText: 'TotalAmount')),
               const SizedBox(height: 16),
               TextFormField(controller: _netPayableAmountController, decoration: const InputDecoration(labelText: 'NetPayableAmount')),
               const SizedBox(height: 16),
               TextFormField(controller: _reimbursementTypeController, decoration: const InputDecoration(labelText: 'ReimbursementType')),
               const SizedBox(height: 16),
               TextFormField(controller: _paymentAccountIdController, decoration: const InputDecoration(labelText: 'PaymentAccountId')),
               const SizedBox(height: 16),
               TextFormField(controller: _statusController, decoration: const InputDecoration(labelText: 'Status')),
               const SizedBox(height: 16),
               TextFormField(controller: _submittedAtController, decoration: const InputDecoration(labelText: 'SubmittedAt')),
               const SizedBox(height: 16),
               TextFormField(controller: _paidAtController, decoration: const InputDecoration(labelText: 'PaidAt')),
               const SizedBox(height: 16),
               TextFormField(controller: _paymentReferenceController, decoration: const InputDecoration(labelText: 'PaymentReference')),
               const SizedBox(height: 16),
               TextFormField(controller: _policyViolationsController, decoration: const InputDecoration(labelText: 'PolicyViolations')),
               const SizedBox(height: 16),
               TextFormField(controller: _notesController, decoration: const InputDecoration(labelText: 'Notes')),
               const SizedBox(height: 16),
               TextFormField(controller: _deletedByController, decoration: const InputDecoration(labelText: 'DeletedBy')),
               const SizedBox(height: 16),
               TextFormField(controller: _deleteTypeController, decoration: const InputDecoration(labelText: 'DeleteType')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('IsDeleted'), value: _isDeleted, onChanged: (v) => setState(() => _isDeleted = v)),
               const SizedBox(height: 24),
               ElevatedButton(onPressed: _isLoading ? null : _save, child: const Text('Save')),
             ],
          ),
        ),
      ),
    );
  }
}
