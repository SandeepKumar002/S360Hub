import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/module_roles_repository.dart';
import '../models/module_role_model.dart';

class FinacModuleRoleDashboardPage extends ConsumerWidget {
  const FinacModuleRoleDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(finacModuleRoleListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ModuleRoles (Finac)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/finac/module-roles/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<FinacModuleRole>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: FinacModuleRoleDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'roleCode', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('RoleCode'))),
              GridColumn(columnName: 'displayName', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('DisplayName'))),
              GridColumn(columnName: 'description', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Description'))),
            ],
          );
        },
      ),
    );
  }
}

class FinacModuleRoleDataSource extends DataGridSource {
  FinacModuleRoleDataSource(List<FinacModuleRole> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<FinacModuleRole>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'roleCode', value: e.roleCode ?? '-'),
      DataGridCell<String>(columnName: 'displayName', value: e.displayName ?? '-'),
      DataGridCell<String>(columnName: 'description', value: e.description ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as FinacModuleRole;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/finac/module-roles/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
