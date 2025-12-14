import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/survey_responses_repository.dart';
import '../models/survey_response_model.dart';

class SurveySurveyResponseDashboardPage extends ConsumerWidget {
  const SurveySurveyResponseDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(surveySurveyResponseListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SurveyRepones (Survey)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/survey/survey-responses/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<SurveySurveyResponse>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: SurveySurveyResponseDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'surveyId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('SurveyId'))),
              GridColumn(columnName: 'respondentId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('RespondentId'))),
              GridColumn(columnName: 'submittedAt', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('SubmittedAt'))),
            ],
          );
        },
      ),
    );
  }
}

class SurveySurveyResponseDataSource extends DataGridSource {
  SurveySurveyResponseDataSource(List<SurveySurveyResponse> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<SurveySurveyResponse>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'surveyId', value: e.surveyId ?? '-'),
      DataGridCell<String>(columnName: 'respondentId', value: e.respondentId ?? '-'),
      DataGridCell<String>(columnName: 'submittedAt', value: e.submittedAt?.toString().split(' ')[0] ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as SurveySurveyResponse;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/survey/survey-responses/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
