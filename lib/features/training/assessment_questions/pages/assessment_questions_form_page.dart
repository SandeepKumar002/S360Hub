import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/assessment_questions_repository.dart';

class TrainingAssessmentQuestionFormPage extends ConsumerStatefulWidget {
  final String? id;
  const TrainingAssessmentQuestionFormPage({super.key, this.id});

  @override
  ConsumerState<TrainingAssessmentQuestionFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<TrainingAssessmentQuestionFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _assessmentIdController = TextEditingController();
  final _qTypeController = TextEditingController();
  final _questionController = TextEditingController();
  final _optionsController = TextEditingController();
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
      'q_type': _qTypeController.text,
      'question': _questionController.text,
      'options': _optionsController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(trainingAssessmentQuestionRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(trainingAssessmentQuestionRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(trainingAssessmentQuestionListProvider);
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
               TextFormField(controller: _qTypeController, decoration: const InputDecoration(labelText: 'QType')),
               const SizedBox(height: 16),
               TextFormField(controller: _questionController, decoration: const InputDecoration(labelText: 'Question')),
               const SizedBox(height: 16),
               TextFormField(controller: _optionsController, decoration: const InputDecoration(labelText: 'Options')),
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
