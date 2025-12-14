import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/assessment_attempts_repository.dart';
import '../models/assessment_attempt_model.dart';

class TrainingAssessmentAttemptDashboardPage extends ConsumerWidget {
  const TrainingAssessmentAttemptDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(trainingAssessmentAttemptListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AementAttempts (Training)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/training/assessment-attempts/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<TrainingAssessmentAttempt>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: TrainingAssessmentAttemptDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'assessmentId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('AssessmentId'))),
              GridColumn(columnName: 'employeeId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('EmployeeId'))),
              GridColumn(columnName: 'attemptDate', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('AttemptDate'))),
            ],
          );
        },
      ),
    );
  }
}

class TrainingAssessmentAttemptDataSource extends DataGridSource {
  TrainingAssessmentAttemptDataSource(List<TrainingAssessmentAttempt> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<TrainingAssessmentAttempt>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'assessmentId', value: e.assessmentId ?? '-'),
      DataGridCell<String>(columnName: 'employeeId', value: e.employeeId ?? '-'),
      DataGridCell<String>(columnName: 'attemptDate', value: e.attemptDate?.toString().split(' ')[0] ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as TrainingAssessmentAttempt;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/training/assessment-attempts/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
