import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/module_teams_repository.dart';
import '../models/module_team_model.dart';

class FinacModuleTeamDashboardPage extends ConsumerWidget {
  const FinacModuleTeamDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(finacModuleTeamListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ModuleTeams (Finac)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/finac/module-teams/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<FinacModuleTeam>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: FinacModuleTeamDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'name', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Name'))),
              GridColumn(columnName: 'parentTeamId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ParentTeamId'))),
              GridColumn(columnName: 'leadPersonId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('LeadPersonId'))),
            ],
          );
        },
      ),
    );
  }
}

class FinacModuleTeamDataSource extends DataGridSource {
  FinacModuleTeamDataSource(List<FinacModuleTeam> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<FinacModuleTeam>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'name', value: e.name ?? '-'),
      DataGridCell<String>(columnName: 'parentTeamId', value: e.parentTeamId ?? '-'),
      DataGridCell<String>(columnName: 'leadPersonId', value: e.leadPersonId ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as FinacModuleTeam;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/finac/module-teams/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
