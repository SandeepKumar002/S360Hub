import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/lms_settings_repository.dart';
import '../models/lms_setting_model.dart';

class TrainingLmsSettingDashboardPage extends ConsumerWidget {
  const TrainingLmsSettingDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(trainingLmsSettingListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('LmSettings (Training)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/training/lms-settings/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<TrainingLmsSetting>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: TrainingLmsSettingDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'rules', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Rules'))),
              GridColumn(columnName: 'reassignPolicy', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ReassignPolicy'))),
              GridColumn(columnName: 'updatedBy', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('UpdatedBy'))),
            ],
          );
        },
      ),
    );
  }
}

class TrainingLmsSettingDataSource extends DataGridSource {
  TrainingLmsSettingDataSource(List<TrainingLmsSetting> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<TrainingLmsSetting>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'rules', value: e.rules?.toString() ?? '-'),
      DataGridCell<String>(columnName: 'reassignPolicy', value: e.reassignPolicy ?? '-'),
      DataGridCell<String>(columnName: 'updatedBy', value: e.updatedBy ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as TrainingLmsSetting;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/training/lms-settings/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
