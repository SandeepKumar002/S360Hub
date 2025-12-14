import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/tds_details_repository.dart';

class TaxforgeTdsDetailFormPage extends ConsumerStatefulWidget {
  final String? id;
  const TaxforgeTdsDetailFormPage({super.key, this.id});

  @override
  ConsumerState<TaxforgeTdsDetailFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<TaxforgeTdsDetailFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _partyTypeController = TextEditingController();
  final _partyIdController = TextEditingController();
  final _sectionCodeController = TextEditingController();
  final _tdsRatePercentController = TextEditingController();
  final _thresholdAmountController = TextEditingController();
  final _panController = TextEditingController();
  bool _panValidated = false;
  final _exemptionCertificateController = TextEditingController();
  final _effectiveFromController = TextEditingController();
  final _effectiveToController = TextEditingController();
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
      'party_type': _partyTypeController.text,
      'party_id': _partyIdController.text,
      'section_code': _sectionCodeController.text,
      'tds_rate_percent': double.tryParse(_tdsRatePercentController.text),
      'threshold_amount': double.tryParse(_thresholdAmountController.text),
      'pan': _panController.text,
      'pan_validated': _panValidated,
      'exemption_certificate': _exemptionCertificateController.text,
      'effective_from': _effectiveFromController.text,
      'effective_to': _effectiveToController.text,
      'is_active': _isActive,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(taxforgeTdsDetailRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(taxforgeTdsDetailRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(taxforgeTdsDetailListProvider);
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
               TextFormField(controller: _sectionCodeController, decoration: const InputDecoration(labelText: 'SectionCode')),
               const SizedBox(height: 16),
               TextFormField(controller: _tdsRatePercentController, decoration: const InputDecoration(labelText: 'TdsRatePercent')),
               const SizedBox(height: 16),
               TextFormField(controller: _thresholdAmountController, decoration: const InputDecoration(labelText: 'ThresholdAmount')),
               const SizedBox(height: 16),
               TextFormField(controller: _panController, decoration: const InputDecoration(labelText: 'Pan')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('PanValidated'), value: _panValidated, onChanged: (v) => setState(() => _panValidated = v)),
               TextFormField(controller: _exemptionCertificateController, decoration: const InputDecoration(labelText: 'ExemptionCertificate')),
               const SizedBox(height: 16),
               TextFormField(controller: _effectiveFromController, decoration: const InputDecoration(labelText: 'EffectiveFrom')),
               const SizedBox(height: 16),
               TextFormField(controller: _effectiveToController, decoration: const InputDecoration(labelText: 'EffectiveTo')),
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
