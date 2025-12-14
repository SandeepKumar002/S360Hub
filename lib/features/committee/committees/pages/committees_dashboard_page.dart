import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/committees_repository.dart';
import '../models/committee_model.dart';

class CommitteeCommitteeDashboardPage extends ConsumerWidget {
  const CommitteeCommitteeDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(committeeCommitteeListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Committees (Committee)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/committee/committees/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<CommitteeCommittee>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: CommitteeCommitteeDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'committeeName', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('CommitteeName'))),
              GridColumn(columnName: 'committeeType', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('CommitteeType'))),
              GridColumn(columnName: 'formationDate', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('FormationDate'))),
            ],
          );
        },
      ),
    );
  }
}

class CommitteeCommitteeDataSource extends DataGridSource {
  CommitteeCommitteeDataSource(List<CommitteeCommittee> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<CommitteeCommittee>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'committeeName', value: e.committeeName ?? '-'),
      DataGridCell<String>(columnName: 'committeeType', value: e.committeeType ?? '-'),
      DataGridCell<String>(columnName: 'formationDate', value: e.formationDate?.toString().split(' ')[0] ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as CommitteeCommittee;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/committee/committees/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
