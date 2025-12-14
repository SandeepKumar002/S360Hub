import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/training_materials_repository.dart';
import '../models/training_material_model.dart';

class TrainingTrainingMaterialDashboardPage extends ConsumerWidget {
  const TrainingTrainingMaterialDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(trainingTrainingMaterialListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TrainingMaterials (Training)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/training/training-materials/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<TrainingTrainingMaterial>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: TrainingTrainingMaterialDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'courseId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('CourseId'))),
              GridColumn(columnName: 'fileId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('FileId'))),
              GridColumn(columnName: 'materialType', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('MaterialType'))),
            ],
          );
        },
      ),
    );
  }
}

class TrainingTrainingMaterialDataSource extends DataGridSource {
  TrainingTrainingMaterialDataSource(List<TrainingTrainingMaterial> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<TrainingTrainingMaterial>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'courseId', value: e.courseId ?? '-'),
      DataGridCell<String>(columnName: 'fileId', value: e.fileId ?? '-'),
      DataGridCell<String>(columnName: 'materialType', value: e.materialType ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as TrainingTrainingMaterial;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/training/training-materials/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
