import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/enrollments_repository.dart';
import '../models/enrollment_model.dart';

class TrainingEnrollmentDashboardPage extends ConsumerWidget {
  const TrainingEnrollmentDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(trainingEnrollmentListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enrollments (Training)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/training/enrollments/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<TrainingEnrollment>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: TrainingEnrollmentDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'sessionId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('SessionId'))),
              GridColumn(columnName: 'employeeId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('EmployeeId'))),
              GridColumn(columnName: 'status', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Status'))),
            ],
          );
        },
      ),
    );
  }
}

class TrainingEnrollmentDataSource extends DataGridSource {
  TrainingEnrollmentDataSource(List<TrainingEnrollment> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<TrainingEnrollment>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'sessionId', value: e.sessionId ?? '-'),
      DataGridCell<String>(columnName: 'employeeId', value: e.employeeId ?? '-'),
      DataGridCell<String>(columnName: 'status', value: e.status ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as TrainingEnrollment;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/training/enrollments/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
