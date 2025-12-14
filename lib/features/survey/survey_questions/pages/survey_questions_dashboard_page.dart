import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/survey_questions_repository.dart';
import '../models/survey_question_model.dart';

class SurveySurveyQuestionDashboardPage extends ConsumerWidget {
  const SurveySurveyQuestionDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(surveySurveyQuestionListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SurveyQuetions (Survey)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/survey/survey-questions/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<SurveySurveyQuestion>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: SurveySurveyQuestionDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'surveyId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('SurveyId'))),
              GridColumn(columnName: 'qText', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('QText'))),
              GridColumn(columnName: 'qType', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('QType'))),
            ],
          );
        },
      ),
    );
  }
}

class SurveySurveyQuestionDataSource extends DataGridSource {
  SurveySurveyQuestionDataSource(List<SurveySurveyQuestion> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<SurveySurveyQuestion>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'surveyId', value: e.surveyId ?? '-'),
      DataGridCell<String>(columnName: 'qText', value: e.qText ?? '-'),
      DataGridCell<String>(columnName: 'qType', value: e.qType ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as SurveySurveyQuestion;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/survey/survey-questions/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
