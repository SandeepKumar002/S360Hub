import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/gst_transactions_repository.dart';

class TaxforgeGstTransactionFormPage extends ConsumerStatefulWidget {
  final String? id;
  const TaxforgeGstTransactionFormPage({super.key, this.id});

  @override
  ConsumerState<TaxforgeGstTransactionFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<TaxforgeGstTransactionFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _referenceTableController = TextEditingController();
  final _referenceIdController = TextEditingController();
  final _gstDetailIdController = TextEditingController();
  final _transactionDateController = TextEditingController();
  final _taxableAmountController = TextEditingController();
  final _gstRatePercentController = TextEditingController();
  final _gstTypeController = TextEditingController();
  final _cgstAmountController = TextEditingController();
  final _sgstAmountController = TextEditingController();
  final _igstAmountController = TextEditingController();
  final _cessAmountController = TextEditingController();
  final _totalGstAmountController = TextEditingController();
  bool _itcEligible = false;
  bool _itcClaimed = false;
  final _invoiceDateController = TextEditingController();
  final _filingPeriodController = TextEditingController();
  final _documentRefController = TextEditingController();
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
      'reference_table': _referenceTableController.text,
      'reference_id': _referenceIdController.text,
      'gst_detail_id': _gstDetailIdController.text,
      'transaction_date': _transactionDateController.text,
      'taxable_amount': double.tryParse(_taxableAmountController.text),
      'gst_rate_percent': double.tryParse(_gstRatePercentController.text),
      'gst_type': _gstTypeController.text,
      'cgst_amount': double.tryParse(_cgstAmountController.text),
      'sgst_amount': double.tryParse(_sgstAmountController.text),
      'igst_amount': double.tryParse(_igstAmountController.text),
      'cess_amount': double.tryParse(_cessAmountController.text),
      'total_gst_amount': double.tryParse(_totalGstAmountController.text),
      'itc_eligible': _itcEligible,
      'itc_claimed': _itcClaimed,
      'invoice_date': _invoiceDateController.text,
      'filing_period': _filingPeriodController.text,
      'document_ref': _documentRefController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(taxforgeGstTransactionRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(taxforgeGstTransactionRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(taxforgeGstTransactionListProvider);
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
               TextFormField(controller: _referenceTableController, decoration: const InputDecoration(labelText: 'ReferenceTable')),
               const SizedBox(height: 16),
               TextFormField(controller: _referenceIdController, decoration: const InputDecoration(labelText: 'ReferenceId')),
               const SizedBox(height: 16),
               TextFormField(controller: _gstDetailIdController, decoration: const InputDecoration(labelText: 'GstDetailId')),
               const SizedBox(height: 16),
               TextFormField(controller: _transactionDateController, decoration: const InputDecoration(labelText: 'TransactionDate')),
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
               TextFormField(controller: _totalGstAmountController, decoration: const InputDecoration(labelText: 'TotalGstAmount')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('ItcEligible'), value: _itcEligible, onChanged: (v) => setState(() => _itcEligible = v)),
               SwitchListTile(title: const Text('ItcClaimed'), value: _itcClaimed, onChanged: (v) => setState(() => _itcClaimed = v)),
               TextFormField(controller: _invoiceDateController, decoration: const InputDecoration(labelText: 'InvoiceDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _filingPeriodController, decoration: const InputDecoration(labelText: 'FilingPeriod')),
               const SizedBox(height: 16),
               TextFormField(controller: _documentRefController, decoration: const InputDecoration(labelText: 'DocumentRef')),
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
