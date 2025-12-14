import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/ppe_issued_repository.dart';

class ShieldPpeIssuedFormPage extends ConsumerStatefulWidget {
  final String? id;
  const ShieldPpeIssuedFormPage({super.key, this.id});

  @override
  ConsumerState<ShieldPpeIssuedFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<ShieldPpeIssuedFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _employeeIdController = TextEditingController();
  final _ppeTypeController = TextEditingController();
  final _ppeDescriptionController = TextEditingController();
  final _quantityController = TextEditingController();
  final _issueDateController = TextEditingController();
  final _expectedReturnDateController = TextEditingController();
  final _issuedByController = TextEditingController();
  final _acknowledgementFileIdController = TextEditingController();
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
      'employee_id': _employeeIdController.text,
      'ppe_type': _ppeTypeController.text,
      'ppe_description': _ppeDescriptionController.text,
      'quantity': int.tryParse(_quantityController.text),
      'issue_date': _issueDateController.text,
      'expected_return_date': _expectedReturnDateController.text,
      'issued_by': _issuedByController.text,
      'acknowledgement_file_id': _acknowledgementFileIdController.text,
      'status': _statusController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(shieldPpeIssuedRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(shieldPpeIssuedRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(shieldPpeIssuedListProvider);
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
               TextFormField(controller: _employeeIdController, decoration: const InputDecoration(labelText: 'EmployeeId')),
               const SizedBox(height: 16),
               TextFormField(controller: _ppeTypeController, decoration: const InputDecoration(labelText: 'PpeType')),
               const SizedBox(height: 16),
               TextFormField(controller: _ppeDescriptionController, decoration: const InputDecoration(labelText: 'PpeDescription')),
               const SizedBox(height: 16),
               TextFormField(controller: _quantityController, decoration: const InputDecoration(labelText: 'Quantity')),
               const SizedBox(height: 16),
               TextFormField(controller: _issueDateController, decoration: const InputDecoration(labelText: 'IssueDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _expectedReturnDateController, decoration: const InputDecoration(labelText: 'ExpectedReturnDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _issuedByController, decoration: const InputDecoration(labelText: 'IssuedBy')),
               const SizedBox(height: 16),
               TextFormField(controller: _acknowledgementFileIdController, decoration: const InputDecoration(labelText: 'AcknowledgementFileId')),
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
