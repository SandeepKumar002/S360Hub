import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/attendance_repository.dart';
import '../models/attendance_model.dart';
import '../../../../core/services/feedback_service.dart';

class AttendanceDashboardPage extends ConsumerWidget {
  const AttendanceDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(attendanceListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Logs'),
        actions: [
           IconButton(
             icon: const Icon(Icons.access_time),
             onPressed: () async {
                 // Simulate Check-In
                 try {
                    await ref.read(attendanceRepositoryProvider).checkIn('mock-emp-id', DateTime.now());
                    if (context.mounted) {
                       FeedbackService.showSuccess(context, 'Checked In');
                       ref.invalidate(attendanceListProvider);
                    }
                 } catch(e) {
                    if (context.mounted) FeedbackService.showError(context, e.toString());
                 }
             },
             tooltip: 'Simulate Check-In',
           )
        ],
      ),
      body: AsyncValueWidget<List<AttendanceLog>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: AttendanceDataSource(list),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'date', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Date'))),
              GridColumn(columnName: 'in', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('In'))),
              GridColumn(columnName: 'out', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Out'))),
              GridColumn(columnName: 'status', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Status'))),
            ],
          );
        },
      ),
    );
  }
}

class AttendanceDataSource extends DataGridSource {
  AttendanceDataSource(List<AttendanceLog> logs) {
    _dataGridRows = logs.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'date', value: e.date.toString().split(' ')[0]),
      DataGridCell<String>(columnName: 'in', value: e.checkInTime != null ? _timeOnly(e.checkInTime!) : '-'),
      DataGridCell<String>(columnName: 'out', value: e.checkOutTime != null ? _timeOnly(e.checkOutTime!) : '-'),
      DataGridCell<String>(columnName: 'status', value: e.status ?? '-'),
    ])).toList();
  }
  
  String _timeOnly(DateTime dt) {
    return '${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }
  
  late List<DataGridRow> _dataGridRows;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
