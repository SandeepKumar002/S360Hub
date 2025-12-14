import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/certifications_repository.dart';

class TrainingCertificationFormPage extends ConsumerStatefulWidget {
  final String? id;
  const TrainingCertificationFormPage({super.key, this.id});

  @override
  ConsumerState<TrainingCertificationFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<TrainingCertificationFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _employeeIdController = TextEditingController();
  final _courseIdController = TextEditingController();
  final _certificateNoController = TextEditingController();
  final _issueDateController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _fileIdController = TextEditingController();
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
      'course_id': _courseIdController.text,
      'certificate_no': _certificateNoController.text,
      'issue_date': _issueDateController.text,
      'expiry_date': _expiryDateController.text,
      'file_id': _fileIdController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(trainingCertificationRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(trainingCertificationRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(trainingCertificationListProvider);
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
               TextFormField(controller: _courseIdController, decoration: const InputDecoration(labelText: 'CourseId')),
               const SizedBox(height: 16),
               TextFormField(controller: _certificateNoController, decoration: const InputDecoration(labelText: 'CertificateNo')),
               const SizedBox(height: 16),
               TextFormField(controller: _issueDateController, decoration: const InputDecoration(labelText: 'IssueDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _expiryDateController, decoration: const InputDecoration(labelText: 'ExpiryDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _fileIdController, decoration: const InputDecoration(labelText: 'FileId')),
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
