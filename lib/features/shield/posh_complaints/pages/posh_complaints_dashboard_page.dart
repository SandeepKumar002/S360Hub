import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/posh_complaints_repository.dart';
import '../models/posh_complaint_model.dart';

class ShieldPoshComplaintDashboardPage extends ConsumerWidget {
  const ShieldPoshComplaintDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(shieldPoshComplaintListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PohComplaints (Shield)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/shield/posh-complaints/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<ShieldPoshComplaint>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: ShieldPoshComplaintDataSource(list, context),
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

class ShieldPoshComplaintDataSource extends DataGridSource {
  ShieldPoshComplaintDataSource(List<ShieldPoshComplaint> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<ShieldPoshComplaint>(columnName: 'obj', value: e),
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
    final item = row.getCells().first.value as ShieldPoshComplaint;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/shield/posh-complaints/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
