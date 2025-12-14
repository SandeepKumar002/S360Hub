import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../../shared/repositories/performance_repository.dart';
import '../models/objective_model.dart';

class GoalsDashboardPage extends ConsumerWidget {
  const GoalsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(objectivesListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Goals & OKRs')),
      body: AsyncValueWidget<List<Objective>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: ObjectiveDataSource(list),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'title', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Objective'))),
              GridColumn(columnName: 'due', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Due Date'))),
              GridColumn(columnName: 'progress', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Progress'))),
              GridColumn(columnName: 'status', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Status'))),
            ],
          );
        },
      ),
    );
  }
}

class ObjectiveDataSource extends DataGridSource {
  ObjectiveDataSource(List<Objective> objs) {
    _dataGridRows = objs.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'title', value: e.title),
      DataGridCell<String>(columnName: 'due', value: e.dueDate?.toString().split(' ')[0] ?? '-'),
      DataGridCell<String>(columnName: 'progress', value: '${e.progress.toStringAsFixed(0)}%'),
      DataGridCell<String>(columnName: 'status', value: e.status ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
