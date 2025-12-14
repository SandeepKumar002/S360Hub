import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/committee_meetings_repository.dart';

class CommitteeCommitteeMeetingFormPage extends ConsumerStatefulWidget {
  final String? id;
  const CommitteeCommitteeMeetingFormPage({super.key, this.id});

  @override
  ConsumerState<CommitteeCommitteeMeetingFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<CommitteeCommitteeMeetingFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _committeeIdController = TextEditingController();
  final _meetingNumberController = TextEditingController();
  final _meetingDateController = TextEditingController();
  final _meetingTimeController = TextEditingController();
  final _locationController = TextEditingController();
  final _agendaController = TextEditingController();
  final _statusController = TextEditingController();
  final _attendeesController = TextEditingController();
  final _minutesFileIdController = TextEditingController();
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
      'committee_id': _committeeIdController.text,
      'meeting_number': _meetingNumberController.text,
      'meeting_date': _meetingDateController.text,
      'meeting_time': _meetingTimeController.text,
      'location': _locationController.text,
      'agenda': _agendaController.text,
      'status': _statusController.text,
      'attendees': _attendeesController.text,
      'minutes_file_id': _minutesFileIdController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(committeeCommitteeMeetingRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(committeeCommitteeMeetingRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(committeeCommitteeMeetingListProvider);
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
               TextFormField(controller: _committeeIdController, decoration: const InputDecoration(labelText: 'CommitteeId')),
               const SizedBox(height: 16),
               TextFormField(controller: _meetingNumberController, decoration: const InputDecoration(labelText: 'MeetingNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _meetingDateController, decoration: const InputDecoration(labelText: 'MeetingDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _meetingTimeController, decoration: const InputDecoration(labelText: 'MeetingTime')),
               const SizedBox(height: 16),
               TextFormField(controller: _locationController, decoration: const InputDecoration(labelText: 'Location')),
               const SizedBox(height: 16),
               TextFormField(controller: _agendaController, decoration: const InputDecoration(labelText: 'Agenda')),
               const SizedBox(height: 16),
               TextFormField(controller: _statusController, decoration: const InputDecoration(labelText: 'Status')),
               const SizedBox(height: 16),
               TextFormField(controller: _attendeesController, decoration: const InputDecoration(labelText: 'Attendees')),
               const SizedBox(height: 16),
               TextFormField(controller: _minutesFileIdController, decoration: const InputDecoration(labelText: 'MinutesFileId')),
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
