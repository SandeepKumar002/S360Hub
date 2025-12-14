import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/course_units_repository.dart';
import '../models/course_unit_model.dart';

class TrainingCourseUnitDashboardPage extends ConsumerWidget {
  const TrainingCourseUnitDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(trainingCourseUnitListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CoureUnits (Training)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/training/course-units/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<TrainingCourseUnit>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: TrainingCourseUnitDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'courseId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('CourseId'))),
              GridColumn(columnName: 'title', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Title'))),
              GridColumn(columnName: 'contentRefId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ContentRefId'))),
            ],
          );
        },
      ),
    );
  }
}

class TrainingCourseUnitDataSource extends DataGridSource {
  TrainingCourseUnitDataSource(List<TrainingCourseUnit> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<TrainingCourseUnit>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'courseId', value: e.courseId ?? '-'),
      DataGridCell<String>(columnName: 'title', value: e.title ?? '-'),
      DataGridCell<String>(columnName: 'contentRefId', value: e.contentRefId ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as TrainingCourseUnit;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/training/course-units/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
