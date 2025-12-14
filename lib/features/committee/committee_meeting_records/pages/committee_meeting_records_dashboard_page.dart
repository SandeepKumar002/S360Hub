import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/committee_meeting_records_repository.dart';
import '../models/committee_meeting_record_model.dart';

class CommitteeCommitteeMeetingRecordDashboardPage extends ConsumerWidget {
  const CommitteeCommitteeMeetingRecordDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(committeeCommitteeMeetingRecordListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CommitteeMeetingRecords (Committee)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/committee/committee-meeting-records/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<CommitteeCommitteeMeetingRecord>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: CommitteeCommitteeMeetingRecordDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'meetingId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('MeetingId'))),
              GridColumn(columnName: 'agendaItem', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('AgendaItem'))),
              GridColumn(columnName: 'discussion', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Discussion'))),
            ],
          );
        },
      ),
    );
  }
}

class CommitteeCommitteeMeetingRecordDataSource extends DataGridSource {
  CommitteeCommitteeMeetingRecordDataSource(List<CommitteeCommitteeMeetingRecord> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<CommitteeCommitteeMeetingRecord>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'meetingId', value: e.meetingId ?? '-'),
      DataGridCell<String>(columnName: 'agendaItem', value: e.agendaItem ?? '-'),
      DataGridCell<String>(columnName: 'discussion', value: e.discussion ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as CommitteeCommitteeMeetingRecord;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/committee/committee-meeting-records/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
