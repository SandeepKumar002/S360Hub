import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/module_role_assignments_repository.dart';

class KnowledgeModuleRoleAssignmentFormPage extends ConsumerStatefulWidget {
  final String? id;
  const KnowledgeModuleRoleAssignmentFormPage({super.key, this.id});

  @override
  ConsumerState<KnowledgeModuleRoleAssignmentFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<KnowledgeModuleRoleAssignmentFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _roleIdController = TextEditingController();
  final _personIdController = TextEditingController();
  final _teamIdController = TextEditingController();
  final _scopeController = TextEditingController();
  bool _active = false;
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
      'role_id': _roleIdController.text,
      'person_id': _personIdController.text,
      'team_id': _teamIdController.text,
      'scope': _scopeController.text,
      'active': _active,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(knowledgeModuleRoleAssignmentRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(knowledgeModuleRoleAssignmentRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(knowledgeModuleRoleAssignmentListProvider);
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
               TextFormField(controller: _roleIdController, decoration: const InputDecoration(labelText: 'RoleId')),
               const SizedBox(height: 16),
               TextFormField(controller: _personIdController, decoration: const InputDecoration(labelText: 'PersonId')),
               const SizedBox(height: 16),
               TextFormField(controller: _teamIdController, decoration: const InputDecoration(labelText: 'TeamId')),
               const SizedBox(height: 16),
               TextFormField(controller: _scopeController, decoration: const InputDecoration(labelText: 'Scope')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('Active'), value: _active, onChanged: (v) => setState(() => _active = v)),
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
