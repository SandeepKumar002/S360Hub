import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../../shared/repositories/recruit_repository.dart';
import '../models/job_model.dart';

class JobsDashboardPage extends ConsumerWidget {
  const JobsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(jobsListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Job Openings (ATS)')),
      body: AsyncValueWidget<List<JobPosting>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: JobDataSource(list),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'title', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Title'))),
              GridColumn(columnName: 'dept', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Dept'))),
              GridColumn(columnName: 'loc', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Location'))),
              GridColumn(columnName: 'status', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Status'))),
            ],
          );
        },
      ),
    );
  }
}

class JobDataSource extends DataGridSource {
  JobDataSource(List<JobPosting> jobs) {
    _dataGridRows = jobs.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'title', value: e.title),
      DataGridCell<String>(columnName: 'dept', value: e.dept ?? '-'),
      DataGridCell<String>(columnName: 'loc', value: e.location ?? '-'),
      DataGridCell<String>(columnName: 'status', value: e.status ?? '-'),
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
