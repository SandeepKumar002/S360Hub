import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/doc_feedback_repository.dart';
import '../models/doc_feedback_model.dart';

class KnowledgeDocFeedbackDashboardPage extends ConsumerWidget {
  const KnowledgeDocFeedbackDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(knowledgeDocFeedbackListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DocFeedbacks (Knowledge)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/knowledge/doc-feedback/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<KnowledgeDocFeedback>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: KnowledgeDocFeedbackDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'docId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('DocId'))),
              GridColumn(columnName: 'personId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('PersonId'))),
              GridColumn(columnName: 'rating', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Rating'))),
            ],
          );
        },
      ),
    );
  }
}

class KnowledgeDocFeedbackDataSource extends DataGridSource {
  KnowledgeDocFeedbackDataSource(List<KnowledgeDocFeedback> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<KnowledgeDocFeedback>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'docId', value: e.docId ?? '-'),
      DataGridCell<String>(columnName: 'personId', value: e.personId ?? '-'),
      DataGridCell<String>(columnName: 'rating', value: e.rating?.toString() ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as KnowledgeDocFeedback;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/knowledge/doc-feedback/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
