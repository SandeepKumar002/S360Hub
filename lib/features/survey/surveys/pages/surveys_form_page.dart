import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/surveys_repository.dart';

class SurveySurveyFormPage extends ConsumerStatefulWidget {
  final String? id;
  const SurveySurveyFormPage({super.key, this.id});

  @override
  ConsumerState<SurveySurveyFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<SurveySurveyFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _surveyTypeController = TextEditingController();
  bool _isActive = false;

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
      'title': _titleController.text,
      'description': _descriptionController.text,
      'survey_type': _surveyTypeController.text,
      'is_active': _isActive,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(surveySurveyRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(surveySurveyRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(surveySurveyListProvider);
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
               TextFormField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
               const SizedBox(height: 16),
               TextFormField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Description')),
               const SizedBox(height: 16),
               TextFormField(controller: _surveyTypeController, decoration: const InputDecoration(labelText: 'SurveyType')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('IsActive'), value: _isActive, onChanged: (v) => setState(() => _isActive = v)),
               const SizedBox(height: 24),
               ElevatedButton(onPressed: _isLoading ? null : _save, child: const Text('Save')),
             ],
          ),
        ),
      ),
    );
  }
}
