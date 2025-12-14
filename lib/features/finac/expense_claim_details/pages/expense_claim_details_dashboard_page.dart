import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/expense_claim_details_repository.dart';
import '../models/expense_claim_detail_model.dart';

class FinacExpenseClaimDetailDashboardPage extends ConsumerWidget {
  const FinacExpenseClaimDetailDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(finacExpenseClaimDetailListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ExpeneClaimDetails (Finac)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/finac/expense-claim-details/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<FinacExpenseClaimDetail>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: FinacExpenseClaimDetailDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'claimId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ClaimId'))),
              GridColumn(columnName: 'lineNumber', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('LineNumber'))),
              GridColumn(columnName: 'expenseDate', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ExpenseDate'))),
            ],
          );
        },
      ),
    );
  }
}

class FinacExpenseClaimDetailDataSource extends DataGridSource {
  FinacExpenseClaimDetailDataSource(List<FinacExpenseClaimDetail> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<FinacExpenseClaimDetail>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'claimId', value: e.claimId ?? '-'),
      DataGridCell<String>(columnName: 'lineNumber', value: e.lineNumber?.toString() ?? '-'),
      DataGridCell<String>(columnName: 'expenseDate', value: e.expenseDate?.toString().split(' ')[0] ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as FinacExpenseClaimDetail;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/finac/expense-claim-details/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
