import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/bank_transactions_repository.dart';
import '../models/bank_transaction_model.dart';

class FinacBankTransactionDashboardPage extends ConsumerWidget {
  const FinacBankTransactionDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(finacBankTransactionListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('BankTranactions (Finac)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/finac/bank-transactions/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<FinacBankTransaction>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: FinacBankTransactionDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'transactionNumber', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('TransactionNumber'))),
              GridColumn(columnName: 'bankAccountId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('BankAccountId'))),
              GridColumn(columnName: 'txnDate', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('TxnDate'))),
            ],
          );
        },
      ),
    );
  }
}

class FinacBankTransactionDataSource extends DataGridSource {
  FinacBankTransactionDataSource(List<FinacBankTransaction> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<FinacBankTransaction>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'transactionNumber', value: e.transactionNumber ?? '-'),
      DataGridCell<String>(columnName: 'bankAccountId', value: e.bankAccountId ?? '-'),
      DataGridCell<String>(columnName: 'txnDate', value: e.txnDate?.toString().split(' ')[0] ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as FinacBankTransaction;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/finac/bank-transactions/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
