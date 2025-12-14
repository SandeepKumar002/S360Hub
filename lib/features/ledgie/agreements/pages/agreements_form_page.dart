import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/agreements_repository.dart';

class LedgieAgreementFormPage extends ConsumerStatefulWidget {
  final String? id;
  const LedgieAgreementFormPage({super.key, this.id});

  @override
  ConsumerState<LedgieAgreementFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<LedgieAgreementFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _entityIdController = TextEditingController();
  final _agreementTypeController = TextEditingController();
  final _agreementNumberController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _valueController = TextEditingController();
  final _currencyController = TextEditingController();
  final _termsController = TextEditingController();
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
      'entity_id': _entityIdController.text,
      'agreement_type': _agreementTypeController.text,
      'agreement_number': _agreementNumberController.text,
      'start_date': _startDateController.text,
      'end_date': _endDateController.text,
      'value': double.tryParse(_valueController.text),
      'currency': _currencyController.text,
      'terms': _termsController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(ledgieAgreementRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(ledgieAgreementRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(ledgieAgreementListProvider);
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
               TextFormField(controller: _entityIdController, decoration: const InputDecoration(labelText: 'EntityId')),
               const SizedBox(height: 16),
               TextFormField(controller: _agreementTypeController, decoration: const InputDecoration(labelText: 'AgreementType')),
               const SizedBox(height: 16),
               TextFormField(controller: _agreementNumberController, decoration: const InputDecoration(labelText: 'AgreementNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _startDateController, decoration: const InputDecoration(labelText: 'StartDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _endDateController, decoration: const InputDecoration(labelText: 'EndDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _valueController, decoration: const InputDecoration(labelText: 'Value')),
               const SizedBox(height: 16),
               TextFormField(controller: _currencyController, decoration: const InputDecoration(labelText: 'Currency')),
               const SizedBox(height: 16),
               TextFormField(controller: _termsController, decoration: const InputDecoration(labelText: 'Terms')),
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
