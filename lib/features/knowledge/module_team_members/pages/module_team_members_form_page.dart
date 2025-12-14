import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/module_team_members_repository.dart';

class KnowledgeModuleTeamMemberFormPage extends ConsumerStatefulWidget {
  final String? id;
  const KnowledgeModuleTeamMemberFormPage({super.key, this.id});

  @override
  ConsumerState<KnowledgeModuleTeamMemberFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<KnowledgeModuleTeamMemberFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _teamIdController = TextEditingController();
  final _personIdController = TextEditingController();
  final _roleCodeController = TextEditingController();
  bool _isPrimary = false;
  final _joinedAtController = TextEditingController();
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
      'team_id': _teamIdController.text,
      'person_id': _personIdController.text,
      'role_code': _roleCodeController.text,
      'is_primary': _isPrimary,
      'joined_at': _joinedAtController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(knowledgeModuleTeamMemberRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(knowledgeModuleTeamMemberRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(knowledgeModuleTeamMemberListProvider);
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
               TextFormField(controller: _teamIdController, decoration: const InputDecoration(labelText: 'TeamId')),
               const SizedBox(height: 16),
               TextFormField(controller: _personIdController, decoration: const InputDecoration(labelText: 'PersonId')),
               const SizedBox(height: 16),
               TextFormField(controller: _roleCodeController, decoration: const InputDecoration(labelText: 'RoleCode')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('IsPrimary'), value: _isPrimary, onChanged: (v) => setState(() => _isPrimary = v)),
               TextFormField(controller: _joinedAtController, decoration: const InputDecoration(labelText: 'JoinedAt')),
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
