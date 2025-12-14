import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/contract_payments_repository.dart';

class ContracforceContractPaymentFormPage extends ConsumerStatefulWidget {
  final String? id;
  const ContracforceContractPaymentFormPage({super.key, this.id});

  @override
  ConsumerState<ContracforceContractPaymentFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<ContracforceContractPaymentFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _contractIdController = TextEditingController();
  final _paymentNumberController = TextEditingController();
  final _invoiceNumberController = TextEditingController();
  final _invoiceDateController = TextEditingController();
  final _paymentPeriodStartController = TextEditingController();
  final _paymentPeriodEndController = TextEditingController();
  final _grossAmountController = TextEditingController();
  final _deductionsController = TextEditingController();
  final _netAmountController = TextEditingController();
  final _gstAmountController = TextEditingController();
  final _tdsAmountController = TextEditingController();
  final _totalPayableController = TextEditingController();
  final _paymentDateController = TextEditingController();
  final _paymentReferenceController = TextEditingController();
  final _statusController = TextEditingController();
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
      'contract_id': _contractIdController.text,
      'payment_number': _paymentNumberController.text,
      'invoice_number': _invoiceNumberController.text,
      'invoice_date': _invoiceDateController.text,
      'payment_period_start': _paymentPeriodStartController.text,
      'payment_period_end': _paymentPeriodEndController.text,
      'gross_amount': double.tryParse(_grossAmountController.text),
      'deductions': _deductionsController.text,
      'net_amount': double.tryParse(_netAmountController.text),
      'gst_amount': double.tryParse(_gstAmountController.text),
      'tds_amount': double.tryParse(_tdsAmountController.text),
      'total_payable': double.tryParse(_totalPayableController.text),
      'payment_date': _paymentDateController.text,
      'payment_reference': _paymentReferenceController.text,
      'status': _statusController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(contracforceContractPaymentRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(contracforceContractPaymentRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(contracforceContractPaymentListProvider);
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
               TextFormField(controller: _contractIdController, decoration: const InputDecoration(labelText: 'ContractId')),
               const SizedBox(height: 16),
               TextFormField(controller: _paymentNumberController, decoration: const InputDecoration(labelText: 'PaymentNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _invoiceNumberController, decoration: const InputDecoration(labelText: 'InvoiceNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _invoiceDateController, decoration: const InputDecoration(labelText: 'InvoiceDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _paymentPeriodStartController, decoration: const InputDecoration(labelText: 'PaymentPeriodStart')),
               const SizedBox(height: 16),
               TextFormField(controller: _paymentPeriodEndController, decoration: const InputDecoration(labelText: 'PaymentPeriodEnd')),
               const SizedBox(height: 16),
               TextFormField(controller: _grossAmountController, decoration: const InputDecoration(labelText: 'GrossAmount')),
               const SizedBox(height: 16),
               TextFormField(controller: _deductionsController, decoration: const InputDecoration(labelText: 'Deductions')),
               const SizedBox(height: 16),
               TextFormField(controller: _netAmountController, decoration: const InputDecoration(labelText: 'NetAmount')),
               const SizedBox(height: 16),
               TextFormField(controller: _gstAmountController, decoration: const InputDecoration(labelText: 'GstAmount')),
               const SizedBox(height: 16),
               TextFormField(controller: _tdsAmountController, decoration: const InputDecoration(labelText: 'TdsAmount')),
               const SizedBox(height: 16),
               TextFormField(controller: _totalPayableController, decoration: const InputDecoration(labelText: 'TotalPayable')),
               const SizedBox(height: 16),
               TextFormField(controller: _paymentDateController, decoration: const InputDecoration(labelText: 'PaymentDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _paymentReferenceController, decoration: const InputDecoration(labelText: 'PaymentReference')),
               const SizedBox(height: 16),
               TextFormField(controller: _statusController, decoration: const InputDecoration(labelText: 'Status')),
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
