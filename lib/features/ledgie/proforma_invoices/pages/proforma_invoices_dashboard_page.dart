import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/proforma_invoices_repository.dart';
import '../models/proforma_invoice_model.dart';

class LedgieProformaInvoiceDashboardPage extends ConsumerWidget {
  const LedgieProformaInvoiceDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(ledgieProformaInvoiceListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ProformaInvoices (Ledgie)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/ledgie/proforma-invoices/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<LedgieProformaInvoice>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: LedgieProformaInvoiceDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'entityType', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('EntityType'))),
              GridColumn(columnName: 'proformaType', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ProformaType'))),
              GridColumn(columnName: 'serviceOrderId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ServiceOrderId'))),
            ],
          );
        },
      ),
    );
  }
}

class LedgieProformaInvoiceDataSource extends DataGridSource {
  LedgieProformaInvoiceDataSource(List<LedgieProformaInvoice> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<LedgieProformaInvoice>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'entityType', value: e.entityType ?? '-'),
      DataGridCell<String>(columnName: 'proformaType', value: e.proformaType ?? '-'),
      DataGridCell<String>(columnName: 'serviceOrderId', value: e.serviceOrderId ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as LedgieProformaInvoice;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/ledgie/proforma-invoices/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
