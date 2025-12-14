import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/journal_entry_lines_repository.dart';

class FinacJournalEntryLineFormPage extends ConsumerStatefulWidget {
  final String? id;
  const FinacJournalEntryLineFormPage({super.key, this.id});

  @override
  ConsumerState<FinacJournalEntryLineFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<FinacJournalEntryLineFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _journalEntryIdController = TextEditingController();
  final _lineNumberController = TextEditingController();
  final _accountCodeController = TextEditingController();
  final _accountNameController = TextEditingController();
  final _debitAmountController = TextEditingController();
  final _creditAmountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _costCenterController = TextEditingController();

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
      'journal_entry_id': _journalEntryIdController.text,
      'line_number': int.tryParse(_lineNumberController.text),
      'account_code': _accountCodeController.text,
      'account_name': _accountNameController.text,
      'debit_amount': double.tryParse(_debitAmountController.text),
      'credit_amount': double.tryParse(_creditAmountController.text),
      'description': _descriptionController.text,
      'cost_center': _costCenterController.text,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(finacJournalEntryLineRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(finacJournalEntryLineRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(finacJournalEntryLineListProvider);
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
               TextFormField(controller: _journalEntryIdController, decoration: const InputDecoration(labelText: 'JournalEntryId')),
               const SizedBox(height: 16),
               TextFormField(controller: _lineNumberController, decoration: const InputDecoration(labelText: 'LineNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _accountCodeController, decoration: const InputDecoration(labelText: 'AccountCode')),
               const SizedBox(height: 16),
               TextFormField(controller: _accountNameController, decoration: const InputDecoration(labelText: 'AccountName')),
               const SizedBox(height: 16),
               TextFormField(controller: _debitAmountController, decoration: const InputDecoration(labelText: 'DebitAmount')),
               const SizedBox(height: 16),
               TextFormField(controller: _creditAmountController, decoration: const InputDecoration(labelText: 'CreditAmount')),
               const SizedBox(height: 16),
               TextFormField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Description')),
               const SizedBox(height: 16),
               TextFormField(controller: _costCenterController, decoration: const InputDecoration(labelText: 'CostCenter')),
               const SizedBox(height: 16),
               const SizedBox(height: 24),
               ElevatedButton(onPressed: _isLoading ? null : _save, child: const Text('Save')),
             ],
          ),
        ),
      ),
    );
  }
}
