import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/contracts_repository.dart';
import '../models/contract_model.dart';

class ContracforceContractDashboardPage extends ConsumerWidget {
  const ContracforceContractDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(contracforceContractListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contracts (Contracforce)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/contracforce/contracts/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<ContracforceContract>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: ContracforceContractDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'contractorId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ContractorId'))),
              GridColumn(columnName: 'contractNumber', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ContractNumber'))),
              GridColumn(columnName: 'contractType', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ContractType'))),
            ],
          );
        },
      ),
    );
  }
}

class ContracforceContractDataSource extends DataGridSource {
  ContracforceContractDataSource(List<ContracforceContract> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<ContracforceContract>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'contractorId', value: e.contractorId ?? '-'),
      DataGridCell<String>(columnName: 'contractNumber', value: e.contractNumber ?? '-'),
      DataGridCell<String>(columnName: 'contractType', value: e.contractType ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as ContracforceContract;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/contracforce/contracts/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
