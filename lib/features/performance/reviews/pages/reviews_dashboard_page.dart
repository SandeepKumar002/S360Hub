import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../../shared/repositories/performance_repository.dart';
import '../models/review_model.dart';

class ReviewsDashboardPage extends ConsumerWidget {
  const ReviewsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(reviewsListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Performance Reviews')),
      body: AsyncValueWidget<List<PerformanceReview>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: ReviewDataSource(list),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'employee', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Employee ID'))),
              GridColumn(columnName: 'rating', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Rating'))),
              GridColumn(columnName: 'status', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Status'))),
            ],
          );
        },
      ),
    );
  }
}

class ReviewDataSource extends DataGridSource {
  ReviewDataSource(List<PerformanceReview> reviews) {
    _dataGridRows = reviews.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'employee', value: e.employeeId.substring(0, 8)),
      DataGridCell<String>(columnName: 'rating', value: e.rating?.toString() ?? '-'),
      DataGridCell<String>(columnName: 'status', value: e.status ?? '-'),
    ])).toList();
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
