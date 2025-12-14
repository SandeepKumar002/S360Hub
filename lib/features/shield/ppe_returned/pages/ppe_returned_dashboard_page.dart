import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/ppe_returned_repository.dart';
import '../models/ppe_returned_model.dart';

class ShieldPpeReturnedDashboardPage extends ConsumerWidget {
  const ShieldPpeReturnedDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(shieldPpeReturnedListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PpeReturneds (Shield)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/shield/ppe-returned/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<ShieldPpeReturned>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: ShieldPpeReturnedDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'ppeIssuedId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('PpeIssuedId'))),
              GridColumn(columnName: 'returnDate', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ReturnDate'))),
              GridColumn(columnName: 'quantityReturned', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('QuantityReturned'))),
            ],
          );
        },
      ),
    );
  }
}

class ShieldPpeReturnedDataSource extends DataGridSource {
  ShieldPpeReturnedDataSource(List<ShieldPpeReturned> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<ShieldPpeReturned>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'ppeIssuedId', value: e.ppeIssuedId ?? '-'),
      DataGridCell<String>(columnName: 'returnDate', value: e.returnDate?.toString().split(' ')[0] ?? '-'),
      DataGridCell<String>(columnName: 'quantityReturned', value: e.quantityReturned?.toString() ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as ShieldPpeReturned;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/shield/ppe-returned/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
