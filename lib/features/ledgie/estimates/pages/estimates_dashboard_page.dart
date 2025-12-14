import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/estimates_repository.dart';
import '../models/estimate_model.dart';

class LedgieEstimateDashboardPage extends ConsumerWidget {
  const LedgieEstimateDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(ledgieEstimateListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Etimates (Ledgie)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/ledgie/estimates/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<LedgieEstimate>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: LedgieEstimateDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'proposalId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ProposalId'))),
              GridColumn(columnName: 'estimateNumber', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('EstimateNumber'))),
              GridColumn(columnName: 'estimateDate', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('EstimateDate'))),
            ],
          );
        },
      ),
    );
  }
}

class LedgieEstimateDataSource extends DataGridSource {
  LedgieEstimateDataSource(List<LedgieEstimate> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<LedgieEstimate>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'proposalId', value: e.proposalId ?? '-'),
      DataGridCell<String>(columnName: 'estimateNumber', value: e.estimateNumber ?? '-'),
      DataGridCell<String>(columnName: 'estimateDate', value: e.estimateDate?.toString().split(' ')[0] ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as LedgieEstimate;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/ledgie/estimates/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
