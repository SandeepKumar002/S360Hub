import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/files_repository.dart';

class ShieldFileFormPage extends ConsumerStatefulWidget {
  final String? id;
  const ShieldFileFormPage({super.key, this.id});

  @override
  ConsumerState<ShieldFileFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<ShieldFileFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _referenceTableController = TextEditingController();
  final _referenceIdController = TextEditingController();
  final _fileTypeController = TextEditingController();
  final _fileNameController = TextEditingController();
  final _storagePathController = TextEditingController();
  final _contentTypeController = TextEditingController();
  final _sizeBytesController = TextEditingController();
  final _uploadedByController = TextEditingController();
  final _uploadedAtController = TextEditingController();
  bool _isDeleted = false;
  final _deletedByController = TextEditingController();
  final _deleteTypeController = TextEditingController();
  final _deleteReasonController = TextEditingController();
  final _restoreReasonController = TextEditingController();
  final _restoredAtController = TextEditingController();
  final _restoredByController = TextEditingController();
  final _deletionScheduledAtController = TextEditingController();
  final _permanentDeletionDateController = TextEditingController();
  final _deletionCountController = TextEditingController();
  final _fileVersionController = TextEditingController();
  final _previousVersionIdController = TextEditingController();
  bool _isArchived = false;
  final _archivedAtController = TextEditingController();
  final _archivedByController = TextEditingController();
  final _archiveLocationController = TextEditingController();
  final _checksumController = TextEditingController();

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
      'reference_table': _referenceTableController.text,
      'reference_id': _referenceIdController.text,
      'file_type': _fileTypeController.text,
      'file_name': _fileNameController.text,
      'storage_path': _storagePathController.text,
      'content_type': _contentTypeController.text,
      'size_bytes': int.tryParse(_sizeBytesController.text),
      'uploaded_by': _uploadedByController.text,
      'uploaded_at': _uploadedAtController.text,
      'is_deleted': _isDeleted,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'delete_reason': _deleteReasonController.text,
      'restore_reason': _restoreReasonController.text,
      'restored_at': _restoredAtController.text,
      'restored_by': _restoredByController.text,
      'deletion_scheduled_at': _deletionScheduledAtController.text,
      'permanent_deletion_date': _permanentDeletionDateController.text,
      'deletion_count': int.tryParse(_deletionCountController.text),
      'file_version': int.tryParse(_fileVersionController.text),
      'previous_version_id': _previousVersionIdController.text,
      'is_archived': _isArchived,
      'archived_at': _archivedAtController.text,
      'archived_by': _archivedByController.text,
      'archive_location': _archiveLocationController.text,
      'checksum': _checksumController.text,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(shieldFileRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(shieldFileRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(shieldFileListProvider);
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
               TextFormField(controller: _referenceTableController, decoration: const InputDecoration(labelText: 'ReferenceTable')),
               const SizedBox(height: 16),
               TextFormField(controller: _referenceIdController, decoration: const InputDecoration(labelText: 'ReferenceId')),
               const SizedBox(height: 16),
               TextFormField(controller: _fileTypeController, decoration: const InputDecoration(labelText: 'FileType')),
               const SizedBox(height: 16),
               TextFormField(controller: _fileNameController, decoration: const InputDecoration(labelText: 'FileName')),
               const SizedBox(height: 16),
               TextFormField(controller: _storagePathController, decoration: const InputDecoration(labelText: 'StoragePath')),
               const SizedBox(height: 16),
               TextFormField(controller: _contentTypeController, decoration: const InputDecoration(labelText: 'ContentType')),
               const SizedBox(height: 16),
               TextFormField(controller: _sizeBytesController, decoration: const InputDecoration(labelText: 'SizeBytes')),
               const SizedBox(height: 16),
               TextFormField(controller: _uploadedByController, decoration: const InputDecoration(labelText: 'UploadedBy')),
               const SizedBox(height: 16),
               TextFormField(controller: _uploadedAtController, decoration: const InputDecoration(labelText: 'UploadedAt')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('IsDeleted'), value: _isDeleted, onChanged: (v) => setState(() => _isDeleted = v)),
               TextFormField(controller: _deletedByController, decoration: const InputDecoration(labelText: 'DeletedBy')),
               const SizedBox(height: 16),
               TextFormField(controller: _deleteTypeController, decoration: const InputDecoration(labelText: 'DeleteType')),
               const SizedBox(height: 16),
               TextFormField(controller: _deleteReasonController, decoration: const InputDecoration(labelText: 'DeleteReason')),
               const SizedBox(height: 16),
               TextFormField(controller: _restoreReasonController, decoration: const InputDecoration(labelText: 'RestoreReason')),
               const SizedBox(height: 16),
               TextFormField(controller: _restoredAtController, decoration: const InputDecoration(labelText: 'RestoredAt')),
               const SizedBox(height: 16),
               TextFormField(controller: _restoredByController, decoration: const InputDecoration(labelText: 'RestoredBy')),
               const SizedBox(height: 16),
               TextFormField(controller: _deletionScheduledAtController, decoration: const InputDecoration(labelText: 'DeletionScheduledAt')),
               const SizedBox(height: 16),
               TextFormField(controller: _permanentDeletionDateController, decoration: const InputDecoration(labelText: 'PermanentDeletionDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _deletionCountController, decoration: const InputDecoration(labelText: 'DeletionCount')),
               const SizedBox(height: 16),
               TextFormField(controller: _fileVersionController, decoration: const InputDecoration(labelText: 'FileVersion')),
               const SizedBox(height: 16),
               TextFormField(controller: _previousVersionIdController, decoration: const InputDecoration(labelText: 'PreviousVersionId')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('IsArchived'), value: _isArchived, onChanged: (v) => setState(() => _isArchived = v)),
               TextFormField(controller: _archivedAtController, decoration: const InputDecoration(labelText: 'ArchivedAt')),
               const SizedBox(height: 16),
               TextFormField(controller: _archivedByController, decoration: const InputDecoration(labelText: 'ArchivedBy')),
               const SizedBox(height: 16),
               TextFormField(controller: _archiveLocationController, decoration: const InputDecoration(labelText: 'ArchiveLocation')),
               const SizedBox(height: 16),
               TextFormField(controller: _checksumController, decoration: const InputDecoration(labelText: 'Checksum')),
               const SizedBox(height: 16),
               const SizedBox(height: 24),
               ElevatedButton(onPressed: _isLoading ? null : _save, child: const Text('Save')),
             ],
          ),
        ),
      ),
    );
  }
}
