import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/expense_claim_summary_repository.dart';
import '../models/expense_claim_summary_model.dart';

class FinacExpenseClaimSummaryDashboardPage extends ConsumerWidget {
  const FinacExpenseClaimSummaryDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(finacExpenseClaimSummaryListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ExpeneClaimSummarys (Finac)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/finac/expense-claim-summary/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<FinacExpenseClaimSummary>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: FinacExpenseClaimSummaryDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'claimNumber', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ClaimNumber'))),
              GridColumn(columnName: 'claimantId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ClaimantId'))),
              GridColumn(columnName: 'entityId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('EntityId'))),
            ],
          );
        },
      ),
    );
  }
}

class FinacExpenseClaimSummaryDataSource extends DataGridSource {
  FinacExpenseClaimSummaryDataSource(List<FinacExpenseClaimSummary> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<FinacExpenseClaimSummary>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'claimNumber', value: e.claimNumber ?? '-'),
      DataGridCell<String>(columnName: 'claimantId', value: e.claimantId ?? '-'),
      DataGridCell<String>(columnName: 'entityId', value: e.entityId ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as FinacExpenseClaimSummary;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/finac/expense-claim-summary/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
