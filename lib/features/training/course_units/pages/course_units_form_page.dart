import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/course_units_repository.dart';

class TrainingCourseUnitFormPage extends ConsumerStatefulWidget {
  final String? id;
  const TrainingCourseUnitFormPage({super.key, this.id});

  @override
  ConsumerState<TrainingCourseUnitFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<TrainingCourseUnitFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _courseIdController = TextEditingController();
  final _titleController = TextEditingController();
  final _contentRefIdController = TextEditingController();
  final _sequenceController = TextEditingController();
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
      'course_id': _courseIdController.text,
      'title': _titleController.text,
      'content_ref_id': _contentRefIdController.text,
      'sequence': int.tryParse(_sequenceController.text),
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(trainingCourseUnitRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(trainingCourseUnitRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(trainingCourseUnitListProvider);
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
               TextFormField(controller: _courseIdController, decoration: const InputDecoration(labelText: 'CourseId')),
               const SizedBox(height: 16),
               TextFormField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
               const SizedBox(height: 16),
               TextFormField(controller: _contentRefIdController, decoration: const InputDecoration(labelText: 'ContentRefId')),
               const SizedBox(height: 16),
               TextFormField(controller: _sequenceController, decoration: const InputDecoration(labelText: 'Sequence')),
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
