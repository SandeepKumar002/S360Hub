import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/channel_members_repository.dart';

class CommChannelMemberFormPage extends ConsumerStatefulWidget {
  final String? id;
  const CommChannelMemberFormPage({super.key, this.id});

  @override
  ConsumerState<CommChannelMemberFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<CommChannelMemberFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _channelIdController = TextEditingController();
  final _personIdController = TextEditingController();
  final _joinedAtController = TextEditingController();
  final _roleController = TextEditingController();
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
      'channel_id': _channelIdController.text,
      'person_id': _personIdController.text,
      'joined_at': _joinedAtController.text,
      'role': _roleController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(commChannelMemberRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(commChannelMemberRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(commChannelMemberListProvider);
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
               TextFormField(controller: _channelIdController, decoration: const InputDecoration(labelText: 'ChannelId')),
               const SizedBox(height: 16),
               TextFormField(controller: _personIdController, decoration: const InputDecoration(labelText: 'PersonId')),
               const SizedBox(height: 16),
               TextFormField(controller: _joinedAtController, decoration: const InputDecoration(labelText: 'JoinedAt')),
               const SizedBox(height: 16),
               TextFormField(controller: _roleController, decoration: const InputDecoration(labelText: 'Role')),
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
