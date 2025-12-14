import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/posh_complaints_repository.dart';

class ShieldPoshComplaintFormPage extends ConsumerStatefulWidget {
  final String? id;
  const ShieldPoshComplaintFormPage({super.key, this.id});

  @override
  ConsumerState<ShieldPoshComplaintFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<ShieldPoshComplaintFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _complaintIdController = TextEditingController();
  final _complaintTypeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _complaintDateController = TextEditingController();
  final _complainantIdController = TextEditingController();
  final _complainantNameController = TextEditingController();
  final _respondentIdController = TextEditingController();
  final _respondentNameController = TextEditingController();
  final _locationGeoController = TextEditingController();
  final _supportingFileIdController = TextEditingController();
  bool _confidentialityRequested = false;
  final _statusController = TextEditingController();
  final _assignedToController = TextEditingController();
  final _assignedCommitteeIdController = TextEditingController();
  final _investigationStartController = TextEditingController();
  final _investigationEndController = TextEditingController();
  final _resolutionDescriptionController = TextEditingController();
  final _resolutionDateController = TextEditingController();
  final _actionTakenController = TextEditingController();
  bool _followupRequired = false;
  final _followupDateController = TextEditingController();
  final _escalationLevelController = TextEditingController();
  final _actionTakenByController = TextEditingController();
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
      'complaint_id': _complaintIdController.text,
      'complaint_type': _complaintTypeController.text,
      'description': _descriptionController.text,
      'complaint_date': _complaintDateController.text,
      'complainant_id': _complainantIdController.text,
      'complainant_name': _complainantNameController.text,
      'respondent_id': _respondentIdController.text,
      'respondent_name': _respondentNameController.text,
      'location_geo': _locationGeoController.text,
      'supporting_file_id': _supportingFileIdController.text,
      'confidentiality_requested': _confidentialityRequested,
      'status': _statusController.text,
      'assigned_to': _assignedToController.text,
      'assigned_committee_id': _assignedCommitteeIdController.text,
      'investigation_start': _investigationStartController.text,
      'investigation_end': _investigationEndController.text,
      'resolution_description': _resolutionDescriptionController.text,
      'resolution_date': _resolutionDateController.text,
      'action_taken': _actionTakenController.text,
      'followup_required': _followupRequired,
      'followup_date': _followupDateController.text,
      'escalation_level': _escalationLevelController.text,
      'action_taken_by': _actionTakenByController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(shieldPoshComplaintRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(shieldPoshComplaintRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(shieldPoshComplaintListProvider);
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
               TextFormField(controller: _complaintIdController, decoration: const InputDecoration(labelText: 'ComplaintId')),
               const SizedBox(height: 16),
               TextFormField(controller: _complaintTypeController, decoration: const InputDecoration(labelText: 'ComplaintType')),
               const SizedBox(height: 16),
               TextFormField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Description')),
               const SizedBox(height: 16),
               TextFormField(controller: _complaintDateController, decoration: const InputDecoration(labelText: 'ComplaintDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _complainantIdController, decoration: const InputDecoration(labelText: 'ComplainantId')),
               const SizedBox(height: 16),
               TextFormField(controller: _complainantNameController, decoration: const InputDecoration(labelText: 'ComplainantName')),
               const SizedBox(height: 16),
               TextFormField(controller: _respondentIdController, decoration: const InputDecoration(labelText: 'RespondentId')),
               const SizedBox(height: 16),
               TextFormField(controller: _respondentNameController, decoration: const InputDecoration(labelText: 'RespondentName')),
               const SizedBox(height: 16),
               TextFormField(controller: _locationGeoController, decoration: const InputDecoration(labelText: 'LocationGeo')),
               const SizedBox(height: 16),
               TextFormField(controller: _supportingFileIdController, decoration: const InputDecoration(labelText: 'SupportingFileId')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('ConfidentialityRequested'), value: _confidentialityRequested, onChanged: (v) => setState(() => _confidentialityRequested = v)),
               TextFormField(controller: _statusController, decoration: const InputDecoration(labelText: 'Status')),
               const SizedBox(height: 16),
               TextFormField(controller: _assignedToController, decoration: const InputDecoration(labelText: 'AssignedTo')),
               const SizedBox(height: 16),
               TextFormField(controller: _assignedCommitteeIdController, decoration: const InputDecoration(labelText: 'AssignedCommitteeId')),
               const SizedBox(height: 16),
               TextFormField(controller: _investigationStartController, decoration: const InputDecoration(labelText: 'InvestigationStart')),
               const SizedBox(height: 16),
               TextFormField(controller: _investigationEndController, decoration: const InputDecoration(labelText: 'InvestigationEnd')),
               const SizedBox(height: 16),
               TextFormField(controller: _resolutionDescriptionController, decoration: const InputDecoration(labelText: 'ResolutionDescription')),
               const SizedBox(height: 16),
               TextFormField(controller: _resolutionDateController, decoration: const InputDecoration(labelText: 'ResolutionDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _actionTakenController, decoration: const InputDecoration(labelText: 'ActionTaken')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('FollowupRequired'), value: _followupRequired, onChanged: (v) => setState(() => _followupRequired = v)),
               TextFormField(controller: _followupDateController, decoration: const InputDecoration(labelText: 'FollowupDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _escalationLevelController, decoration: const InputDecoration(labelText: 'EscalationLevel')),
               const SizedBox(height: 16),
               TextFormField(controller: _actionTakenByController, decoration: const InputDecoration(labelText: 'ActionTakenBy')),
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
