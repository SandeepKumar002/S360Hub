import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/module_role_assignments_repository.dart';
import '../models/module_role_assignment_model.dart';

class LedgieModuleRoleAssignmentDashboardPage extends ConsumerWidget {
  const LedgieModuleRoleAssignmentDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(ledgieModuleRoleAssignmentListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ModuleRoleAignments (Ledgie)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/ledgie/module-role-assignments/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<LedgieModuleRoleAssignment>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: LedgieModuleRoleAssignmentDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'roleId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('RoleId'))),
              GridColumn(columnName: 'personId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('PersonId'))),
              GridColumn(columnName: 'teamId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('TeamId'))),
            ],
          );
        },
      ),
    );
  }
}

class LedgieModuleRoleAssignmentDataSource extends DataGridSource {
  LedgieModuleRoleAssignmentDataSource(List<LedgieModuleRoleAssignment> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<LedgieModuleRoleAssignment>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'roleId', value: e.roleId ?? '-'),
      DataGridCell<String>(columnName: 'personId', value: e.personId ?? '-'),
      DataGridCell<String>(columnName: 'teamId', value: e.teamId ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as LedgieModuleRoleAssignment;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/ledgie/module-role-assignments/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
