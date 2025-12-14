import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/employees_repository.dart';
import '../models/employee_model.dart';

class EmployeesDashboardPage extends ConsumerWidget {
  const EmployeesDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeesAsync = ref.watch(employeesListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/staffie/employees/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<Employee>>(
        value: employeesAsync,
        data: (employees) {
          return SfDataGrid(
            source: EmployeeDataSource(employees, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'name', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Name'))),
              GridColumn(columnName: 'code', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Code'))),
              GridColumn(columnName: 'dept', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Department'))),
              GridColumn(columnName: 'status', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Status'))),
            ],
          );
        },
      ),
    );
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(List<Employee> employees, this.context) {
    _dataGridRows = employees.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<Employee>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'name', value: e.fullName),
      DataGridCell<String>(columnName: 'code', value: e.employeeCode),
      DataGridCell<String>(columnName: 'dept', value: e.department ?? '-'),
      DataGridCell<String>(columnName: 'status', value: e.status ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final emp = row.getCells().first.value as Employee;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/staffie/employees/${emp.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
