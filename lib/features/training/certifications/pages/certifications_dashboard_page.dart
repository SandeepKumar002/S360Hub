import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/certifications_repository.dart';
import '../models/certification_model.dart';

class TrainingCertificationDashboardPage extends ConsumerWidget {
  const TrainingCertificationDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(trainingCertificationListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Certifications (Training)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/training/certifications/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<TrainingCertification>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: TrainingCertificationDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'employeeId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('EmployeeId'))),
              GridColumn(columnName: 'courseId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('CourseId'))),
              GridColumn(columnName: 'certificateNo', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('CertificateNo'))),
            ],
          );
        },
      ),
    );
  }
}

class TrainingCertificationDataSource extends DataGridSource {
  TrainingCertificationDataSource(List<TrainingCertification> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<TrainingCertification>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'employeeId', value: e.employeeId ?? '-'),
      DataGridCell<String>(columnName: 'courseId', value: e.courseId ?? '-'),
      DataGridCell<String>(columnName: 'certificateNo', value: e.certificateNo ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as TrainingCertification;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/training/certifications/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
