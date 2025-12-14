import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/sessions_repository.dart';

class TrainingSessionFormPage extends ConsumerStatefulWidget {
  final String? id;
  const TrainingSessionFormPage({super.key, this.id});

  @override
  ConsumerState<TrainingSessionFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<TrainingSessionFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _courseIdController = TextEditingController();
  final _sessionDateStartController = TextEditingController();
  final _sessionDateEndController = TextEditingController();
  final _instructorIdController = TextEditingController();
  final _locationController = TextEditingController();
  final _maxSeatsController = TextEditingController();
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
      'session_date_start': _sessionDateStartController.text,
      'session_date_end': _sessionDateEndController.text,
      'instructor_id': _instructorIdController.text,
      'location': _locationController.text,
      'max_seats': int.tryParse(_maxSeatsController.text),
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(trainingSessionRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(trainingSessionRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(trainingSessionListProvider);
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
               TextFormField(controller: _sessionDateStartController, decoration: const InputDecoration(labelText: 'SessionDateStart')),
               const SizedBox(height: 16),
               TextFormField(controller: _sessionDateEndController, decoration: const InputDecoration(labelText: 'SessionDateEnd')),
               const SizedBox(height: 16),
               TextFormField(controller: _instructorIdController, decoration: const InputDecoration(labelText: 'InstructorId')),
               const SizedBox(height: 16),
               TextFormField(controller: _locationController, decoration: const InputDecoration(labelText: 'Location')),
               const SizedBox(height: 16),
               TextFormField(controller: _maxSeatsController, decoration: const InputDecoration(labelText: 'MaxSeats')),
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
