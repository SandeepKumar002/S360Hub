import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/committee_members_repository.dart';
import '../models/committee_member_model.dart';

class CommitteeCommitteeMemberDashboardPage extends ConsumerWidget {
  const CommitteeCommitteeMemberDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(committeeCommitteeMemberListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CommitteeMembers (Committee)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/committee/committee-members/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<CommitteeCommitteeMember>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: CommitteeCommitteeMemberDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'committeeId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('CommitteeId'))),
              GridColumn(columnName: 'personId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('PersonId'))),
              GridColumn(columnName: 'memberRole', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('MemberRole'))),
            ],
          );
        },
      ),
    );
  }
}

class CommitteeCommitteeMemberDataSource extends DataGridSource {
  CommitteeCommitteeMemberDataSource(List<CommitteeCommitteeMember> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<CommitteeCommitteeMember>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'committeeId', value: e.committeeId ?? '-'),
      DataGridCell<String>(columnName: 'personId', value: e.personId ?? '-'),
      DataGridCell<String>(columnName: 'memberRole', value: e.memberRole ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as CommitteeCommitteeMember;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/committee/committee-members/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
