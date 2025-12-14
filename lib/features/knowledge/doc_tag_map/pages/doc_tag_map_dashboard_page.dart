import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/doc_tag_map_repository.dart';
import '../models/doc_tag_map_model.dart';

class KnowledgeDocTagMapDashboardPage extends ConsumerWidget {
  const KnowledgeDocTagMapDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(knowledgeDocTagMapListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DocTagMaps (Knowledge)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/knowledge/doc-tag-map/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<KnowledgeDocTagMap>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: KnowledgeDocTagMapDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'docId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('DocId'))),
              GridColumn(columnName: 'tagId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('TagId'))),
              GridColumn(columnName: 'updatedBy', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('UpdatedBy'))),
            ],
          );
        },
      ),
    );
  }
}

class KnowledgeDocTagMapDataSource extends DataGridSource {
  KnowledgeDocTagMapDataSource(List<KnowledgeDocTagMap> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<KnowledgeDocTagMap>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'docId', value: e.docId ?? '-'),
      DataGridCell<String>(columnName: 'tagId', value: e.tagId ?? '-'),
      DataGridCell<String>(columnName: 'updatedBy', value: e.updatedBy ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as KnowledgeDocTagMap;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/knowledge/doc-tag-map/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
