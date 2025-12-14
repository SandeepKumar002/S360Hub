import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/grievance_complaints_repository.dart';

class ShieldGrievanceComplaintFormPage extends ConsumerStatefulWidget {
  final String? id;
  const ShieldGrievanceComplaintFormPage({super.key, this.id});

  @override
  ConsumerState<ShieldGrievanceComplaintFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<ShieldGrievanceComplaintFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _complaintIdController = TextEditingController();
  final _complaintTypeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _complaintDateController = TextEditingController();
  final _complainantIdController = TextEditingController();
  final _respondentIdController = TextEditingController();
  final _statusController = TextEditingController();
  final _assignedToController = TextEditingController();
  final _resolutionDescriptionController = TextEditingController();
  final _resolutionDateController = TextEditingController();
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
      'complaint_id': _complaintIdController.text,
      'complaint_type': _complaintTypeController.text,
      'description': _descriptionController.text,
      'complaint_date': _complaintDateController.text,
      'complainant_id': _complainantIdController.text,
      'respondent_id': _respondentIdController.text,
      'status': _statusController.text,
      'assigned_to': _assignedToController.text,
      'resolution_description': _resolutionDescriptionController.text,
      'resolution_date': _resolutionDateController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(shieldGrievanceComplaintRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(shieldGrievanceComplaintRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(shieldGrievanceComplaintListProvider);
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
               TextFormField(controller: _complaintIdController, decoration: const InputDecoration(labelText: 'ComplaintId')),
               const SizedBox(height: 16),
               TextFormField(controller: _complaintTypeController, decoration: const InputDecoration(labelText: 'ComplaintType')),
               const SizedBox(height: 16),
               TextFormField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Description')),
               const SizedBox(height: 16),
               TextFormField(controller: _complaintDateController, decoration: const InputDecoration(labelText: 'ComplaintDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _complainantIdController, decoration: const InputDecoration(labelText: 'ComplainantId')),
               const SizedBox(height: 16),
               TextFormField(controller: _respondentIdController, decoration: const InputDecoration(labelText: 'RespondentId')),
               const SizedBox(height: 16),
               TextFormField(controller: _statusController, decoration: const InputDecoration(labelText: 'Status')),
               const SizedBox(height: 16),
               TextFormField(controller: _assignedToController, decoration: const InputDecoration(labelText: 'AssignedTo')),
               const SizedBox(height: 16),
               TextFormField(controller: _resolutionDescriptionController, decoration: const InputDecoration(labelText: 'ResolutionDescription')),
               const SizedBox(height: 16),
               TextFormField(controller: _resolutionDateController, decoration: const InputDecoration(labelText: 'ResolutionDate')),
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
