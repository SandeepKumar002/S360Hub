import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/gst_transactions_repository.dart';
import '../models/gst_transaction_model.dart';

class TaxforgeGstTransactionDashboardPage extends ConsumerWidget {
  const TaxforgeGstTransactionDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(taxforgeGstTransactionListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GtTranactions (Taxforge)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/taxforge/gst-transactions/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<TaxforgeGstTransaction>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: TaxforgeGstTransactionDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'referenceTable', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ReferenceTable'))),
              GridColumn(columnName: 'referenceId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ReferenceId'))),
              GridColumn(columnName: 'gstDetailId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('GstDetailId'))),
            ],
          );
        },
      ),
    );
  }
}

class TaxforgeGstTransactionDataSource extends DataGridSource {
  TaxforgeGstTransactionDataSource(List<TaxforgeGstTransaction> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<TaxforgeGstTransaction>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'referenceTable', value: e.referenceTable ?? '-'),
      DataGridCell<String>(columnName: 'referenceId', value: e.referenceId ?? '-'),
      DataGridCell<String>(columnName: 'gstDetailId', value: e.gstDetailId ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as TaxforgeGstTransaction;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/taxforge/gst-transactions/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
