import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/enrollments_repository.dart';

class TrainingEnrollmentFormPage extends ConsumerStatefulWidget {
  final String? id;
  const TrainingEnrollmentFormPage({super.key, this.id});

  @override
  ConsumerState<TrainingEnrollmentFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<TrainingEnrollmentFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _sessionIdController = TextEditingController();
  final _employeeIdController = TextEditingController();
  final _statusController = TextEditingController();
  final _scoreController = TextEditingController();
  final _completedAtController = TextEditingController();
  final _feedbackController = TextEditingController();
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
      'session_id': _sessionIdController.text,
      'employee_id': _employeeIdController.text,
      'status': _statusController.text,
      'score': double.tryParse(_scoreController.text),
      'completed_at': _completedAtController.text,
      'feedback': _feedbackController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(trainingEnrollmentRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(trainingEnrollmentRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(trainingEnrollmentListProvider);
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
               TextFormField(controller: _sessionIdController, decoration: const InputDecoration(labelText: 'SessionId')),
               const SizedBox(height: 16),
               TextFormField(controller: _employeeIdController, decoration: const InputDecoration(labelText: 'EmployeeId')),
               const SizedBox(height: 16),
               TextFormField(controller: _statusController, decoration: const InputDecoration(labelText: 'Status')),
               const SizedBox(height: 16),
               TextFormField(controller: _scoreController, decoration: const InputDecoration(labelText: 'Score')),
               const SizedBox(height: 16),
               TextFormField(controller: _completedAtController, decoration: const InputDecoration(labelText: 'CompletedAt')),
               const SizedBox(height: 16),
               TextFormField(controller: _feedbackController, decoration: const InputDecoration(labelText: 'Feedback')),
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
