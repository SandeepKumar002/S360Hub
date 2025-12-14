import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/surveys_repository.dart';
import '../models/survey_model.dart';

class SurveySurveyDashboardPage extends ConsumerWidget {
  const SurveySurveyDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(surveySurveyListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Surveys (Survey)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/survey/surveys/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<SurveySurvey>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: SurveySurveyDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'title', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Title'))),
              GridColumn(columnName: 'description', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Description'))),
              GridColumn(columnName: 'surveyType', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('SurveyType'))),
            ],
          );
        },
      ),
    );
  }
}

class SurveySurveyDataSource extends DataGridSource {
  SurveySurveyDataSource(List<SurveySurvey> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<SurveySurvey>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'title', value: e.title ?? '-'),
      DataGridCell<String>(columnName: 'description', value: e.description ?? '-'),
      DataGridCell<String>(columnName: 'surveyType', value: e.surveyType ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as SurveySurvey;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/survey/surveys/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
