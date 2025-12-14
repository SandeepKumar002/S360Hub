import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/messages_repository.dart';
import '../models/message_model.dart';

class CommMessageDashboardPage extends ConsumerWidget {
  const CommMessageDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(commMessageListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meages (Comm)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/comm/messages/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<CommMessage>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: CommMessageDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'channelId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ChannelId'))),
              GridColumn(columnName: 'senderId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('SenderId'))),
              GridColumn(columnName: 'body', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Body'))),
            ],
          );
        },
      ),
    );
  }
}

class CommMessageDataSource extends DataGridSource {
  CommMessageDataSource(List<CommMessage> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<CommMessage>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'channelId', value: e.channelId ?? '-'),
      DataGridCell<String>(columnName: 'senderId', value: e.senderId ?? '-'),
      DataGridCell<String>(columnName: 'body', value: e.body ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as CommMessage;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/comm/messages/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
