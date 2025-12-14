import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/assessment_attempts_repository.dart';

class TrainingAssessmentAttemptFormPage extends ConsumerStatefulWidget {
  final String? id;
  const TrainingAssessmentAttemptFormPage({super.key, this.id});

  @override
  ConsumerState<TrainingAssessmentAttemptFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<TrainingAssessmentAttemptFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _assessmentIdController = TextEditingController();
  final _employeeIdController = TextEditingController();
  final _attemptDateController = TextEditingController();
  final _scoreController = TextEditingController();
  final _responsesController = TextEditingController();
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
      'assessment_id': _assessmentIdController.text,
      'employee_id': _employeeIdController.text,
      'attempt_date': _attemptDateController.text,
      'score': double.tryParse(_scoreController.text),
      'responses': _responsesController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(trainingAssessmentAttemptRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(trainingAssessmentAttemptRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(trainingAssessmentAttemptListProvider);
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
               TextFormField(controller: _assessmentIdController, decoration: const InputDecoration(labelText: 'AssessmentId')),
               const SizedBox(height: 16),
               TextFormField(controller: _employeeIdController, decoration: const InputDecoration(labelText: 'EmployeeId')),
               const SizedBox(height: 16),
               TextFormField(controller: _attemptDateController, decoration: const InputDecoration(labelText: 'AttemptDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _scoreController, decoration: const InputDecoration(labelText: 'Score')),
               const SizedBox(height: 16),
               TextFormField(controller: _responsesController, decoration: const InputDecoration(labelText: 'Responses')),
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
