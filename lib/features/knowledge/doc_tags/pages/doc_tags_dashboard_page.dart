import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/doc_tags_repository.dart';
import '../models/doc_tag_model.dart';

class KnowledgeDocTagDashboardPage extends ConsumerWidget {
  const KnowledgeDocTagDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(knowledgeDocTagListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DocTags (Knowledge)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/knowledge/doc-tags/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<KnowledgeDocTag>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: KnowledgeDocTagDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'name', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Name'))),
              GridColumn(columnName: 'updatedBy', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('UpdatedBy'))),
              GridColumn(columnName: 'approvedAt', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ApprovedAt'))),
            ],
          );
        },
      ),
    );
  }
}

class KnowledgeDocTagDataSource extends DataGridSource {
  KnowledgeDocTagDataSource(List<KnowledgeDocTag> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<KnowledgeDocTag>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'name', value: e.name ?? '-'),
      DataGridCell<String>(columnName: 'updatedBy', value: e.updatedBy ?? '-'),
      DataGridCell<String>(columnName: 'approvedAt', value: e.approvedAt?.toString().split(' ')[0] ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as KnowledgeDocTag;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/knowledge/doc-tags/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
