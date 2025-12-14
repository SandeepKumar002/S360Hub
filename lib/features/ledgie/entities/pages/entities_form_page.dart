import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/entities_repository.dart';

class LedgieEntitieFormPage extends ConsumerStatefulWidget {
  final String? id;
  const LedgieEntitieFormPage({super.key, this.id});

  @override
  ConsumerState<LedgieEntitieFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<LedgieEntitieFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _entityCodeController = TextEditingController();
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _primaryContactIdController = TextEditingController();
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _districtController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _gstDefaultIdController = TextEditingController();
  final _panController = TextEditingController();
  final _websiteController = TextEditingController();
  final _deletedByController = TextEditingController();
  final _deleteTypeController = TextEditingController();
  bool _isDeleted = false;
  final _entityStatusController = TextEditingController();
  final _leadSourceController = TextEditingController();
  final _leadTemperatureController = TextEditingController();
  final _leadPriorityController = TextEditingController();
  final _assignedToController = TextEditingController();
  final _firstContactDateController = TextEditingController();
  final _lastContactDateController = TextEditingController();
  final _nextFollowUpDateController = TextEditingController();
  final _estimatedValueController = TextEditingController();
  final _expectedCloseDateController = TextEditingController();
  final _convertedDateController = TextEditingController();
  final _interactionCountController = TextEditingController();
  final _notesController = TextEditingController();

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
      'entity_code': _entityCodeController.text,
      'name': _nameController.text,
      'type': _typeController.text,
      'primary_contact_id': _primaryContactIdController.text,
      'country': _countryController.text,
      'state': _stateController.text,
      'district': _districtController.text,
      'pincode': _pincodeController.text,
      'gst_default_id': _gstDefaultIdController.text,
      'pan': _panController.text,
      'website': _websiteController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
      'entity_status': _entityStatusController.text,
      'lead_source': _leadSourceController.text,
      'lead_temperature': _leadTemperatureController.text,
      'lead_priority': _leadPriorityController.text,
      'assigned_to': _assignedToController.text,
      'first_contact_date': _firstContactDateController.text,
      'last_contact_date': _lastContactDateController.text,
      'next_follow_up_date': _nextFollowUpDateController.text,
      'estimated_value': double.tryParse(_estimatedValueController.text),
      'expected_close_date': _expectedCloseDateController.text,
      'converted_date': _convertedDateController.text,
      'interaction_count': int.tryParse(_interactionCountController.text),
      'notes': _notesController.text,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(ledgieEntitieRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(ledgieEntitieRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(ledgieEntitieListProvider);
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
               TextFormField(controller: _entityCodeController, decoration: const InputDecoration(labelText: 'EntityCode')),
               const SizedBox(height: 16),
               TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
               const SizedBox(height: 16),
               TextFormField(controller: _typeController, decoration: const InputDecoration(labelText: 'Type')),
               const SizedBox(height: 16),
               TextFormField(controller: _primaryContactIdController, decoration: const InputDecoration(labelText: 'PrimaryContactId')),
               const SizedBox(height: 16),
               TextFormField(controller: _countryController, decoration: const InputDecoration(labelText: 'Country')),
               const SizedBox(height: 16),
               TextFormField(controller: _stateController, decoration: const InputDecoration(labelText: 'State')),
               const SizedBox(height: 16),
               TextFormField(controller: _districtController, decoration: const InputDecoration(labelText: 'District')),
               const SizedBox(height: 16),
               TextFormField(controller: _pincodeController, decoration: const InputDecoration(labelText: 'Pincode')),
               const SizedBox(height: 16),
               TextFormField(controller: _gstDefaultIdController, decoration: const InputDecoration(labelText: 'GstDefaultId')),
               const SizedBox(height: 16),
               TextFormField(controller: _panController, decoration: const InputDecoration(labelText: 'Pan')),
               const SizedBox(height: 16),
               TextFormField(controller: _websiteController, decoration: const InputDecoration(labelText: 'Website')),
               const SizedBox(height: 16),
               TextFormField(controller: _deletedByController, decoration: const InputDecoration(labelText: 'DeletedBy')),
               const SizedBox(height: 16),
               TextFormField(controller: _deleteTypeController, decoration: const InputDecoration(labelText: 'DeleteType')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('IsDeleted'), value: _isDeleted, onChanged: (v) => setState(() => _isDeleted = v)),
               TextFormField(controller: _entityStatusController, decoration: const InputDecoration(labelText: 'EntityStatus')),
               const SizedBox(height: 16),
               TextFormField(controller: _leadSourceController, decoration: const InputDecoration(labelText: 'LeadSource')),
               const SizedBox(height: 16),
               TextFormField(controller: _leadTemperatureController, decoration: const InputDecoration(labelText: 'LeadTemperature')),
               const SizedBox(height: 16),
               TextFormField(controller: _leadPriorityController, decoration: const InputDecoration(labelText: 'LeadPriority')),
               const SizedBox(height: 16),
               TextFormField(controller: _assignedToController, decoration: const InputDecoration(labelText: 'AssignedTo')),
               const SizedBox(height: 16),
               TextFormField(controller: _firstContactDateController, decoration: const InputDecoration(labelText: 'FirstContactDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _lastContactDateController, decoration: const InputDecoration(labelText: 'LastContactDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _nextFollowUpDateController, decoration: const InputDecoration(labelText: 'NextFollowUpDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _estimatedValueController, decoration: const InputDecoration(labelText: 'EstimatedValue')),
               const SizedBox(height: 16),
               TextFormField(controller: _expectedCloseDateController, decoration: const InputDecoration(labelText: 'ExpectedCloseDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _convertedDateController, decoration: const InputDecoration(labelText: 'ConvertedDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _interactionCountController, decoration: const InputDecoration(labelText: 'InteractionCount')),
               const SizedBox(height: 16),
               TextFormField(controller: _notesController, decoration: const InputDecoration(labelText: 'Notes')),
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
