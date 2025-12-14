import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/committee_members_repository.dart';

class CommitteeCommitteeMemberFormPage extends ConsumerStatefulWidget {
  final String? id;
  const CommitteeCommitteeMemberFormPage({super.key, this.id});

  @override
  ConsumerState<CommitteeCommitteeMemberFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<CommitteeCommitteeMemberFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _committeeIdController = TextEditingController();
  final _personIdController = TextEditingController();
  final _memberRoleController = TextEditingController();
  final _appointmentDateController = TextEditingController();
  final _termEndDateController = TextEditingController();
  bool _isActive = false;
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
      'committee_id': _committeeIdController.text,
      'person_id': _personIdController.text,
      'member_role': _memberRoleController.text,
      'appointment_date': _appointmentDateController.text,
      'term_end_date': _termEndDateController.text,
      'is_active': _isActive,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(committeeCommitteeMemberRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(committeeCommitteeMemberRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(committeeCommitteeMemberListProvider);
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
               TextFormField(controller: _committeeIdController, decoration: const InputDecoration(labelText: 'CommitteeId')),
               const SizedBox(height: 16),
               TextFormField(controller: _personIdController, decoration: const InputDecoration(labelText: 'PersonId')),
               const SizedBox(height: 16),
               TextFormField(controller: _memberRoleController, decoration: const InputDecoration(labelText: 'MemberRole')),
               const SizedBox(height: 16),
               TextFormField(controller: _appointmentDateController, decoration: const InputDecoration(labelText: 'AppointmentDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _termEndDateController, decoration: const InputDecoration(labelText: 'TermEndDate')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('IsActive'), value: _isActive, onChanged: (v) => setState(() => _isActive = v)),
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
