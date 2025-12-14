import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/survey_pulse_repository.dart';
import '../models/survey_pulse_model.dart';

class SurveySurveyPulseDashboardPage extends ConsumerWidget {
  const SurveySurveyPulseDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(surveySurveyPulseListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SurveyPules (Survey)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/survey/survey-pulse/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<SurveySurveyPulse>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: SurveySurveyPulseDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'frequency', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Frequency'))),
              GridColumn(columnName: 'nextRun', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('NextRun'))),
              GridColumn(columnName: 'targetGroups', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('TargetGroups'))),
            ],
          );
        },
      ),
    );
  }
}

class SurveySurveyPulseDataSource extends DataGridSource {
  SurveySurveyPulseDataSource(List<SurveySurveyPulse> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<SurveySurveyPulse>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'frequency', value: e.frequency ?? '-'),
      DataGridCell<String>(columnName: 'nextRun', value: e.nextRun?.toString().split(' ')[0] ?? '-'),
      DataGridCell<String>(columnName: 'targetGroups', value: e.targetGroups?.toString() ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as SurveySurveyPulse;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/survey/survey-pulse/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
