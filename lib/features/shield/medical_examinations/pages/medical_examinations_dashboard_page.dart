import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/medical_examinations_repository.dart';
import '../models/medical_examination_model.dart';

class ShieldMedicalExaminationDashboardPage extends ConsumerWidget {
  const ShieldMedicalExaminationDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(shieldMedicalExaminationListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MedicalExaminations (Shield)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/shield/medical-examinations/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<ShieldMedicalExamination>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: ShieldMedicalExaminationDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'employeeId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('EmployeeId'))),
              GridColumn(columnName: 'examinationType', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ExaminationType'))),
              GridColumn(columnName: 'examinationDate', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ExaminationDate'))),
            ],
          );
        },
      ),
    );
  }
}

class ShieldMedicalExaminationDataSource extends DataGridSource {
  ShieldMedicalExaminationDataSource(List<ShieldMedicalExamination> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<ShieldMedicalExamination>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'employeeId', value: e.employeeId ?? '-'),
      DataGridCell<String>(columnName: 'examinationType', value: e.examinationType ?? '-'),
      DataGridCell<String>(columnName: 'examinationDate', value: e.examinationDate?.toString().split(' ')[0] ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as ShieldMedicalExamination;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/shield/medical-examinations/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
