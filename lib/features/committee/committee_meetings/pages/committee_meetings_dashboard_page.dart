import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/committee_meetings_repository.dart';
import '../models/committee_meeting_model.dart';

class CommitteeCommitteeMeetingDashboardPage extends ConsumerWidget {
  const CommitteeCommitteeMeetingDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(committeeCommitteeMeetingListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CommitteeMeetings (Committee)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/committee/committee-meetings/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<CommitteeCommitteeMeeting>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: CommitteeCommitteeMeetingDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'committeeId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('CommitteeId'))),
              GridColumn(columnName: 'meetingNumber', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('MeetingNumber'))),
              GridColumn(columnName: 'meetingDate', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('MeetingDate'))),
            ],
          );
        },
      ),
    );
  }
}

class CommitteeCommitteeMeetingDataSource extends DataGridSource {
  CommitteeCommitteeMeetingDataSource(List<CommitteeCommitteeMeeting> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<CommitteeCommitteeMeeting>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'committeeId', value: e.committeeId ?? '-'),
      DataGridCell<String>(columnName: 'meetingNumber', value: e.meetingNumber ?? '-'),
      DataGridCell<String>(columnName: 'meetingDate', value: e.meetingDate?.toString().split(' ')[0] ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as CommitteeCommitteeMeeting;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/committee/committee-meetings/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
