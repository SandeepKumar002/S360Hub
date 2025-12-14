import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/active_customers_repository.dart';

class LedgieActiveCustomerFormPage extends ConsumerStatefulWidget {
  final String? id;
  const LedgieActiveCustomerFormPage({super.key, this.id});

  @override
  ConsumerState<LedgieActiveCustomerFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<LedgieActiveCustomerFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _entityCodeController = TextEditingController();
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _entityStatusController = TextEditingController();
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _panController = TextEditingController();
  final _websiteController = TextEditingController();
  final _assignedToController = TextEditingController();
  final _assignedToNameController = TextEditingController();
  final _convertedDateController = TextEditingController();

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
      'entity_status': _entityStatusController.text,
      'country': _countryController.text,
      'state': _stateController.text,
      'pan': _panController.text,
      'website': _websiteController.text,
      'assigned_to': _assignedToController.text,
      'assigned_to_name': _assignedToNameController.text,
      'converted_date': _convertedDateController.text,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(ledgieActiveCustomerRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(ledgieActiveCustomerRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(ledgieActiveCustomerListProvider);
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
               TextFormField(controller: _entityStatusController, decoration: const InputDecoration(labelText: 'EntityStatus')),
               const SizedBox(height: 16),
               TextFormField(controller: _countryController, decoration: const InputDecoration(labelText: 'Country')),
               const SizedBox(height: 16),
               TextFormField(controller: _stateController, decoration: const InputDecoration(labelText: 'State')),
               const SizedBox(height: 16),
               TextFormField(controller: _panController, decoration: const InputDecoration(labelText: 'Pan')),
               const SizedBox(height: 16),
               TextFormField(controller: _websiteController, decoration: const InputDecoration(labelText: 'Website')),
               const SizedBox(height: 16),
               TextFormField(controller: _assignedToController, decoration: const InputDecoration(labelText: 'AssignedTo')),
               const SizedBox(height: 16),
               TextFormField(controller: _assignedToNameController, decoration: const InputDecoration(labelText: 'AssignedToName')),
               const SizedBox(height: 16),
               TextFormField(controller: _convertedDateController, decoration: const InputDecoration(labelText: 'ConvertedDate')),
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
