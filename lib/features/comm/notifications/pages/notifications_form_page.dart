import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/notifications_repository.dart';

class CommNotificationFormPage extends ConsumerStatefulWidget {
  final String? id;
  const CommNotificationFormPage({super.key, this.id});

  @override
  ConsumerState<CommNotificationFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<CommNotificationFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _personIdController = TextEditingController();
  final _referenceTableController = TextEditingController();
  final _referenceIdController = TextEditingController();
  final _typeController = TextEditingController();
  final _payloadController = TextEditingController();
  bool _delivered = false;
  final _readAtController = TextEditingController();
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
      'person_id': _personIdController.text,
      'reference_table': _referenceTableController.text,
      'reference_id': _referenceIdController.text,
      'type': _typeController.text,
      'payload': _payloadController.text,
      'delivered': _delivered,
      'read_at': _readAtController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(commNotificationRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(commNotificationRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(commNotificationListProvider);
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
               TextFormField(controller: _personIdController, decoration: const InputDecoration(labelText: 'PersonId')),
               const SizedBox(height: 16),
               TextFormField(controller: _referenceTableController, decoration: const InputDecoration(labelText: 'ReferenceTable')),
               const SizedBox(height: 16),
               TextFormField(controller: _referenceIdController, decoration: const InputDecoration(labelText: 'ReferenceId')),
               const SizedBox(height: 16),
               TextFormField(controller: _typeController, decoration: const InputDecoration(labelText: 'Type')),
               const SizedBox(height: 16),
               TextFormField(controller: _payloadController, decoration: const InputDecoration(labelText: 'Payload')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('Delivered'), value: _delivered, onChanged: (v) => setState(() => _delivered = v)),
               TextFormField(controller: _readAtController, decoration: const InputDecoration(labelText: 'ReadAt')),
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
