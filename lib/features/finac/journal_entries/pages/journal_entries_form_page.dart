import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/journal_entries_repository.dart';

class FinacJournalEntrieFormPage extends ConsumerStatefulWidget {
  final String? id;
  const FinacJournalEntrieFormPage({super.key, this.id});

  @override
  ConsumerState<FinacJournalEntrieFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<FinacJournalEntrieFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _journalNumberController = TextEditingController();
  final _journalDateController = TextEditingController();
  final _entryTypeController = TextEditingController();
  final _referenceTableController = TextEditingController();
  final _referenceIdController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _totalDebitController = TextEditingController();
  final _totalCreditController = TextEditingController();
  final _statusController = TextEditingController();
  final _postedAtController = TextEditingController();
  final _postedByController = TextEditingController();
  bool _reversed = false;
  final _reversedByIdController = TextEditingController();
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
      'journal_number': _journalNumberController.text,
      'journal_date': _journalDateController.text,
      'entry_type': _entryTypeController.text,
      'reference_table': _referenceTableController.text,
      'reference_id': _referenceIdController.text,
      'description': _descriptionController.text,
      'total_debit': double.tryParse(_totalDebitController.text),
      'total_credit': double.tryParse(_totalCreditController.text),
      'status': _statusController.text,
      'posted_at': _postedAtController.text,
      'posted_by': _postedByController.text,
      'reversed': _reversed,
      'reversed_by_id': _reversedByIdController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(finacJournalEntrieRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(finacJournalEntrieRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(finacJournalEntrieListProvider);
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
               TextFormField(controller: _journalNumberController, decoration: const InputDecoration(labelText: 'JournalNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _journalDateController, decoration: const InputDecoration(labelText: 'JournalDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _entryTypeController, decoration: const InputDecoration(labelText: 'EntryType')),
               const SizedBox(height: 16),
               TextFormField(controller: _referenceTableController, decoration: const InputDecoration(labelText: 'ReferenceTable')),
               const SizedBox(height: 16),
               TextFormField(controller: _referenceIdController, decoration: const InputDecoration(labelText: 'ReferenceId')),
               const SizedBox(height: 16),
               TextFormField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Description')),
               const SizedBox(height: 16),
               TextFormField(controller: _totalDebitController, decoration: const InputDecoration(labelText: 'TotalDebit')),
               const SizedBox(height: 16),
               TextFormField(controller: _totalCreditController, decoration: const InputDecoration(labelText: 'TotalCredit')),
               const SizedBox(height: 16),
               TextFormField(controller: _statusController, decoration: const InputDecoration(labelText: 'Status')),
               const SizedBox(height: 16),
               TextFormField(controller: _postedAtController, decoration: const InputDecoration(labelText: 'PostedAt')),
               const SizedBox(height: 16),
               TextFormField(controller: _postedByController, decoration: const InputDecoration(labelText: 'PostedBy')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('Reversed'), value: _reversed, onChanged: (v) => setState(() => _reversed = v)),
               TextFormField(controller: _reversedByIdController, decoration: const InputDecoration(labelText: 'ReversedById')),
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
