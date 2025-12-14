import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/assessments_repository.dart';
import '../models/assessment_model.dart';

class TrainingAssessmentDashboardPage extends ConsumerWidget {
  const TrainingAssessmentDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(trainingAssessmentListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aements (Training)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/training/assessments/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<TrainingAssessment>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: TrainingAssessmentDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'courseId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('CourseId'))),
              GridColumn(columnName: 'type', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Type'))),
              GridColumn(columnName: 'passingScore', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('PassingScore'))),
            ],
          );
        },
      ),
    );
  }
}

class TrainingAssessmentDataSource extends DataGridSource {
  TrainingAssessmentDataSource(List<TrainingAssessment> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<TrainingAssessment>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'courseId', value: e.courseId ?? '-'),
      DataGridCell<String>(columnName: 'type', value: e.type ?? '-'),
      DataGridCell<String>(columnName: 'passingScore', value: e.passingScore?.toStringAsFixed(2) ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as TrainingAssessment;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/training/assessments/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
