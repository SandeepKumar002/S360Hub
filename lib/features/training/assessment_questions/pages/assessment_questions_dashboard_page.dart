import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/assessment_questions_repository.dart';
import '../models/assessment_question_model.dart';

class TrainingAssessmentQuestionDashboardPage extends ConsumerWidget {
  const TrainingAssessmentQuestionDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(trainingAssessmentQuestionListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AementQuetions (Training)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/training/assessment-questions/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<TrainingAssessmentQuestion>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: TrainingAssessmentQuestionDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'assessmentId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('AssessmentId'))),
              GridColumn(columnName: 'qType', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('QType'))),
              GridColumn(columnName: 'question', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Question'))),
            ],
          );
        },
      ),
    );
  }
}

class TrainingAssessmentQuestionDataSource extends DataGridSource {
  TrainingAssessmentQuestionDataSource(List<TrainingAssessmentQuestion> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<TrainingAssessmentQuestion>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'assessmentId', value: e.assessmentId ?? '-'),
      DataGridCell<String>(columnName: 'qType', value: e.qType ?? '-'),
      DataGridCell<String>(columnName: 'question', value: e.question ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as TrainingAssessmentQuestion;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/training/assessment-questions/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
