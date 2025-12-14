import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/proposals_repository.dart';

class LedgieProposalFormPage extends ConsumerStatefulWidget {
  final String? id;
  const LedgieProposalFormPage({super.key, this.id});

  @override
  ConsumerState<LedgieProposalFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<LedgieProposalFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _entityIdController = TextEditingController();
  final _proposalCodeController = TextEditingController();
  final _titleController = TextEditingController();
  final _sectorController = TextEditingController();
  final _proposalScopeController = TextEditingController();
  final _statusController = TextEditingController();
  final _submittedDateController = TextEditingController();
  final _validUntilController = TextEditingController();
  final _remarksController = TextEditingController();
  final _deletedByController = TextEditingController();
  final _deleteTypeController = TextEditingController();
  bool _isDeleted = false;
  final _leadsProspectIdController = TextEditingController();

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
      'proposal_code': _proposalCodeController.text,
      'title': _titleController.text,
      'sector': _sectorController.text,
      'proposal_scope': _proposalScopeController.text,
      'status': _statusController.text,
      'submitted_date': _submittedDateController.text,
      'valid_until': _validUntilController.text,
      'remarks': _remarksController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
      'leads_prospect_id': _leadsProspectIdController.text,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(ledgieProposalRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(ledgieProposalRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(ledgieProposalListProvider);
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
               TextFormField(controller: _proposalCodeController, decoration: const InputDecoration(labelText: 'ProposalCode')),
               const SizedBox(height: 16),
               TextFormField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
               const SizedBox(height: 16),
               TextFormField(controller: _sectorController, decoration: const InputDecoration(labelText: 'Sector')),
               const SizedBox(height: 16),
               TextFormField(controller: _proposalScopeController, decoration: const InputDecoration(labelText: 'ProposalScope')),
               const SizedBox(height: 16),
               TextFormField(controller: _statusController, decoration: const InputDecoration(labelText: 'Status')),
               const SizedBox(height: 16),
               TextFormField(controller: _submittedDateController, decoration: const InputDecoration(labelText: 'SubmittedDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _validUntilController, decoration: const InputDecoration(labelText: 'ValidUntil')),
               const SizedBox(height: 16),
               TextFormField(controller: _remarksController, decoration: const InputDecoration(labelText: 'Remarks')),
               const SizedBox(height: 16),
               TextFormField(controller: _deletedByController, decoration: const InputDecoration(labelText: 'DeletedBy')),
               const SizedBox(height: 16),
               TextFormField(controller: _deleteTypeController, decoration: const InputDecoration(labelText: 'DeleteType')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('IsDeleted'), value: _isDeleted, onChanged: (v) => setState(() => _isDeleted = v)),
               TextFormField(controller: _leadsProspectIdController, decoration: const InputDecoration(labelText: 'LeadsProspectId')),
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
