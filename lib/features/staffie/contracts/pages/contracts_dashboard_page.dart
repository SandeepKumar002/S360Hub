import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/contracts_repository.dart';
import '../models/contract_model.dart';
import 'package:intl/intl.dart';

class ContractsDashboardPage extends ConsumerWidget {
  const ContractsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(contractsListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Contracts')),
      body: AsyncValueWidget<List<EmploymentContract>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: ContractDataSource(list),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'number', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Number'))),
              GridColumn(columnName: 'type', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Type'))),
              GridColumn(columnName: 'dates', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Dates'))),
              GridColumn(columnName: 'status', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Status'))),
            ],
          );
        },
      ),
    );
  }
}

class ContractDataSource extends DataGridSource {
  ContractDataSource(List<EmploymentContract> contracts) {
    final fmt = DateFormat('MMM dd, yyyy');
    _dataGridRows = contracts.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'number', value: e.contractNumber),
      DataGridCell<String>(columnName: 'type', value: e.type ?? '-'),
      DataGridCell<String>(columnName: 'dates', value: e.endDate != null ? fmt.format(e.endDate!) : 'Ongoing'),
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
