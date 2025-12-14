import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/lookups_repository.dart';
import '../models/lookup_models.dart';

class LookupGroupsDashboardPage extends ConsumerWidget {
  const LookupGroupsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsAsync = ref.watch(lookupGroupsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lookup Groups'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/nexus/lookups/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<LookupGroup>>(
        value: groupsAsync,
        data: (groups) {
          return SfDataGrid(
            source: LookupGroupDataSource(groups, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(
                columnName: 'display_name',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: const Text('Name', overflow: TextOverflow.ellipsis),
                ),
              ),
              GridColumn(
                columnName: 'code',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: const Text('Code', overflow: TextOverflow.ellipsis),
                ),
              ),
              GridColumn(
                columnName: 'is_active',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: const Text('Active', overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class LookupGroupDataSource extends DataGridSource {
  LookupGroupDataSource(List<LookupGroup> groups, this.context) {
    _dataGridRows = groups
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<LookupGroup>(columnName: 'obj', value: e),
              DataGridCell<String>(columnName: 'display_name', value: e.displayName),
              DataGridCell<String>(columnName: 'code', value: e.code),
              DataGridCell<bool>(columnName: 'is_active', value: e.isActive),
            ]))
        .toList();
  }

  late List<DataGridRow> _dataGridRows;
  final BuildContext context;

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final group = row.getCells().first.value as LookupGroup;

    return DataGridRowAdapter(
      cells: row.getCells().skip(1).map<Widget>((dataGridCell) {
        return GestureDetector(
          onTap: () => context.push('/nexus/lookups/${group.id}'),
          behavior: HitTestBehavior.opaque,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: dataGridCell.value is bool 
                ? Icon(
                    dataGridCell.value ? Icons.check_circle : Icons.cancel,
                    color: dataGridCell.value ? Colors.green : Colors.grey,
                    size: 20,
                  )
                : Text(
                    dataGridCell.value.toString(),
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
        );
      }).toList(),
    );
  }
}
