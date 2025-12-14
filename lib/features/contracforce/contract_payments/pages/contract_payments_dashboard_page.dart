import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/contract_payments_repository.dart';
import '../models/contract_payment_model.dart';

class ContracforceContractPaymentDashboardPage extends ConsumerWidget {
  const ContracforceContractPaymentDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(contracforceContractPaymentListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ContractPayments (Contracforce)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/contracforce/contract-payments/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<ContracforceContractPayment>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: ContracforceContractPaymentDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'contractId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ContractId'))),
              GridColumn(columnName: 'paymentNumber', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('PaymentNumber'))),
              GridColumn(columnName: 'invoiceNumber', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('InvoiceNumber'))),
            ],
          );
        },
      ),
    );
  }
}

class ContracforceContractPaymentDataSource extends DataGridSource {
  ContracforceContractPaymentDataSource(List<ContracforceContractPayment> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<ContracforceContractPayment>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'contractId', value: e.contractId ?? '-'),
      DataGridCell<String>(columnName: 'paymentNumber', value: e.paymentNumber ?? '-'),
      DataGridCell<String>(columnName: 'invoiceNumber', value: e.invoiceNumber ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as ContracforceContractPayment;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/contracforce/contract-payments/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
