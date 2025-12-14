import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/channel_members_repository.dart';
import '../models/channel_member_model.dart';

class CommChannelMemberDashboardPage extends ConsumerWidget {
  const CommChannelMemberDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(commChannelMemberListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ChannelMembers (Comm)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/comm/channel-members/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<CommChannelMember>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: CommChannelMemberDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'channelId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ChannelId'))),
              GridColumn(columnName: 'personId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('PersonId'))),
              GridColumn(columnName: 'joinedAt', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('JoinedAt'))),
            ],
          );
        },
      ),
    );
  }
}

class CommChannelMemberDataSource extends DataGridSource {
  CommChannelMemberDataSource(List<CommChannelMember> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<CommChannelMember>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'channelId', value: e.channelId ?? '-'),
      DataGridCell<String>(columnName: 'personId', value: e.personId ?? '-'),
      DataGridCell<String>(columnName: 'joinedAt', value: e.joinedAt?.toString().split(' ')[0] ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as CommChannelMember;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/comm/channel-members/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
