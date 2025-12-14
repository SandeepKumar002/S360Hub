import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/files_repository.dart';
import '../models/file_model.dart';

class LedgieFileDashboardPage extends ConsumerWidget {
  const LedgieFileDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(ledgieFileListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Files (Ledgie)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/ledgie/files/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<LedgieFile>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: LedgieFileDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'referenceTable', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ReferenceTable'))),
              GridColumn(columnName: 'referenceId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ReferenceId'))),
              GridColumn(columnName: 'fileType', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('FileType'))),
            ],
          );
        },
      ),
    );
  }
}

class LedgieFileDataSource extends DataGridSource {
  LedgieFileDataSource(List<LedgieFile> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<LedgieFile>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'referenceTable', value: e.referenceTable ?? '-'),
      DataGridCell<String>(columnName: 'referenceId', value: e.referenceId ?? '-'),
      DataGridCell<String>(columnName: 'fileType', value: e.fileType ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as LedgieFile;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/ledgie/files/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
