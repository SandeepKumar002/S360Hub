import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/contracts_repository.dart';

class ContracforceContractFormPage extends ConsumerStatefulWidget {
  final String? id;
  const ContracforceContractFormPage({super.key, this.id});

  @override
  ConsumerState<ContracforceContractFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<ContracforceContractFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _contractorIdController = TextEditingController();
  final _contractNumberController = TextEditingController();
  final _contractTypeController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _scopeOfWorkController = TextEditingController();
  final _contractValueController = TextEditingController();
  final _paymentTermsController = TextEditingController();
  bool _autoRenew = false;
  final _contractFileIdController = TextEditingController();
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
      'contractor_id': _contractorIdController.text,
      'contract_number': _contractNumberController.text,
      'contract_type': _contractTypeController.text,
      'start_date': _startDateController.text,
      'end_date': _endDateController.text,
      'scope_of_work': _scopeOfWorkController.text,
      'contract_value': double.tryParse(_contractValueController.text),
      'payment_terms': _paymentTermsController.text,
      'auto_renew': _autoRenew,
      'contract_file_id': _contractFileIdController.text,
      'status': _statusController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(contracforceContractRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(contracforceContractRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(contracforceContractListProvider);
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
               TextFormField(controller: _contractorIdController, decoration: const InputDecoration(labelText: 'ContractorId')),
               const SizedBox(height: 16),
               TextFormField(controller: _contractNumberController, decoration: const InputDecoration(labelText: 'ContractNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _contractTypeController, decoration: const InputDecoration(labelText: 'ContractType')),
               const SizedBox(height: 16),
               TextFormField(controller: _startDateController, decoration: const InputDecoration(labelText: 'StartDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _endDateController, decoration: const InputDecoration(labelText: 'EndDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _scopeOfWorkController, decoration: const InputDecoration(labelText: 'ScopeOfWork')),
               const SizedBox(height: 16),
               TextFormField(controller: _contractValueController, decoration: const InputDecoration(labelText: 'ContractValue')),
               const SizedBox(height: 16),
               TextFormField(controller: _paymentTermsController, decoration: const InputDecoration(labelText: 'PaymentTerms')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('AutoRenew'), value: _autoRenew, onChanged: (v) => setState(() => _autoRenew = v)),
               TextFormField(controller: _contractFileIdController, decoration: const InputDecoration(labelText: 'ContractFileId')),
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
