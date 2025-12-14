import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/committee_meeting_records_repository.dart';

class CommitteeCommitteeMeetingRecordFormPage extends ConsumerStatefulWidget {
  final String? id;
  const CommitteeCommitteeMeetingRecordFormPage({super.key, this.id});

  @override
  ConsumerState<CommitteeCommitteeMeetingRecordFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<CommitteeCommitteeMeetingRecordFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _meetingIdController = TextEditingController();
  final _agendaItemController = TextEditingController();
  final _discussionController = TextEditingController();
  final _decisionController = TextEditingController();
  final _actionItemsController = TextEditingController();
  final _responsiblePersonIdController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _statusController = TextEditingController();

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
      'meeting_id': _meetingIdController.text,
      'agenda_item': _agendaItemController.text,
      'discussion': _discussionController.text,
      'decision': _decisionController.text,
      'action_items': _actionItemsController.text,
      'responsible_person_id': _responsiblePersonIdController.text,
      'due_date': _dueDateController.text,
      'status': _statusController.text,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(committeeCommitteeMeetingRecordRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(committeeCommitteeMeetingRecordRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(committeeCommitteeMeetingRecordListProvider);
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
               TextFormField(controller: _meetingIdController, decoration: const InputDecoration(labelText: 'MeetingId')),
               const SizedBox(height: 16),
               TextFormField(controller: _agendaItemController, decoration: const InputDecoration(labelText: 'AgendaItem')),
               const SizedBox(height: 16),
               TextFormField(controller: _discussionController, decoration: const InputDecoration(labelText: 'Discussion')),
               const SizedBox(height: 16),
               TextFormField(controller: _decisionController, decoration: const InputDecoration(labelText: 'Decision')),
               const SizedBox(height: 16),
               TextFormField(controller: _actionItemsController, decoration: const InputDecoration(labelText: 'ActionItems')),
               const SizedBox(height: 16),
               TextFormField(controller: _responsiblePersonIdController, decoration: const InputDecoration(labelText: 'ResponsiblePersonId')),
               const SizedBox(height: 16),
               TextFormField(controller: _dueDateController, decoration: const InputDecoration(labelText: 'DueDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _statusController, decoration: const InputDecoration(labelText: 'Status')),
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
