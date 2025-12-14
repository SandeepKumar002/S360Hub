import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/expense_claim_details_repository.dart';

class FinacExpenseClaimDetailFormPage extends ConsumerStatefulWidget {
  final String? id;
  const FinacExpenseClaimDetailFormPage({super.key, this.id});

  @override
  ConsumerState<FinacExpenseClaimDetailFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<FinacExpenseClaimDetailFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _claimIdController = TextEditingController();
  final _lineNumberController = TextEditingController();
  final _expenseDateController = TextEditingController();
  final _categoryController = TextEditingController();
  final _subCategoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _supplierNameController = TextEditingController();
  final _supplierGstinController = TextEditingController();
  final _supplierPanController = TextEditingController();
  final _invoiceNumberController = TextEditingController();
  final _invoiceDateController = TextEditingController();
  final _taxableAmountController = TextEditingController();
  final _gstRatePercentController = TextEditingController();
  final _gstTypeController = TextEditingController();
  final _cgstAmountController = TextEditingController();
  final _sgstAmountController = TextEditingController();
  final _igstAmountController = TextEditingController();
  final _cessAmountController = TextEditingController();
  final _totalLineAmountController = TextEditingController();
  bool _tdsApplicable = false;
  final _tdsSectionController = TextEditingController();
  final _tdsRatePercentController = TextEditingController();
  final _tdsAmountController = TextEditingController();
  bool _reimbursable = false;
  final _costCenterController = TextEditingController();
  final _projectCodeController = TextEditingController();
  final _hsnSacIdController = TextEditingController();
  final _attachmentsController = TextEditingController();
  final _complianceFlagsController = TextEditingController();
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
      'claim_id': _claimIdController.text,
      'line_number': int.tryParse(_lineNumberController.text),
      'expense_date': _expenseDateController.text,
      'category': _categoryController.text,
      'sub_category': _subCategoryController.text,
      'description': _descriptionController.text,
      'supplier_name': _supplierNameController.text,
      'supplier_gstin': _supplierGstinController.text,
      'supplier_pan': _supplierPanController.text,
      'invoice_number': _invoiceNumberController.text,
      'invoice_date': _invoiceDateController.text,
      'taxable_amount': double.tryParse(_taxableAmountController.text),
      'gst_rate_percent': double.tryParse(_gstRatePercentController.text),
      'gst_type': _gstTypeController.text,
      'cgst_amount': double.tryParse(_cgstAmountController.text),
      'sgst_amount': double.tryParse(_sgstAmountController.text),
      'igst_amount': double.tryParse(_igstAmountController.text),
      'cess_amount': double.tryParse(_cessAmountController.text),
      'total_line_amount': double.tryParse(_totalLineAmountController.text),
      'tds_applicable': _tdsApplicable,
      'tds_section': _tdsSectionController.text,
      'tds_rate_percent': double.tryParse(_tdsRatePercentController.text),
      'tds_amount': double.tryParse(_tdsAmountController.text),
      'reimbursable': _reimbursable,
      'cost_center': _costCenterController.text,
      'project_code': _projectCodeController.text,
      'hsn_sac_id': _hsnSacIdController.text,
      'attachments': _attachmentsController.text,
      'compliance_flags': _complianceFlagsController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(finacExpenseClaimDetailRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(finacExpenseClaimDetailRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(finacExpenseClaimDetailListProvider);
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
               TextFormField(controller: _claimIdController, decoration: const InputDecoration(labelText: 'ClaimId')),
               const SizedBox(height: 16),
               TextFormField(controller: _lineNumberController, decoration: const InputDecoration(labelText: 'LineNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _expenseDateController, decoration: const InputDecoration(labelText: 'ExpenseDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _categoryController, decoration: const InputDecoration(labelText: 'Category')),
               const SizedBox(height: 16),
               TextFormField(controller: _subCategoryController, decoration: const InputDecoration(labelText: 'SubCategory')),
               const SizedBox(height: 16),
               TextFormField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Description')),
               const SizedBox(height: 16),
               TextFormField(controller: _supplierNameController, decoration: const InputDecoration(labelText: 'SupplierName')),
               const SizedBox(height: 16),
               TextFormField(controller: _supplierGstinController, decoration: const InputDecoration(labelText: 'SupplierGstin')),
               const SizedBox(height: 16),
               TextFormField(controller: _supplierPanController, decoration: const InputDecoration(labelText: 'SupplierPan')),
               const SizedBox(height: 16),
               TextFormField(controller: _invoiceNumberController, decoration: const InputDecoration(labelText: 'InvoiceNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _invoiceDateController, decoration: const InputDecoration(labelText: 'InvoiceDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _taxableAmountController, decoration: const InputDecoration(labelText: 'TaxableAmount')),
               const SizedBox(height: 16),
               TextFormField(controller: _gstRatePercentController, decoration: const InputDecoration(labelText: 'GstRatePercent')),
               const SizedBox(height: 16),
               TextFormField(controller: _gstTypeController, decoration: const InputDecoration(labelText: 'GstType')),
               const SizedBox(height: 16),
               TextFormField(controller: _cgstAmountController, decoration: const InputDecoration(labelText: 'CgstAmount')),
               const SizedBox(height: 16),
               TextFormField(controller: _sgstAmountController, decoration: const InputDecoration(labelText: 'SgstAmount')),
               const SizedBox(height: 16),
               TextFormField(controller: _igstAmountController, decoration: const InputDecoration(labelText: 'IgstAmount')),
               const SizedBox(height: 16),
               TextFormField(controller: _cessAmountController, decoration: const InputDecoration(labelText: 'CessAmount')),
               const SizedBox(height: 16),
               TextFormField(controller: _totalLineAmountController, decoration: const InputDecoration(labelText: 'TotalLineAmount')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('TdsApplicable'), value: _tdsApplicable, onChanged: (v) => setState(() => _tdsApplicable = v)),
               TextFormField(controller: _tdsSectionController, decoration: const InputDecoration(labelText: 'TdsSection')),
               const SizedBox(height: 16),
               TextFormField(controller: _tdsRatePercentController, decoration: const InputDecoration(labelText: 'TdsRatePercent')),
               const SizedBox(height: 16),
               TextFormField(controller: _tdsAmountController, decoration: const InputDecoration(labelText: 'TdsAmount')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('Reimbursable'), value: _reimbursable, onChanged: (v) => setState(() => _reimbursable = v)),
               TextFormField(controller: _costCenterController, decoration: const InputDecoration(labelText: 'CostCenter')),
               const SizedBox(height: 16),
               TextFormField(controller: _projectCodeController, decoration: const InputDecoration(labelText: 'ProjectCode')),
               const SizedBox(height: 16),
               TextFormField(controller: _hsnSacIdController, decoration: const InputDecoration(labelText: 'HsnSacId')),
               const SizedBox(height: 16),
               TextFormField(controller: _attachmentsController, decoration: const InputDecoration(labelText: 'Attachments')),
               const SizedBox(height: 16),
               TextFormField(controller: _complianceFlagsController, decoration: const InputDecoration(labelText: 'ComplianceFlags')),
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
