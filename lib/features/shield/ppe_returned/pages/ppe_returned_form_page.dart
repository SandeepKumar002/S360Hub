import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/ppe_returned_repository.dart';

class ShieldPpeReturnedFormPage extends ConsumerStatefulWidget {
  final String? id;
  const ShieldPpeReturnedFormPage({super.key, this.id});

  @override
  ConsumerState<ShieldPpeReturnedFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<ShieldPpeReturnedFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _ppeIssuedIdController = TextEditingController();
  final _returnDateController = TextEditingController();
  final _quantityReturnedController = TextEditingController();
  final _conditionController = TextEditingController();
  final _returnedToController = TextEditingController();
  final _remarksController = TextEditingController();

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
      'ppe_issued_id': _ppeIssuedIdController.text,
      'return_date': _returnDateController.text,
      'quantity_returned': int.tryParse(_quantityReturnedController.text),
      'condition': _conditionController.text,
      'returned_to': _returnedToController.text,
      'remarks': _remarksController.text,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(shieldPpeReturnedRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(shieldPpeReturnedRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(shieldPpeReturnedListProvider);
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
               TextFormField(controller: _ppeIssuedIdController, decoration: const InputDecoration(labelText: 'PpeIssuedId')),
               const SizedBox(height: 16),
               TextFormField(controller: _returnDateController, decoration: const InputDecoration(labelText: 'ReturnDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _quantityReturnedController, decoration: const InputDecoration(labelText: 'QuantityReturned')),
               const SizedBox(height: 16),
               TextFormField(controller: _conditionController, decoration: const InputDecoration(labelText: 'Condition')),
               const SizedBox(height: 16),
               TextFormField(controller: _returnedToController, decoration: const InputDecoration(labelText: 'ReturnedTo')),
               const SizedBox(height: 16),
               TextFormField(controller: _remarksController, decoration: const InputDecoration(labelText: 'Remarks')),
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
