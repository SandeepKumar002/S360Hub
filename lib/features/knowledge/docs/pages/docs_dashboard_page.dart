import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/docs_repository.dart';
import '../models/doc_model.dart';

class KnowledgeDocDashboardPage extends ConsumerWidget {
  const KnowledgeDocDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(knowledgeDocListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Docs (Knowledge)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/knowledge/docs/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<KnowledgeDoc>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: KnowledgeDocDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'title', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Title'))),
              GridColumn(columnName: 'slug', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Slug'))),
              GridColumn(columnName: 'content', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Content'))),
            ],
          );
        },
      ),
    );
  }
}

class KnowledgeDocDataSource extends DataGridSource {
  KnowledgeDocDataSource(List<KnowledgeDoc> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<KnowledgeDoc>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'title', value: e.title ?? '-'),
      DataGridCell<String>(columnName: 'slug', value: e.slug ?? '-'),
      DataGridCell<String>(columnName: 'content', value: e.content?.toString() ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as KnowledgeDoc;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/knowledge/docs/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
