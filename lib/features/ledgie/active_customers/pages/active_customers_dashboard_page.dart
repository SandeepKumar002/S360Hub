import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/active_customers_repository.dart';
import '../models/active_customer_model.dart';

class LedgieActiveCustomerDashboardPage extends ConsumerWidget {
  const LedgieActiveCustomerDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(ledgieActiveCustomerListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ActiveCutomers (Ledgie)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/ledgie/active-customers/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<LedgieActiveCustomer>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: LedgieActiveCustomerDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'entityCode', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('EntityCode'))),
              GridColumn(columnName: 'name', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Name'))),
              GridColumn(columnName: 'type', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Type'))),
            ],
          );
        },
      ),
    );
  }
}

class LedgieActiveCustomerDataSource extends DataGridSource {
  LedgieActiveCustomerDataSource(List<LedgieActiveCustomer> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<LedgieActiveCustomer>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'entityCode', value: e.entityCode ?? '-'),
      DataGridCell<String>(columnName: 'name', value: e.name ?? '-'),
      DataGridCell<String>(columnName: 'type', value: e.type ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as LedgieActiveCustomer;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/ledgie/active-customers/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
