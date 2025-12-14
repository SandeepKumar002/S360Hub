import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/log_history_repository.dart';
import '../models/log_history_model.dart';

class ShieldLogHistoryDashboardPage extends ConsumerWidget {
  const ShieldLogHistoryDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(shieldLogHistoryListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('LogHitorys (Shield)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/shield/log-history/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<ShieldLogHistory>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: ShieldLogHistoryDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'schemaName', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('SchemaName'))),
              GridColumn(columnName: 'tableName', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('TableName'))),
              GridColumn(columnName: 'recordId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('RecordId'))),
            ],
          );
        },
      ),
    );
  }
}

class ShieldLogHistoryDataSource extends DataGridSource {
  ShieldLogHistoryDataSource(List<ShieldLogHistory> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<ShieldLogHistory>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'schemaName', value: e.schemaName ?? '-'),
      DataGridCell<String>(columnName: 'tableName', value: e.tableName ?? '-'),
      DataGridCell<String>(columnName: 'recordId', value: e.recordId ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as ShieldLogHistory;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/shield/log-history/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
