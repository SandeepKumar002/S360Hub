import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/module_roles_repository.dart';
import '../models/module_role_model.dart';

class LedgieModuleRoleDashboardPage extends ConsumerWidget {
  const LedgieModuleRoleDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(ledgieModuleRoleListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ModuleRoles (Ledgie)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/ledgie/module-roles/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<LedgieModuleRole>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: LedgieModuleRoleDataSource(list, context),
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

class LedgieModuleRoleDataSource extends DataGridSource {
  LedgieModuleRoleDataSource(List<LedgieModuleRole> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<LedgieModuleRole>(columnName: 'obj', value: e),
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
    final item = row.getCells().first.value as LedgieModuleRole;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/ledgie/module-roles/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
