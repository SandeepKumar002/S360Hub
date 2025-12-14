import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/tds_transactions_repository.dart';

class TaxforgeTdsTransactionFormPage extends ConsumerStatefulWidget {
  final String? id;
  const TaxforgeTdsTransactionFormPage({super.key, this.id});

  @override
  ConsumerState<TaxforgeTdsTransactionFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<TaxforgeTdsTransactionFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _referenceTableController = TextEditingController();
  final _referenceIdController = TextEditingController();
  final _tdsDetailIdController = TextEditingController();
  final _transactionDateController = TextEditingController();
  final _baseAmountController = TextEditingController();
  final _tdsRatePercentController = TextEditingController();
  final _tdsAmountController = TextEditingController();
  final _depositedDateController = TextEditingController();
  final _challanNoController = TextEditingController();
  final _deductedByController = TextEditingController();
  bool _itcApplicability = false;
  final _acknowledgementNumberController = TextEditingController();
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
      'tds_detail_id': _tdsDetailIdController.text,
      'transaction_date': _transactionDateController.text,
      'base_amount': double.tryParse(_baseAmountController.text),
      'tds_rate_percent': double.tryParse(_tdsRatePercentController.text),
      'tds_amount': double.tryParse(_tdsAmountController.text),
      'deposited_date': _depositedDateController.text,
      'challan_no': _challanNoController.text,
      'deducted_by': _deductedByController.text,
      'itc_applicability': _itcApplicability,
      'acknowledgement_number': _acknowledgementNumberController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(taxforgeTdsTransactionRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(taxforgeTdsTransactionRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(taxforgeTdsTransactionListProvider);
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
               TextFormField(controller: _tdsDetailIdController, decoration: const InputDecoration(labelText: 'TdsDetailId')),
               const SizedBox(height: 16),
               TextFormField(controller: _transactionDateController, decoration: const InputDecoration(labelText: 'TransactionDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _baseAmountController, decoration: const InputDecoration(labelText: 'BaseAmount')),
               const SizedBox(height: 16),
               TextFormField(controller: _tdsRatePercentController, decoration: const InputDecoration(labelText: 'TdsRatePercent')),
               const SizedBox(height: 16),
               TextFormField(controller: _tdsAmountController, decoration: const InputDecoration(labelText: 'TdsAmount')),
               const SizedBox(height: 16),
               TextFormField(controller: _depositedDateController, decoration: const InputDecoration(labelText: 'DepositedDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _challanNoController, decoration: const InputDecoration(labelText: 'ChallanNo')),
               const SizedBox(height: 16),
               TextFormField(controller: _deductedByController, decoration: const InputDecoration(labelText: 'DeductedBy')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('ItcApplicability'), value: _itcApplicability, onChanged: (v) => setState(() => _itcApplicability = v)),
               TextFormField(controller: _acknowledgementNumberController, decoration: const InputDecoration(labelText: 'AcknowledgementNumber')),
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
