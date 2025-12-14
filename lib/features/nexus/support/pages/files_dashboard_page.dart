import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/support_repository.dart';
import '../models/support_models.dart';

class FilesDashboardPage extends ConsumerWidget {
  const FilesDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filesAsync = ref.watch(nexusFilesListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Files')),
      body: AsyncValueWidget<List<NexusFile>>(
        value: filesAsync,
        data: (files) {
          if (files.isEmpty) return const Center(child: Text('No files uploaded'));
          return SfDataGrid(
              source: FileDataSource(files),
              columnWidthMode: ColumnWidthMode.fill,
              columns: [
                  GridColumn(columnName: 'name', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Name'))),
                  GridColumn(columnName: 'type', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Type'))),
                  GridColumn(columnName: 'size', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Size'))),
              ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            // Mock upload
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('File Upload implementation is pending storage setup')));
        },
        child: const Icon(Icons.upload_file),
      ),
    );
  }
}

class FileDataSource extends DataGridSource {
  FileDataSource(List<NexusFile> files) {
    _dataGridRows = files.map<DataGridRow>((e) => DataGridRow(cells: [
        DataGridCell<String>(columnName: 'name', value: e.fileName),
        DataGridCell<String>(columnName: 'type', value: e.fileType ?? 'Unknown'),
        DataGridCell<String>(columnName: 'size', value: '${(e.fileSize / 1024).toStringAsFixed(1)} KB'),
    ])).toList();
  }
  late List<DataGridRow> _dataGridRows;
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
      return DataGridRowAdapter(cells: row.getCells().map<Widget>((e) {
          return Container(alignment: Alignment.centerLeft, padding: const EdgeInsets.all(8), child: Text(e.value.toString()));
      }).toList());
  }
}
