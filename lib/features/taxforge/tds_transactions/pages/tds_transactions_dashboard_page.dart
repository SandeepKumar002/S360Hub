import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/tds_transactions_repository.dart';
import '../models/tds_transaction_model.dart';

class TaxforgeTdsTransactionDashboardPage extends ConsumerWidget {
  const TaxforgeTdsTransactionDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(taxforgeTdsTransactionListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TdTranactions (Taxforge)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/taxforge/tds-transactions/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<TaxforgeTdsTransaction>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: TaxforgeTdsTransactionDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'referenceTable', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ReferenceTable'))),
              GridColumn(columnName: 'referenceId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ReferenceId'))),
              GridColumn(columnName: 'tdsDetailId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('TdsDetailId'))),
            ],
          );
        },
      ),
    );
  }
}

class TaxforgeTdsTransactionDataSource extends DataGridSource {
  TaxforgeTdsTransactionDataSource(List<TaxforgeTdsTransaction> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<TaxforgeTdsTransaction>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'referenceTable', value: e.referenceTable ?? '-'),
      DataGridCell<String>(columnName: 'referenceId', value: e.referenceId ?? '-'),
      DataGridCell<String>(columnName: 'tdsDetailId', value: e.tdsDetailId ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as TaxforgeTdsTransaction;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/taxforge/tds-transactions/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
