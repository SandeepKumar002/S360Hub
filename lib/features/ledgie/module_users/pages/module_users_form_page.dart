import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/module_users_repository.dart';

class LedgieModuleUserFormPage extends ConsumerStatefulWidget {
  final String? id;
  const LedgieModuleUserFormPage({super.key, this.id});

  @override
  ConsumerState<LedgieModuleUserFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<LedgieModuleUserFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _personIdController = TextEditingController();
  final _moduleRoleController = TextEditingController();
  final _designationController = TextEditingController();
  final _permissionsController = TextEditingController();
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
      'module_role': _moduleRoleController.text,
      'designation': _designationController.text,
      'permissions': _permissionsController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(ledgieModuleUserRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(ledgieModuleUserRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(ledgieModuleUserListProvider);
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
               TextFormField(controller: _moduleRoleController, decoration: const InputDecoration(labelText: 'ModuleRole')),
               const SizedBox(height: 16),
               TextFormField(controller: _designationController, decoration: const InputDecoration(labelText: 'Designation')),
               const SizedBox(height: 16),
               TextFormField(controller: _permissionsController, decoration: const InputDecoration(labelText: 'Permissions')),
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
