import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/contractors_repository.dart';

class ContracforceContractorFormPage extends ConsumerStatefulWidget {
  final String? id;
  const ContracforceContractorFormPage({super.key, this.id});

  @override
  ConsumerState<ContracforceContractorFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<ContracforceContractorFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _entityIdController = TextEditingController();
  final _contractorCodeController = TextEditingController();
  final _contractorNameController = TextEditingController();
  final _contractorTypeController = TextEditingController();
  final _contactPersonController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _gstNumberController = TextEditingController();
  final _panNumberController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _bankAccountNumberMaskedController = TextEditingController();
  final _ifscCodeController = TextEditingController();
  final _licenseNumberController = TextEditingController();
  final _licenseExpiryDateController = TextEditingController();
  final _statusController = TextEditingController();
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
      'entity_id': _entityIdController.text,
      'contractor_code': _contractorCodeController.text,
      'contractor_name': _contractorNameController.text,
      'contractor_type': _contractorTypeController.text,
      'contact_person': _contactPersonController.text,
      'contact_number': _contactNumberController.text,
      'email': _emailController.text,
      'address': _addressController.text,
      'city': _cityController.text,
      'state': _stateController.text,
      'pincode': _pincodeController.text,
      'gst_number': _gstNumberController.text,
      'pan_number': _panNumberController.text,
      'bank_name': _bankNameController.text,
      'bank_account_number_masked': _bankAccountNumberMaskedController.text,
      'ifsc_code': _ifscCodeController.text,
      'license_number': _licenseNumberController.text,
      'license_expiry_date': _licenseExpiryDateController.text,
      'status': _statusController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(contracforceContractorRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(contracforceContractorRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(contracforceContractorListProvider);
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
               TextFormField(controller: _contractorCodeController, decoration: const InputDecoration(labelText: 'ContractorCode')),
               const SizedBox(height: 16),
               TextFormField(controller: _contractorNameController, decoration: const InputDecoration(labelText: 'ContractorName')),
               const SizedBox(height: 16),
               TextFormField(controller: _contractorTypeController, decoration: const InputDecoration(labelText: 'ContractorType')),
               const SizedBox(height: 16),
               TextFormField(controller: _contactPersonController, decoration: const InputDecoration(labelText: 'ContactPerson')),
               const SizedBox(height: 16),
               TextFormField(controller: _contactNumberController, decoration: const InputDecoration(labelText: 'ContactNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
               const SizedBox(height: 16),
               TextFormField(controller: _addressController, decoration: const InputDecoration(labelText: 'Address')),
               const SizedBox(height: 16),
               TextFormField(controller: _cityController, decoration: const InputDecoration(labelText: 'City')),
               const SizedBox(height: 16),
               TextFormField(controller: _stateController, decoration: const InputDecoration(labelText: 'State')),
               const SizedBox(height: 16),
               TextFormField(controller: _pincodeController, decoration: const InputDecoration(labelText: 'Pincode')),
               const SizedBox(height: 16),
               TextFormField(controller: _gstNumberController, decoration: const InputDecoration(labelText: 'GstNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _panNumberController, decoration: const InputDecoration(labelText: 'PanNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _bankNameController, decoration: const InputDecoration(labelText: 'BankName')),
               const SizedBox(height: 16),
               TextFormField(controller: _bankAccountNumberMaskedController, decoration: const InputDecoration(labelText: 'BankAccountNumberMasked')),
               const SizedBox(height: 16),
               TextFormField(controller: _ifscCodeController, decoration: const InputDecoration(labelText: 'IfscCode')),
               const SizedBox(height: 16),
               TextFormField(controller: _licenseNumberController, decoration: const InputDecoration(labelText: 'LicenseNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _licenseExpiryDateController, decoration: const InputDecoration(labelText: 'LicenseExpiryDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _statusController, decoration: const InputDecoration(labelText: 'Status')),
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
