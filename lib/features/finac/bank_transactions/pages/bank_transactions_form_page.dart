import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/bank_transactions_repository.dart';

class FinacBankTransactionFormPage extends ConsumerStatefulWidget {
  final String? id;
  const FinacBankTransactionFormPage({super.key, this.id});

  @override
  ConsumerState<FinacBankTransactionFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<FinacBankTransactionFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _transactionNumberController = TextEditingController();
  final _bankAccountIdController = TextEditingController();
  final _txnDateController = TextEditingController();
  final _amountController = TextEditingController();
  final _currencyController = TextEditingController();
  final _currencyRateController = TextEditingController();
  final _directionController = TextEditingController();
  final _transactionPurposeController = TextEditingController();
  final _partyTypeController = TextEditingController();
  final _partyIdController = TextEditingController();
  final _referenceTableController = TextEditingController();
  final _referenceIdController = TextEditingController();
  final _bankReferenceController = TextEditingController();
  final _chequeNumberController = TextEditingController();
  final _utrNumberController = TextEditingController();
  final _statusController = TextEditingController();
  final _clearedAtController = TextEditingController();
  final _reconciliationStatusController = TextEditingController();
  final _reconciledAtController = TextEditingController();
  final _reconciledByController = TextEditingController();
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
      'transaction_number': _transactionNumberController.text,
      'bank_account_id': _bankAccountIdController.text,
      'txn_date': _txnDateController.text,
      'amount': double.tryParse(_amountController.text),
      'currency': _currencyController.text,
      'currency_rate': double.tryParse(_currencyRateController.text),
      'direction': _directionController.text,
      'transaction_purpose': _transactionPurposeController.text,
      'party_type': _partyTypeController.text,
      'party_id': _partyIdController.text,
      'reference_table': _referenceTableController.text,
      'reference_id': _referenceIdController.text,
      'bank_reference': _bankReferenceController.text,
      'cheque_number': _chequeNumberController.text,
      'utr_number': _utrNumberController.text,
      'status': _statusController.text,
      'cleared_at': _clearedAtController.text,
      'reconciliation_status': _reconciliationStatusController.text,
      'reconciled_at': _reconciledAtController.text,
      'reconciled_by': _reconciledByController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(finacBankTransactionRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(finacBankTransactionRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(finacBankTransactionListProvider);
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
               TextFormField(controller: _transactionNumberController, decoration: const InputDecoration(labelText: 'TransactionNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _bankAccountIdController, decoration: const InputDecoration(labelText: 'BankAccountId')),
               const SizedBox(height: 16),
               TextFormField(controller: _txnDateController, decoration: const InputDecoration(labelText: 'TxnDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _amountController, decoration: const InputDecoration(labelText: 'Amount')),
               const SizedBox(height: 16),
               TextFormField(controller: _currencyController, decoration: const InputDecoration(labelText: 'Currency')),
               const SizedBox(height: 16),
               TextFormField(controller: _currencyRateController, decoration: const InputDecoration(labelText: 'CurrencyRate')),
               const SizedBox(height: 16),
               TextFormField(controller: _directionController, decoration: const InputDecoration(labelText: 'Direction')),
               const SizedBox(height: 16),
               TextFormField(controller: _transactionPurposeController, decoration: const InputDecoration(labelText: 'TransactionPurpose')),
               const SizedBox(height: 16),
               TextFormField(controller: _partyTypeController, decoration: const InputDecoration(labelText: 'PartyType')),
               const SizedBox(height: 16),
               TextFormField(controller: _partyIdController, decoration: const InputDecoration(labelText: 'PartyId')),
               const SizedBox(height: 16),
               TextFormField(controller: _referenceTableController, decoration: const InputDecoration(labelText: 'ReferenceTable')),
               const SizedBox(height: 16),
               TextFormField(controller: _referenceIdController, decoration: const InputDecoration(labelText: 'ReferenceId')),
               const SizedBox(height: 16),
               TextFormField(controller: _bankReferenceController, decoration: const InputDecoration(labelText: 'BankReference')),
               const SizedBox(height: 16),
               TextFormField(controller: _chequeNumberController, decoration: const InputDecoration(labelText: 'ChequeNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _utrNumberController, decoration: const InputDecoration(labelText: 'UtrNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _statusController, decoration: const InputDecoration(labelText: 'Status')),
               const SizedBox(height: 16),
               TextFormField(controller: _clearedAtController, decoration: const InputDecoration(labelText: 'ClearedAt')),
               const SizedBox(height: 16),
               TextFormField(controller: _reconciliationStatusController, decoration: const InputDecoration(labelText: 'ReconciliationStatus')),
               const SizedBox(height: 16),
               TextFormField(controller: _reconciledAtController, decoration: const InputDecoration(labelText: 'ReconciledAt')),
               const SizedBox(height: 16),
               TextFormField(controller: _reconciledByController, decoration: const InputDecoration(labelText: 'ReconciledBy')),
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
