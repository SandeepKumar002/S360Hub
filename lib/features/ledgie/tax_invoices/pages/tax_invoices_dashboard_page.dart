import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/tax_invoices_repository.dart';
import '../models/tax_invoice_model.dart';

class LedgieTaxInvoiceDashboardPage extends ConsumerWidget {
  const LedgieTaxInvoiceDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(ledgieTaxInvoiceListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TaxInvoices (Ledgie)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/ledgie/tax-invoices/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<LedgieTaxInvoice>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: LedgieTaxInvoiceDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'proformaInvoiceId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ProformaInvoiceId'))),
              GridColumn(columnName: 'invoiceNumber', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('InvoiceNumber'))),
              GridColumn(columnName: 'invoiceDate', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('InvoiceDate'))),
            ],
          );
        },
      ),
    );
  }
}

class LedgieTaxInvoiceDataSource extends DataGridSource {
  LedgieTaxInvoiceDataSource(List<LedgieTaxInvoice> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<LedgieTaxInvoice>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'proformaInvoiceId', value: e.proformaInvoiceId ?? '-'),
      DataGridCell<String>(columnName: 'invoiceNumber', value: e.invoiceNumber ?? '-'),
      DataGridCell<String>(columnName: 'invoiceDate', value: e.invoiceDate?.toString().split(' ')[0] ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as LedgieTaxInvoice;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/ledgie/tax-invoices/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
