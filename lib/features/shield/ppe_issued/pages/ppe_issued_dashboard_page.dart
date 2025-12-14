import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/ppe_issued_repository.dart';
import '../models/ppe_issued_model.dart';

class ShieldPpeIssuedDashboardPage extends ConsumerWidget {
  const ShieldPpeIssuedDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(shieldPpeIssuedListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PpeIueds (Shield)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/shield/ppe-issued/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<ShieldPpeIssued>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: ShieldPpeIssuedDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'employeeId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('EmployeeId'))),
              GridColumn(columnName: 'ppeType', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('PpeType'))),
              GridColumn(columnName: 'ppeDescription', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('PpeDescription'))),
            ],
          );
        },
      ),
    );
  }
}

class ShieldPpeIssuedDataSource extends DataGridSource {
  ShieldPpeIssuedDataSource(List<ShieldPpeIssued> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<ShieldPpeIssued>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'employeeId', value: e.employeeId ?? '-'),
      DataGridCell<String>(columnName: 'ppeType', value: e.ppeType ?? '-'),
      DataGridCell<String>(columnName: 'ppeDescription', value: e.ppeDescription ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as ShieldPpeIssued;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/shield/ppe-issued/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
