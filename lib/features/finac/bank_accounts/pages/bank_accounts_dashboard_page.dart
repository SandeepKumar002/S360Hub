import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/bank_accounts_repository.dart';
import '../models/bank_account_model.dart';

class FinacBankAccountDashboardPage extends ConsumerWidget {
  const FinacBankAccountDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(finacBankAccountListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('BankAccounts (Finac)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/finac/bank-accounts/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<FinacBankAccount>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: FinacBankAccountDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'partyType', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('PartyType'))),
              GridColumn(columnName: 'partyId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('PartyId'))),
              GridColumn(columnName: 'accountHolderName', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('AccountHolderName'))),
            ],
          );
        },
      ),
    );
  }
}

class FinacBankAccountDataSource extends DataGridSource {
  FinacBankAccountDataSource(List<FinacBankAccount> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<FinacBankAccount>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'partyType', value: e.partyType ?? '-'),
      DataGridCell<String>(columnName: 'partyId', value: e.partyId ?? '-'),
      DataGridCell<String>(columnName: 'accountHolderName', value: e.accountHolderName ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as FinacBankAccount;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/finac/bank-accounts/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
