import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/log_history_repository.dart';

class TaxforgeLogHistoryFormPage extends ConsumerStatefulWidget {
  final String? id;
  const TaxforgeLogHistoryFormPage({super.key, this.id});

  @override
  ConsumerState<TaxforgeLogHistoryFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<TaxforgeLogHistoryFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _schemaNameController = TextEditingController();
  final _tableNameController = TextEditingController();
  final _recordIdController = TextEditingController();
  final _operationController = TextEditingController();
  final _changedByController = TextEditingController();
  final _changedByIdController = TextEditingController();
  final _changedAtController = TextEditingController();
  final _oldDataController = TextEditingController();
  final _newDataController = TextEditingController();
  final _commentController = TextEditingController();
  final _changedFieldsController = TextEditingController();
  final _ipAddressController = TextEditingController();
  final _userAgentController = TextEditingController();
  final _sessionIdController = TextEditingController();
  final _requestIdController = TextEditingController();

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
      'schema_name': _schemaNameController.text,
      'table_name': _tableNameController.text,
      'record_id': _recordIdController.text,
      'operation': _operationController.text,
      'changed_by': _changedByController.text,
      'changed_by_id': _changedByIdController.text,
      'changed_at': _changedAtController.text,
      'old_data': _oldDataController.text,
      'new_data': _newDataController.text,
      'comment': _commentController.text,
      'changed_fields': _changedFieldsController.text,
      'ip_address': _ipAddressController.text,
      'user_agent': _userAgentController.text,
      'session_id': _sessionIdController.text,
      'request_id': _requestIdController.text,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(taxforgeLogHistoryRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(taxforgeLogHistoryRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(taxforgeLogHistoryListProvider);
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
               TextFormField(controller: _schemaNameController, decoration: const InputDecoration(labelText: 'SchemaName')),
               const SizedBox(height: 16),
               TextFormField(controller: _tableNameController, decoration: const InputDecoration(labelText: 'TableName')),
               const SizedBox(height: 16),
               TextFormField(controller: _recordIdController, decoration: const InputDecoration(labelText: 'RecordId')),
               const SizedBox(height: 16),
               TextFormField(controller: _operationController, decoration: const InputDecoration(labelText: 'Operation')),
               const SizedBox(height: 16),
               TextFormField(controller: _changedByController, decoration: const InputDecoration(labelText: 'ChangedBy')),
               const SizedBox(height: 16),
               TextFormField(controller: _changedByIdController, decoration: const InputDecoration(labelText: 'ChangedById')),
               const SizedBox(height: 16),
               TextFormField(controller: _changedAtController, decoration: const InputDecoration(labelText: 'ChangedAt')),
               const SizedBox(height: 16),
               TextFormField(controller: _oldDataController, decoration: const InputDecoration(labelText: 'OldData')),
               const SizedBox(height: 16),
               TextFormField(controller: _newDataController, decoration: const InputDecoration(labelText: 'NewData')),
               const SizedBox(height: 16),
               TextFormField(controller: _commentController, decoration: const InputDecoration(labelText: 'Comment')),
               const SizedBox(height: 16),
               TextFormField(controller: _changedFieldsController, decoration: const InputDecoration(labelText: 'ChangedFields')),
               const SizedBox(height: 16),
               TextFormField(controller: _ipAddressController, decoration: const InputDecoration(labelText: 'IpAddress')),
               const SizedBox(height: 16),
               TextFormField(controller: _userAgentController, decoration: const InputDecoration(labelText: 'UserAgent')),
               const SizedBox(height: 16),
               TextFormField(controller: _sessionIdController, decoration: const InputDecoration(labelText: 'SessionId')),
               const SizedBox(height: 16),
               TextFormField(controller: _requestIdController, decoration: const InputDecoration(labelText: 'RequestId')),
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
