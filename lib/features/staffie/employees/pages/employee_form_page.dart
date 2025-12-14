import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/employees_repository.dart';

class EmployeeFormPage extends ConsumerStatefulWidget {
  final String? empId;
  const EmployeeFormPage({super.key, this.empId});

  @override
  ConsumerState<EmployeeFormPage> createState() => _EmployeeFormPageState();
}

class _EmployeeFormPageState extends ConsumerState<EmployeeFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _deptController = TextEditingController();
  final _desigController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  String _status = 'active';

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.empId != null) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final emp = await ref.read(employeesRepositoryProvider).getEmployeeById(widget.empId!);
      _nameController.text = emp.fullName;
      _codeController.text = emp.employeeCode;
      _deptController.text = emp.department ?? '';
      _desigController.text = emp.designation ?? '';
      _emailController.text = emp.workEmail ?? '';
      _mobileController.text = emp.mobile ?? '';
      _status = emp.status ?? 'active';
    } catch (e) {
      if(mounted) FeedbackService.showError(context, 'Failed to load');
    } finally {
      if(mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    
    final data = {
      'full_name': _nameController.text,
      'employee_code': _codeController.text,
      'department': _deptController.text.isEmpty ? null : _deptController.text,
      'designation': _desigController.text.isEmpty ? null : _desigController.text,
      'work_email': _emailController.text.isEmpty ? null : _emailController.text,
      'mobile': _mobileController.text.isEmpty ? null : _mobileController.text,
      'status': _status,
    };

    try {
      if (widget.empId != null) {
        await ref.read(employeesRepositoryProvider).updateEmployee(widget.empId!, data);
        if(mounted) FeedbackService.showSuccess(context, 'Employee Updated');
      } else {
        await ref.read(employeesRepositoryProvider).createEmployee(data);
        if(mounted) FeedbackService.showSuccess(context, 'Employee Created');
      }
      
      if (mounted) {
         ref.invalidate(employeesListProvider);
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
      appBar: AppBar(title: Text(widget.empId != null ? 'Edit Employee' : 'New Employee')),
      body: _isLoading && widget.empId != null
       ? const Center(child: CircularProgressIndicator())
       : SingleChildScrollView(
         padding: const EdgeInsets.all(16),
         child: Form(
           key: _formKey,
           child: Column(
             children: [
               TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Full Name'), validator: (v) => v!.isEmpty ? 'Required' : null),
               const SizedBox(height: 16),
               TextFormField(controller: _codeController, decoration: const InputDecoration(labelText: 'Employee Code'), validator: (v) => v!.isEmpty ? 'Required' : null),
               const SizedBox(height: 16),
               Row(children: [
                   Expanded(child: TextFormField(controller: _deptController, decoration: const InputDecoration(labelText: 'Department'))),
                   const SizedBox(width: 16),
                   Expanded(child: TextFormField(controller: _desigController, decoration: const InputDecoration(labelText: 'Designation'))),
               ]),
               const SizedBox(height: 16),
               TextFormField(controller: _emailController, decoration: const InputDecoration(labelText: 'Work Email')),
               const SizedBox(height: 16),
               TextFormField(controller: _mobileController, decoration: const InputDecoration(labelText: 'Mobile')),
               const SizedBox(height: 16),
               DropdownButtonFormField<String>(
                 value: _status,
                 decoration: const InputDecoration(labelText: 'Status'),
                 items: ['active', 'notice_period', 'terminated', 'resigned'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                 onChanged: (v) => setState(() => _status = v!),
               ),
               const SizedBox(height: 32),
               ElevatedButton(onPressed: _isLoading ? null : _save, child: Text('Save')),
             ],
           ),
         ),
       ),
    );
  }
}
