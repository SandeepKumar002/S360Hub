import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/hsn_sac_codes_repository.dart';

class TaxforgeHsnSacCodeFormPage extends ConsumerStatefulWidget {
  final String? id;
  const TaxforgeHsnSacCodeFormPage({super.key, this.id});

  @override
  ConsumerState<TaxforgeHsnSacCodeFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<TaxforgeHsnSacCodeFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _codeController = TextEditingController();
  final _typeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _defaultGstRateController = TextEditingController();
  final _defaultGstTypeController = TextEditingController();
  final _unitOfMeasureController = TextEditingController();
  bool _isExempt = false;
  bool _itcEligible = false;
  final _accountingCodeController = TextEditingController();
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
      'code': _codeController.text,
      'type': _typeController.text,
      'description': _descriptionController.text,
      'default_gst_rate': double.tryParse(_defaultGstRateController.text),
      'default_gst_type': _defaultGstTypeController.text,
      'unit_of_measure': _unitOfMeasureController.text,
      'is_exempt': _isExempt,
      'itc_eligible': _itcEligible,
      'accounting_code': _accountingCodeController.text,
      'effective_from': _effectiveFromController.text,
      'effective_to': _effectiveToController.text,
      'is_active': _isActive,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(taxforgeHsnSacCodeRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(taxforgeHsnSacCodeRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(taxforgeHsnSacCodeListProvider);
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
               TextFormField(controller: _codeController, decoration: const InputDecoration(labelText: 'Code')),
               const SizedBox(height: 16),
               TextFormField(controller: _typeController, decoration: const InputDecoration(labelText: 'Type')),
               const SizedBox(height: 16),
               TextFormField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Description')),
               const SizedBox(height: 16),
               TextFormField(controller: _defaultGstRateController, decoration: const InputDecoration(labelText: 'DefaultGstRate')),
               const SizedBox(height: 16),
               TextFormField(controller: _defaultGstTypeController, decoration: const InputDecoration(labelText: 'DefaultGstType')),
               const SizedBox(height: 16),
               TextFormField(controller: _unitOfMeasureController, decoration: const InputDecoration(labelText: 'UnitOfMeasure')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('IsExempt'), value: _isExempt, onChanged: (v) => setState(() => _isExempt = v)),
               SwitchListTile(title: const Text('ItcEligible'), value: _itcEligible, onChanged: (v) => setState(() => _itcEligible = v)),
               TextFormField(controller: _accountingCodeController, decoration: const InputDecoration(labelText: 'AccountingCode')),
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
