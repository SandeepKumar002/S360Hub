import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/module_users_repository.dart';
import '../models/module_user_model.dart';

class LedgieModuleUserDashboardPage extends ConsumerWidget {
  const LedgieModuleUserDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(ledgieModuleUserListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ModuleUers (Ledgie)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/ledgie/module-users/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<LedgieModuleUser>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: LedgieModuleUserDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'personId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('PersonId'))),
              GridColumn(columnName: 'moduleRole', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ModuleRole'))),
              GridColumn(columnName: 'designation', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Designation'))),
            ],
          );
        },
      ),
    );
  }
}

class LedgieModuleUserDataSource extends DataGridSource {
  LedgieModuleUserDataSource(List<LedgieModuleUser> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<LedgieModuleUser>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'personId', value: e.personId ?? '-'),
      DataGridCell<String>(columnName: 'moduleRole', value: e.moduleRole ?? '-'),
      DataGridCell<String>(columnName: 'designation', value: e.designation ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as LedgieModuleUser;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/ledgie/module-users/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
