import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/grievance_complaints_repository.dart';
import '../models/grievance_complaint_model.dart';

class ShieldGrievanceComplaintDashboardPage extends ConsumerWidget {
  const ShieldGrievanceComplaintDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(shieldGrievanceComplaintListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GrievanceComplaints (Shield)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/shield/grievance-complaints/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<ShieldGrievanceComplaint>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: ShieldGrievanceComplaintDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'complaintId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ComplaintId'))),
              GridColumn(columnName: 'complaintType', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ComplaintType'))),
              GridColumn(columnName: 'description', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Description'))),
            ],
          );
        },
      ),
    );
  }
}

class ShieldGrievanceComplaintDataSource extends DataGridSource {
  ShieldGrievanceComplaintDataSource(List<ShieldGrievanceComplaint> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<ShieldGrievanceComplaint>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'complaintId', value: e.complaintId ?? '-'),
      DataGridCell<String>(columnName: 'complaintType', value: e.complaintType ?? '-'),
      DataGridCell<String>(columnName: 'description', value: e.description ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as ShieldGrievanceComplaint;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/shield/grievance-complaints/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
