import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/doc_versions_repository.dart';
import '../models/doc_version_model.dart';

class KnowledgeDocVersionDashboardPage extends ConsumerWidget {
  const KnowledgeDocVersionDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(knowledgeDocVersionListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DocVerions (Knowledge)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/knowledge/doc-versions/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<KnowledgeDocVersion>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: KnowledgeDocVersionDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'docId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('DocId'))),
              GridColumn(columnName: 'versionNo', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('VersionNo'))),
              GridColumn(columnName: 'content', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Content'))),
            ],
          );
        },
      ),
    );
  }
}

class KnowledgeDocVersionDataSource extends DataGridSource {
  KnowledgeDocVersionDataSource(List<KnowledgeDocVersion> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<KnowledgeDocVersion>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'docId', value: e.docId ?? '-'),
      DataGridCell<String>(columnName: 'versionNo', value: e.versionNo?.toString() ?? '-'),
      DataGridCell<String>(columnName: 'content', value: e.content?.toString() ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as KnowledgeDocVersion;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/knowledge/doc-versions/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
