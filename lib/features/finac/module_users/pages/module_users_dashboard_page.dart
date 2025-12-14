import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/module_users_repository.dart';
import '../models/module_user_model.dart';

class FinacModuleUserDashboardPage extends ConsumerWidget {
  const FinacModuleUserDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(finacModuleUserListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ModuleUers (Finac)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/finac/module-users/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<FinacModuleUser>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: FinacModuleUserDataSource(list, context),
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

class FinacModuleUserDataSource extends DataGridSource {
  FinacModuleUserDataSource(List<FinacModuleUser> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<FinacModuleUser>(columnName: 'obj', value: e),
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
    final item = row.getCells().first.value as FinacModuleUser;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/finac/module-users/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
