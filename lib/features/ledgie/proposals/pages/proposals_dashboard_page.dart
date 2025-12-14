import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/proposals_repository.dart';
import '../models/proposal_model.dart';

class LedgieProposalDashboardPage extends ConsumerWidget {
  const LedgieProposalDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(ledgieProposalListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Propoals (Ledgie)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/ledgie/proposals/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<LedgieProposal>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: LedgieProposalDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'entityId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('EntityId'))),
              GridColumn(columnName: 'proposalCode', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ProposalCode'))),
              GridColumn(columnName: 'title', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Title'))),
            ],
          );
        },
      ),
    );
  }
}

class LedgieProposalDataSource extends DataGridSource {
  LedgieProposalDataSource(List<LedgieProposal> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<LedgieProposal>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'entityId', value: e.entityId ?? '-'),
      DataGridCell<String>(columnName: 'proposalCode', value: e.proposalCode ?? '-'),
      DataGridCell<String>(columnName: 'title', value: e.title ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as LedgieProposal;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/ledgie/proposals/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
