import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/hot_prospects_repository.dart';

class LedgieHotProspectFormPage extends ConsumerStatefulWidget {
  final String? id;
  const LedgieHotProspectFormPage({super.key, this.id});

  @override
  ConsumerState<LedgieHotProspectFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<LedgieHotProspectFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _companyNameController = TextEditingController();
  final _entityStatusController = TextEditingController();
  final _leadPriorityController = TextEditingController();
  final _estimatedValueController = TextEditingController();
  final _nextFollowUpDateController = TextEditingController();
  final _lastContactDateController = TextEditingController();
  final _assignedToController = TextEditingController();
  final _assignedToNameController = TextEditingController();
  final _urgencyController = TextEditingController();

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
      'company_name': _companyNameController.text,
      'entity_status': _entityStatusController.text,
      'lead_priority': _leadPriorityController.text,
      'estimated_value': double.tryParse(_estimatedValueController.text),
      'next_follow_up_date': _nextFollowUpDateController.text,
      'last_contact_date': _lastContactDateController.text,
      'assigned_to': _assignedToController.text,
      'assigned_to_name': _assignedToNameController.text,
      'urgency': _urgencyController.text,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(ledgieHotProspectRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(ledgieHotProspectRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(ledgieHotProspectListProvider);
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
               TextFormField(controller: _companyNameController, decoration: const InputDecoration(labelText: 'CompanyName')),
               const SizedBox(height: 16),
               TextFormField(controller: _entityStatusController, decoration: const InputDecoration(labelText: 'EntityStatus')),
               const SizedBox(height: 16),
               TextFormField(controller: _leadPriorityController, decoration: const InputDecoration(labelText: 'LeadPriority')),
               const SizedBox(height: 16),
               TextFormField(controller: _estimatedValueController, decoration: const InputDecoration(labelText: 'EstimatedValue')),
               const SizedBox(height: 16),
               TextFormField(controller: _nextFollowUpDateController, decoration: const InputDecoration(labelText: 'NextFollowUpDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _lastContactDateController, decoration: const InputDecoration(labelText: 'LastContactDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _assignedToController, decoration: const InputDecoration(labelText: 'AssignedTo')),
               const SizedBox(height: 16),
               TextFormField(controller: _assignedToNameController, decoration: const InputDecoration(labelText: 'AssignedToName')),
               const SizedBox(height: 16),
               TextFormField(controller: _urgencyController, decoration: const InputDecoration(labelText: 'Urgency')),
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
