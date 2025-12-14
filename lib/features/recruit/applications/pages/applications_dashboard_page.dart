import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../../shared/repositories/recruit_repository.dart';
import '../models/application_model.dart';

class ApplicationsDashboardPage extends ConsumerWidget {
  const ApplicationsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(applicationsListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Applications')),
      body: AsyncValueWidget<List<JobApplication>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: ApplicationDataSource(list),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'job', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Job ID'))),
              GridColumn(columnName: 'candidate', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Candidate ID'))),
              GridColumn(columnName: 'status', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Status'))),
              GridColumn(columnName: 'date', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Date'))),
            ],
          );
        },
      ),
    );
  }
}

class ApplicationDataSource extends DataGridSource {
  ApplicationDataSource(List<JobApplication> apps) {
    _dataGridRows = apps.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'job', value: e.jobId.substring(0, 8)),
      DataGridCell<String>(columnName: 'candidate', value: e.candidatePersonId?.substring(0, 8) ?? '-'),
      DataGridCell<String>(columnName: 'status', value: e.status ?? '-'),
      DataGridCell<String>(columnName: 'date', value: e.appliedAt?.toString().split(' ')[0] ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
