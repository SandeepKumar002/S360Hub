import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/contractors_repository.dart';
import '../models/contractor_model.dart';

class ContracforceContractorDashboardPage extends ConsumerWidget {
  const ContracforceContractorDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(contracforceContractorListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contractors (Contracforce)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/contracforce/contractors/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<ContracforceContractor>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: ContracforceContractorDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'entityId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('EntityId'))),
              GridColumn(columnName: 'contractorCode', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ContractorCode'))),
              GridColumn(columnName: 'contractorName', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ContractorName'))),
            ],
          );
        },
      ),
    );
  }
}

class ContracforceContractorDataSource extends DataGridSource {
  ContracforceContractorDataSource(List<ContracforceContractor> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<ContracforceContractor>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'entityId', value: e.entityId ?? '-'),
      DataGridCell<String>(columnName: 'contractorCode', value: e.contractorCode ?? '-'),
      DataGridCell<String>(columnName: 'contractorName', value: e.contractorName ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as ContracforceContractor;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/contracforce/contractors/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
