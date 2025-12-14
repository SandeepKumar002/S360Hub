import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/sessions_repository.dart';
import '../models/session_model.dart';

class TrainingSessionDashboardPage extends ConsumerWidget {
  const TrainingSessionDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(trainingSessionListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seions (Training)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/training/sessions/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<TrainingSession>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: TrainingSessionDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'courseId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('CourseId'))),
              GridColumn(columnName: 'sessionDateStart', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('SessionDateStart'))),
              GridColumn(columnName: 'sessionDateEnd', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('SessionDateEnd'))),
            ],
          );
        },
      ),
    );
  }
}

class TrainingSessionDataSource extends DataGridSource {
  TrainingSessionDataSource(List<TrainingSession> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<TrainingSession>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'courseId', value: e.courseId ?? '-'),
      DataGridCell<String>(columnName: 'sessionDateStart', value: e.sessionDateStart?.toString().split(' ')[0] ?? '-'),
      DataGridCell<String>(columnName: 'sessionDateEnd', value: e.sessionDateEnd?.toString().split(' ')[0] ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as TrainingSession;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/training/sessions/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
