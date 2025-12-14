import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/bank_accounts_repository.dart';

class FinacBankAccountFormPage extends ConsumerStatefulWidget {
  final String? id;
  const FinacBankAccountFormPage({super.key, this.id});

  @override
  ConsumerState<FinacBankAccountFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<FinacBankAccountFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _partyTypeController = TextEditingController();
  final _partyIdController = TextEditingController();
  final _accountHolderNameController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _branchNameController = TextEditingController();
  final _accountNumberMaskedController = TextEditingController();
  final _accountNumberEncryptedController = TextEditingController();
  final _ifscCodeController = TextEditingController();
  final _swiftCodeController = TextEditingController();
  final _accountTypeController = TextEditingController();
  final _currencyController = TextEditingController();
  final _openingBalanceController = TextEditingController();
  final _currentBalanceController = TextEditingController();
  bool _isDefault = false;
  bool _verified = false;
  final _kycDocumentsController = TextEditingController();
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
      'account_holder_name': _accountHolderNameController.text,
      'bank_name': _bankNameController.text,
      'branch_name': _branchNameController.text,
      'account_number_masked': _accountNumberMaskedController.text,
      'account_number_encrypted': _accountNumberEncryptedController.text,
      'ifsc_code': _ifscCodeController.text,
      'swift_code': _swiftCodeController.text,
      'account_type': _accountTypeController.text,
      'currency': _currencyController.text,
      'opening_balance': double.tryParse(_openingBalanceController.text),
      'current_balance': double.tryParse(_currentBalanceController.text),
      'is_default': _isDefault,
      'verified': _verified,
      'kyc_documents': _kycDocumentsController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(finacBankAccountRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(finacBankAccountRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(finacBankAccountListProvider);
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
               TextFormField(controller: _accountHolderNameController, decoration: const InputDecoration(labelText: 'AccountHolderName')),
               const SizedBox(height: 16),
               TextFormField(controller: _bankNameController, decoration: const InputDecoration(labelText: 'BankName')),
               const SizedBox(height: 16),
               TextFormField(controller: _branchNameController, decoration: const InputDecoration(labelText: 'BranchName')),
               const SizedBox(height: 16),
               TextFormField(controller: _accountNumberMaskedController, decoration: const InputDecoration(labelText: 'AccountNumberMasked')),
               const SizedBox(height: 16),
               TextFormField(controller: _accountNumberEncryptedController, decoration: const InputDecoration(labelText: 'AccountNumberEncrypted')),
               const SizedBox(height: 16),
               TextFormField(controller: _ifscCodeController, decoration: const InputDecoration(labelText: 'IfscCode')),
               const SizedBox(height: 16),
               TextFormField(controller: _swiftCodeController, decoration: const InputDecoration(labelText: 'SwiftCode')),
               const SizedBox(height: 16),
               TextFormField(controller: _accountTypeController, decoration: const InputDecoration(labelText: 'AccountType')),
               const SizedBox(height: 16),
               TextFormField(controller: _currencyController, decoration: const InputDecoration(labelText: 'Currency')),
               const SizedBox(height: 16),
               TextFormField(controller: _openingBalanceController, decoration: const InputDecoration(labelText: 'OpeningBalance')),
               const SizedBox(height: 16),
               TextFormField(controller: _currentBalanceController, decoration: const InputDecoration(labelText: 'CurrentBalance')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('IsDefault'), value: _isDefault, onChanged: (v) => setState(() => _isDefault = v)),
               SwitchListTile(title: const Text('Verified'), value: _verified, onChanged: (v) => setState(() => _verified = v)),
               TextFormField(controller: _kycDocumentsController, decoration: const InputDecoration(labelText: 'KycDocuments')),
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
