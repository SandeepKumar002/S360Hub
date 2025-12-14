import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/notifications_repository.dart';
import '../models/notification_model.dart';

class CommNotificationDashboardPage extends ConsumerWidget {
  const CommNotificationDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(commNotificationListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications (Comm)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/comm/notifications/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<CommNotification>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: CommNotificationDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'personId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('PersonId'))),
              GridColumn(columnName: 'referenceTable', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ReferenceTable'))),
              GridColumn(columnName: 'referenceId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ReferenceId'))),
            ],
          );
        },
      ),
    );
  }
}

class CommNotificationDataSource extends DataGridSource {
  CommNotificationDataSource(List<CommNotification> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<CommNotification>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'personId', value: e.personId ?? '-'),
      DataGridCell<String>(columnName: 'referenceTable', value: e.referenceTable ?? '-'),
      DataGridCell<String>(columnName: 'referenceId', value: e.referenceId ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as CommNotification;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/comm/notifications/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
