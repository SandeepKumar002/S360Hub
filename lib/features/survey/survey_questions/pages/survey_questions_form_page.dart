import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/survey_questions_repository.dart';

class SurveySurveyQuestionFormPage extends ConsumerStatefulWidget {
  final String? id;
  const SurveySurveyQuestionFormPage({super.key, this.id});

  @override
  ConsumerState<SurveySurveyQuestionFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<SurveySurveyQuestionFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _surveyIdController = TextEditingController();
  final _qTextController = TextEditingController();
  final _qTypeController = TextEditingController();
  final _optionsController = TextEditingController();
  bool _mandatory = false;
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
      'survey_id': _surveyIdController.text,
      'q_text': _qTextController.text,
      'q_type': _qTypeController.text,
      'options': _optionsController.text,
      'mandatory': _mandatory,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(surveySurveyQuestionRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(surveySurveyQuestionRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(surveySurveyQuestionListProvider);
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
               TextFormField(controller: _surveyIdController, decoration: const InputDecoration(labelText: 'SurveyId')),
               const SizedBox(height: 16),
               TextFormField(controller: _qTextController, decoration: const InputDecoration(labelText: 'QText')),
               const SizedBox(height: 16),
               TextFormField(controller: _qTypeController, decoration: const InputDecoration(labelText: 'QType')),
               const SizedBox(height: 16),
               TextFormField(controller: _optionsController, decoration: const InputDecoration(labelText: 'Options')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('Mandatory'), value: _mandatory, onChanged: (v) => setState(() => _mandatory = v)),
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
