import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/safety_incidents_repository.dart';

class ShieldSafetyIncidentFormPage extends ConsumerStatefulWidget {
  final String? id;
  const ShieldSafetyIncidentFormPage({super.key, this.id});

  @override
  ConsumerState<ShieldSafetyIncidentFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<ShieldSafetyIncidentFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _incidentIdController = TextEditingController();
  final _incidentDateController = TextEditingController();
  final _locationController = TextEditingController();
  final _locationGpsController = TextEditingController();
  final _severityController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _injuriesReported = false;
  final _injuredPersonsController = TextEditingController();
  final _immediateActionTakenController = TextEditingController();
  bool _investigationRequired = false;
  final _investigationFileIdController = TextEditingController();
  final _preventiveMeasuresController = TextEditingController();
  final _statusController = TextEditingController();
  final _reportedByController = TextEditingController();
  final _assignedToController = TextEditingController();
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
      'incident_id': _incidentIdController.text,
      'incident_date': _incidentDateController.text,
      'location': _locationController.text,
      'location_gps': _locationGpsController.text,
      'severity': _severityController.text,
      'description': _descriptionController.text,
      'injuries_reported': _injuriesReported,
      'injured_persons': _injuredPersonsController.text,
      'immediate_action_taken': _immediateActionTakenController.text,
      'investigation_required': _investigationRequired,
      'investigation_file_id': _investigationFileIdController.text,
      'preventive_measures': _preventiveMeasuresController.text,
      'status': _statusController.text,
      'reported_by': _reportedByController.text,
      'assigned_to': _assignedToController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(shieldSafetyIncidentRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(shieldSafetyIncidentRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(shieldSafetyIncidentListProvider);
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
               TextFormField(controller: _incidentIdController, decoration: const InputDecoration(labelText: 'IncidentId')),
               const SizedBox(height: 16),
               TextFormField(controller: _incidentDateController, decoration: const InputDecoration(labelText: 'IncidentDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _locationController, decoration: const InputDecoration(labelText: 'Location')),
               const SizedBox(height: 16),
               TextFormField(controller: _locationGpsController, decoration: const InputDecoration(labelText: 'LocationGps')),
               const SizedBox(height: 16),
               TextFormField(controller: _severityController, decoration: const InputDecoration(labelText: 'Severity')),
               const SizedBox(height: 16),
               TextFormField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Description')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('InjuriesReported'), value: _injuriesReported, onChanged: (v) => setState(() => _injuriesReported = v)),
               TextFormField(controller: _injuredPersonsController, decoration: const InputDecoration(labelText: 'InjuredPersons')),
               const SizedBox(height: 16),
               TextFormField(controller: _immediateActionTakenController, decoration: const InputDecoration(labelText: 'ImmediateActionTaken')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('InvestigationRequired'), value: _investigationRequired, onChanged: (v) => setState(() => _investigationRequired = v)),
               TextFormField(controller: _investigationFileIdController, decoration: const InputDecoration(labelText: 'InvestigationFileId')),
               const SizedBox(height: 16),
               TextFormField(controller: _preventiveMeasuresController, decoration: const InputDecoration(labelText: 'PreventiveMeasures')),
               const SizedBox(height: 16),
               TextFormField(controller: _statusController, decoration: const InputDecoration(labelText: 'Status')),
               const SizedBox(height: 16),
               TextFormField(controller: _reportedByController, decoration: const InputDecoration(labelText: 'ReportedBy')),
               const SizedBox(height: 16),
               TextFormField(controller: _assignedToController, decoration: const InputDecoration(labelText: 'AssignedTo')),
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
