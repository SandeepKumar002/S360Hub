import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/expenses_repository.dart';
import '../models/expense_claim_model.dart';

class ExpensesDashboardPage extends ConsumerWidget {
  const ExpensesDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(expensesListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Expense Claims')),
      body: AsyncValueWidget<List<ExpenseClaim>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: ExpenseDataSource(list),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'number', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Claim #'))),
              GridColumn(columnName: 'date', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Date'))),
              GridColumn(columnName: 'amount', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Amount'))),
              GridColumn(columnName: 'status', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Status'))),
            ],
          );
        },
      ),
    );
  }
}

class ExpenseDataSource extends DataGridSource {
  ExpenseDataSource(List<ExpenseClaim> claims) {
    _dataGridRows = claims.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'number', value: e.claimNumber),
      DataGridCell<String>(columnName: 'date', value: e.claimDate.toString().split(' ')[0]),
      DataGridCell<String>(columnName: 'amount', value: e.totalAmount.toStringAsFixed(2)),
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
