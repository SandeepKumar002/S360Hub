import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/medical_examinations_repository.dart';

class ShieldMedicalExaminationFormPage extends ConsumerStatefulWidget {
  final String? id;
  const ShieldMedicalExaminationFormPage({super.key, this.id});

  @override
  ConsumerState<ShieldMedicalExaminationFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<ShieldMedicalExaminationFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _employeeIdController = TextEditingController();
  final _examinationTypeController = TextEditingController();
  final _examinationDateController = TextEditingController();
  final _medicalCenterController = TextEditingController();
  final _doctorNameController = TextEditingController();
  final _fitnessStatusController = TextEditingController();
  final _restrictionsController = TextEditingController();
  final _validUntilController = TextEditingController();
  final _certificateFileIdController = TextEditingController();
  final _remarksController = TextEditingController();
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
      'employee_id': _employeeIdController.text,
      'examination_type': _examinationTypeController.text,
      'examination_date': _examinationDateController.text,
      'medical_center': _medicalCenterController.text,
      'doctor_name': _doctorNameController.text,
      'fitness_status': _fitnessStatusController.text,
      'restrictions': _restrictionsController.text,
      'valid_until': _validUntilController.text,
      'certificate_file_id': _certificateFileIdController.text,
      'remarks': _remarksController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(shieldMedicalExaminationRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(shieldMedicalExaminationRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(shieldMedicalExaminationListProvider);
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
               TextFormField(controller: _employeeIdController, decoration: const InputDecoration(labelText: 'EmployeeId')),
               const SizedBox(height: 16),
               TextFormField(controller: _examinationTypeController, decoration: const InputDecoration(labelText: 'ExaminationType')),
               const SizedBox(height: 16),
               TextFormField(controller: _examinationDateController, decoration: const InputDecoration(labelText: 'ExaminationDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _medicalCenterController, decoration: const InputDecoration(labelText: 'MedicalCenter')),
               const SizedBox(height: 16),
               TextFormField(controller: _doctorNameController, decoration: const InputDecoration(labelText: 'DoctorName')),
               const SizedBox(height: 16),
               TextFormField(controller: _fitnessStatusController, decoration: const InputDecoration(labelText: 'FitnessStatus')),
               const SizedBox(height: 16),
               TextFormField(controller: _restrictionsController, decoration: const InputDecoration(labelText: 'Restrictions')),
               const SizedBox(height: 16),
               TextFormField(controller: _validUntilController, decoration: const InputDecoration(labelText: 'ValidUntil')),
               const SizedBox(height: 16),
               TextFormField(controller: _certificateFileIdController, decoration: const InputDecoration(labelText: 'CertificateFileId')),
               const SizedBox(height: 16),
               TextFormField(controller: _remarksController, decoration: const InputDecoration(labelText: 'Remarks')),
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
