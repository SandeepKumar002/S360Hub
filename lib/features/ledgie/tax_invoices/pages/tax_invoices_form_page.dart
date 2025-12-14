import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/tax_invoices_repository.dart';

class LedgieTaxInvoiceFormPage extends ConsumerStatefulWidget {
  final String? id;
  const LedgieTaxInvoiceFormPage({super.key, this.id});

  @override
  ConsumerState<LedgieTaxInvoiceFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<LedgieTaxInvoiceFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _proformaInvoiceIdController = TextEditingController();
  final _invoiceNumberController = TextEditingController();
  final _invoiceDateController = TextEditingController();
  final _currencyController = TextEditingController();
  final _invoiceValueController = TextEditingController();
  final _taxBreakupController = TextEditingController();
  final _totalValueController = TextEditingController();
  final _amountPaidController = TextEditingController();
  final _balanceDueController = TextEditingController();
  final _remarksController = TextEditingController();
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
      'proforma_invoice_id': _proformaInvoiceIdController.text,
      'invoice_number': _invoiceNumberController.text,
      'invoice_date': _invoiceDateController.text,
      'currency': _currencyController.text,
      'invoice_value': double.tryParse(_invoiceValueController.text),
      'tax_breakup': _taxBreakupController.text,
      'total_value': double.tryParse(_totalValueController.text),
      'amount_paid': double.tryParse(_amountPaidController.text),
      'balance_due': double.tryParse(_balanceDueController.text),
      'remarks': _remarksController.text,
      'status': _statusController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(ledgieTaxInvoiceRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(ledgieTaxInvoiceRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(ledgieTaxInvoiceListProvider);
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
               TextFormField(controller: _proformaInvoiceIdController, decoration: const InputDecoration(labelText: 'ProformaInvoiceId')),
               const SizedBox(height: 16),
               TextFormField(controller: _invoiceNumberController, decoration: const InputDecoration(labelText: 'InvoiceNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _invoiceDateController, decoration: const InputDecoration(labelText: 'InvoiceDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _currencyController, decoration: const InputDecoration(labelText: 'Currency')),
               const SizedBox(height: 16),
               TextFormField(controller: _invoiceValueController, decoration: const InputDecoration(labelText: 'InvoiceValue')),
               const SizedBox(height: 16),
               TextFormField(controller: _taxBreakupController, decoration: const InputDecoration(labelText: 'TaxBreakup')),
               const SizedBox(height: 16),
               TextFormField(controller: _totalValueController, decoration: const InputDecoration(labelText: 'TotalValue')),
               const SizedBox(height: 16),
               TextFormField(controller: _amountPaidController, decoration: const InputDecoration(labelText: 'AmountPaid')),
               const SizedBox(height: 16),
               TextFormField(controller: _balanceDueController, decoration: const InputDecoration(labelText: 'BalanceDue')),
               const SizedBox(height: 16),
               TextFormField(controller: _remarksController, decoration: const InputDecoration(labelText: 'Remarks')),
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
