import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../../../../core/widgets/common/log_history_widget.dart';
import '../repositories/employees_repository.dart';
import '../models/employee_model.dart';
import '../../../../core/services/feedback_service.dart';

class EmployeeDetailPage extends ConsumerWidget {
  final String empId;
  const EmployeeDetailPage({super.key, required this.empId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final empAsync = ref.watch(employeeDetailProvider(empId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/staffie/employees/$empId/edit'),
          ),
          IconButton(
             icon: const Icon(Icons.delete, color: Colors.red),
             onPressed: () {
                 FeedbackService.showError(context, 'Soft delete not fully implemented yet');
             },
          )
        ],
      ),
      body: AsyncValueWidget<Employee>(
        value: empAsync,
        data: (emp) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.indigo,
                    child: Text(emp.fullName.substring(0, 1), style: const TextStyle(fontSize: 32, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 16),
                Center(child: Text(emp.fullName, style: Theme.of(context).textTheme.headlineSmall)),
                Center(child: Text('${emp.designation ?? 'No Designation'} • ${emp.department ?? 'No Dept'}', style: const TextStyle(color: Colors.grey))),
                const SizedBox(height: 32),
                
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildInfoRow('Employee Code', emp.employeeCode),
                        const Divider(),
                        _buildInfoRow('Work Email', emp.workEmail ?? '-'),
                        const Divider(),
                        _buildInfoRow('Mobile', emp.mobile ?? '-'),
                        const Divider(),
                        _buildInfoRow('Joining Date', emp.joiningDate?.toString().split(' ')[0] ?? '-'),
                        const Divider(),
                        _buildInfoRow('Status', emp.status ?? '-'),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                LogHistoryWidget(tableName: 'staffie.employees', recordId: empId),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
           Text(value),
        ],
      ),
    );
  }
}
