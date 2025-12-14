import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/lookups_repository.dart';

class LookupGroupFormPage extends ConsumerStatefulWidget {
  final String? groupId;
  const LookupGroupFormPage({super.key, this.groupId});

  @override
  ConsumerState<LookupGroupFormPage> createState() => _LookupGroupFormPageState();
}

class _LookupGroupFormPageState extends ConsumerState<LookupGroupFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  bool _isActive = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.groupId != null) {
      _loadGroup();
    }
  }

  Future<void> _loadGroup() async {
     setState(() => _isLoading = true);
     try {
       final group = await ref.read(lookupsRepositoryProvider).getGroupById(widget.groupId!);
       _codeController.text = group.code;
       _nameController.text = group.displayName;
       _descController.text = group.description ?? '';
       _isActive = group.isActive;
     } catch(e) {
        if(mounted) FeedbackService.showError(context, 'Failed to load group');
     } finally {
        if(mounted) setState(() => _isLoading = false);
     }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    
    final data = {
        'code': _codeController.text,
        'display_name': _nameController.text,
        'description': _descController.text.isEmpty ? null : _descController.text,
        'is_active': _isActive,
    };

    try {
        if (widget.groupId != null) {
             await ref.read(lookupsRepositoryProvider).updateGroup(widget.groupId!, data);
             if(mounted) FeedbackService.showSuccess(context, 'Group Updated');
        } else {
             await ref.read(lookupsRepositoryProvider).createGroup(data);
             if(mounted) FeedbackService.showSuccess(context, 'Group Created');
        }
        if (mounted) {
             ref.invalidate(lookupGroupsListProvider);
             if (widget.groupId != null) ref.invalidate(lookupGroupDetailProvider(widget.groupId!));
             context.pop();
        }
    } catch(e) {
        if(mounted) FeedbackService.showError(context, e.toString());
    } finally {
        if(mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.groupId != null ? 'Edit Group' : 'New Group')),
      body: _isLoading && widget.groupId != null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                      children: [
                          TextFormField(
                              controller: _codeController,
                              decoration: const InputDecoration(labelText: 'Code (Unique)'),
                              validator: (v) => v!.isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(labelText: 'Display Name'),
                              validator: (v) => v!.isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                              controller: _descController,
                              decoration: const InputDecoration(labelText: 'Description'),
                              maxLines: 2,
                          ),
                           const SizedBox(height: 16),
                           CheckboxListTile(
                               title: const Text('Is Active'),
                               value: _isActive,
                               onChanged: (v) => setState(() => _isActive = v ?? true),
                           ),
                           const SizedBox(height: 32),
                           ElevatedButton(
                            onPressed: _isLoading ? null : _save,
                            child: _isLoading ? const CircularProgressIndicator() : const Text('Save'),
                           ),
                      ],
                  ),
              ),
          ),
    );
  }
}
