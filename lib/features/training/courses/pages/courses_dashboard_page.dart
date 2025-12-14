import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/courses_repository.dart';
import '../models/course_model.dart';

class TrainingCourseDashboardPage extends ConsumerWidget {
  const TrainingCourseDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(trainingCourseListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coures (Training)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/training/courses/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<TrainingCourse>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: TrainingCourseDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'code', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Code'))),
              GridColumn(columnName: 'title', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Title'))),
              GridColumn(columnName: 'description', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Description'))),
            ],
          );
        },
      ),
    );
  }
}

class TrainingCourseDataSource extends DataGridSource {
  TrainingCourseDataSource(List<TrainingCourse> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<TrainingCourse>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'code', value: e.code ?? '-'),
      DataGridCell<String>(columnName: 'title', value: e.title ?? '-'),
      DataGridCell<String>(columnName: 'description', value: e.description ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as TrainingCourse;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/training/courses/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
