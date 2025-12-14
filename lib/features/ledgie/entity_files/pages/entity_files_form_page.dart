import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/entity_files_repository.dart';

class LedgieEntityFileFormPage extends ConsumerStatefulWidget {
  final String? id;
  const LedgieEntityFileFormPage({super.key, this.id});

  @override
  ConsumerState<LedgieEntityFileFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<LedgieEntityFileFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _entityIdController = TextEditingController();
  final _fileIdController = TextEditingController();
  final _fileTypeController = TextEditingController();
  final _fileStatusController = TextEditingController();
  final _uploadedAtController = TextEditingController();
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
      'entity_id': _entityIdController.text,
      'file_id': _fileIdController.text,
      'file_type': _fileTypeController.text,
      'file_status': _fileStatusController.text,
      'uploaded_at': _uploadedAtController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(ledgieEntityFileRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(ledgieEntityFileRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(ledgieEntityFileListProvider);
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
               TextFormField(controller: _entityIdController, decoration: const InputDecoration(labelText: 'EntityId')),
               const SizedBox(height: 16),
               TextFormField(controller: _fileIdController, decoration: const InputDecoration(labelText: 'FileId')),
               const SizedBox(height: 16),
               TextFormField(controller: _fileTypeController, decoration: const InputDecoration(labelText: 'FileType')),
               const SizedBox(height: 16),
               TextFormField(controller: _fileStatusController, decoration: const InputDecoration(labelText: 'FileStatus')),
               const SizedBox(height: 16),
               TextFormField(controller: _uploadedAtController, decoration: const InputDecoration(labelText: 'UploadedAt')),
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
