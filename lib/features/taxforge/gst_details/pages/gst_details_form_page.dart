import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/gst_details_repository.dart';

class TaxforgeGstDetailFormPage extends ConsumerStatefulWidget {
  final String? id;
  const TaxforgeGstDetailFormPage({super.key, this.id});

  @override
  ConsumerState<TaxforgeGstDetailFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<TaxforgeGstDetailFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _partyTypeController = TextEditingController();
  final _partyIdController = TextEditingController();
  final _gstinController = TextEditingController();
  final _legalNameController = TextEditingController();
  final _tradeNameController = TextEditingController();
  final _gstStateController = TextEditingController();
  final _registrationTypeController = TextEditingController();
  bool _isDefault = false;
  final _statusController = TextEditingController();
  final _effectiveFromController = TextEditingController();
  final _effectiveToController = TextEditingController();
  final _filingFrequencyController = TextEditingController();
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
      'party_type': _partyTypeController.text,
      'party_id': _partyIdController.text,
      'gstin': _gstinController.text,
      'legal_name': _legalNameController.text,
      'trade_name': _tradeNameController.text,
      'gst_state': _gstStateController.text,
      'registration_type': _registrationTypeController.text,
      'is_default': _isDefault,
      'status': _statusController.text,
      'effective_from': _effectiveFromController.text,
      'effective_to': _effectiveToController.text,
      'filing_frequency': _filingFrequencyController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(taxforgeGstDetailRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(taxforgeGstDetailRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(taxforgeGstDetailListProvider);
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
               TextFormField(controller: _partyTypeController, decoration: const InputDecoration(labelText: 'PartyType')),
               const SizedBox(height: 16),
               TextFormField(controller: _partyIdController, decoration: const InputDecoration(labelText: 'PartyId')),
               const SizedBox(height: 16),
               TextFormField(controller: _gstinController, decoration: const InputDecoration(labelText: 'Gstin')),
               const SizedBox(height: 16),
               TextFormField(controller: _legalNameController, decoration: const InputDecoration(labelText: 'LegalName')),
               const SizedBox(height: 16),
               TextFormField(controller: _tradeNameController, decoration: const InputDecoration(labelText: 'TradeName')),
               const SizedBox(height: 16),
               TextFormField(controller: _gstStateController, decoration: const InputDecoration(labelText: 'GstState')),
               const SizedBox(height: 16),
               TextFormField(controller: _registrationTypeController, decoration: const InputDecoration(labelText: 'RegistrationType')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('IsDefault'), value: _isDefault, onChanged: (v) => setState(() => _isDefault = v)),
               TextFormField(controller: _statusController, decoration: const InputDecoration(labelText: 'Status')),
               const SizedBox(height: 16),
               TextFormField(controller: _effectiveFromController, decoration: const InputDecoration(labelText: 'EffectiveFrom')),
               const SizedBox(height: 16),
               TextFormField(controller: _effectiveToController, decoration: const InputDecoration(labelText: 'EffectiveTo')),
               const SizedBox(height: 16),
               TextFormField(controller: _filingFrequencyController, decoration: const InputDecoration(labelText: 'FilingFrequency')),
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
