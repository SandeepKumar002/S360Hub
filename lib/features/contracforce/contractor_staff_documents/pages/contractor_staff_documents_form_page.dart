import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/contractor_staff_documents_repository.dart';

class ContracforceContractorStaffDocumentFormPage extends ConsumerStatefulWidget {
  final String? id;
  const ContracforceContractorStaffDocumentFormPage({super.key, this.id});

  @override
  ConsumerState<ContracforceContractorStaffDocumentFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<ContracforceContractorStaffDocumentFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _contractorStaffIdController = TextEditingController();
  final _documentTypeController = TextEditingController();
  final _documentFileIdController = TextEditingController();
  bool _verified = false;
  final _verifiedByController = TextEditingController();
  final _verifiedDateController = TextEditingController();
  final _expiryDateController = TextEditingController();

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
      'contractor_staff_id': _contractorStaffIdController.text,
      'document_type': _documentTypeController.text,
      'document_file_id': _documentFileIdController.text,
      'verified': _verified,
      'verified_by': _verifiedByController.text,
      'verified_date': _verifiedDateController.text,
      'expiry_date': _expiryDateController.text,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(contracforceContractorStaffDocumentRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(contracforceContractorStaffDocumentRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(contracforceContractorStaffDocumentListProvider);
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
               TextFormField(controller: _contractorStaffIdController, decoration: const InputDecoration(labelText: 'ContractorStaffId')),
               const SizedBox(height: 16),
               TextFormField(controller: _documentTypeController, decoration: const InputDecoration(labelText: 'DocumentType')),
               const SizedBox(height: 16),
               TextFormField(controller: _documentFileIdController, decoration: const InputDecoration(labelText: 'DocumentFileId')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('Verified'), value: _verified, onChanged: (v) => setState(() => _verified = v)),
               TextFormField(controller: _verifiedByController, decoration: const InputDecoration(labelText: 'VerifiedBy')),
               const SizedBox(height: 16),
               TextFormField(controller: _verifiedDateController, decoration: const InputDecoration(labelText: 'VerifiedDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _expiryDateController, decoration: const InputDecoration(labelText: 'ExpiryDate')),
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
