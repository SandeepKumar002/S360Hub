import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/contractor_staff_repository.dart';

class ContracforceContractorStaffFormPage extends ConsumerStatefulWidget {
  final String? id;
  const ContracforceContractorStaffFormPage({super.key, this.id});

  @override
  ConsumerState<ContracforceContractorStaffFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<ContracforceContractorStaffFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _contractorIdController = TextEditingController();
  final _staffCodeController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _genderController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();
  final _staffTypeController = TextEditingController();
  final _joiningDateController = TextEditingController();
  final _leavingDateController = TextEditingController();
  final _aadhaarNumberMaskedController = TextEditingController();
  final _bankAccountNumberMaskedController = TextEditingController();
  final _ifscCodeController = TextEditingController();
  final _uanNumberController = TextEditingController();
  final _esiNumberController = TextEditingController();
  final _wagePerDayController = TextEditingController();
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
      'contractor_id': _contractorIdController.text,
      'staff_code': _staffCodeController.text,
      'full_name': _fullNameController.text,
      'father_name': _fatherNameController.text,
      'date_of_birth': _dateOfBirthController.text,
      'gender': _genderController.text,
      'mobile': _mobileController.text,
      'address': _addressController.text,
      'staff_type': _staffTypeController.text,
      'joining_date': _joiningDateController.text,
      'leaving_date': _leavingDateController.text,
      'aadhaar_number_masked': _aadhaarNumberMaskedController.text,
      'bank_account_number_masked': _bankAccountNumberMaskedController.text,
      'ifsc_code': _ifscCodeController.text,
      'uan_number': _uanNumberController.text,
      'esi_number': _esiNumberController.text,
      'wage_per_day': double.tryParse(_wagePerDayController.text),
      'status': _statusController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(contracforceContractorStaffRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(contracforceContractorStaffRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(contracforceContractorStaffListProvider);
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
               TextFormField(controller: _contractorIdController, decoration: const InputDecoration(labelText: 'ContractorId')),
               const SizedBox(height: 16),
               TextFormField(controller: _staffCodeController, decoration: const InputDecoration(labelText: 'StaffCode')),
               const SizedBox(height: 16),
               TextFormField(controller: _fullNameController, decoration: const InputDecoration(labelText: 'FullName')),
               const SizedBox(height: 16),
               TextFormField(controller: _fatherNameController, decoration: const InputDecoration(labelText: 'FatherName')),
               const SizedBox(height: 16),
               TextFormField(controller: _dateOfBirthController, decoration: const InputDecoration(labelText: 'DateOfBirth')),
               const SizedBox(height: 16),
               TextFormField(controller: _genderController, decoration: const InputDecoration(labelText: 'Gender')),
               const SizedBox(height: 16),
               TextFormField(controller: _mobileController, decoration: const InputDecoration(labelText: 'Mobile')),
               const SizedBox(height: 16),
               TextFormField(controller: _addressController, decoration: const InputDecoration(labelText: 'Address')),
               const SizedBox(height: 16),
               TextFormField(controller: _staffTypeController, decoration: const InputDecoration(labelText: 'StaffType')),
               const SizedBox(height: 16),
               TextFormField(controller: _joiningDateController, decoration: const InputDecoration(labelText: 'JoiningDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _leavingDateController, decoration: const InputDecoration(labelText: 'LeavingDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _aadhaarNumberMaskedController, decoration: const InputDecoration(labelText: 'AadhaarNumberMasked')),
               const SizedBox(height: 16),
               TextFormField(controller: _bankAccountNumberMaskedController, decoration: const InputDecoration(labelText: 'BankAccountNumberMasked')),
               const SizedBox(height: 16),
               TextFormField(controller: _ifscCodeController, decoration: const InputDecoration(labelText: 'IfscCode')),
               const SizedBox(height: 16),
               TextFormField(controller: _uanNumberController, decoration: const InputDecoration(labelText: 'UanNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _esiNumberController, decoration: const InputDecoration(labelText: 'EsiNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _wagePerDayController, decoration: const InputDecoration(labelText: 'WagePerDay')),
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
