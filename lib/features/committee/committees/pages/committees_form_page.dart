import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/committees_repository.dart';

class CommitteeCommitteeFormPage extends ConsumerStatefulWidget {
  final String? id;
  const CommitteeCommitteeFormPage({super.key, this.id});

  @override
  ConsumerState<CommitteeCommitteeFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<CommitteeCommitteeFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _committeeNameController = TextEditingController();
  final _committeeTypeController = TextEditingController();
  final _formationDateController = TextEditingController();
  final _validityPeriodController = TextEditingController();
  final _dissolutionDateController = TextEditingController();
  final _committeeObjectiveController = TextEditingController();
  final _committeeStatusController = TextEditingController();
  final _charterFileIdController = TextEditingController();
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
      'committee_name': _committeeNameController.text,
      'committee_type': _committeeTypeController.text,
      'formation_date': _formationDateController.text,
      'validity_period': _validityPeriodController.text,
      'dissolution_date': _dissolutionDateController.text,
      'committee_objective': _committeeObjectiveController.text,
      'committee_status': _committeeStatusController.text,
      'charter_file_id': _charterFileIdController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(committeeCommitteeRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(committeeCommitteeRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(committeeCommitteeListProvider);
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
               TextFormField(controller: _committeeNameController, decoration: const InputDecoration(labelText: 'CommitteeName')),
               const SizedBox(height: 16),
               TextFormField(controller: _committeeTypeController, decoration: const InputDecoration(labelText: 'CommitteeType')),
               const SizedBox(height: 16),
               TextFormField(controller: _formationDateController, decoration: const InputDecoration(labelText: 'FormationDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _validityPeriodController, decoration: const InputDecoration(labelText: 'ValidityPeriod')),
               const SizedBox(height: 16),
               TextFormField(controller: _dissolutionDateController, decoration: const InputDecoration(labelText: 'DissolutionDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _committeeObjectiveController, decoration: const InputDecoration(labelText: 'CommitteeObjective')),
               const SizedBox(height: 16),
               TextFormField(controller: _committeeStatusController, decoration: const InputDecoration(labelText: 'CommitteeStatus')),
               const SizedBox(height: 16),
               TextFormField(controller: _charterFileIdController, decoration: const InputDecoration(labelText: 'CharterFileId')),
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
