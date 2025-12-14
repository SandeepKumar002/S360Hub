import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/doc_access_control_repository.dart';
import '../models/doc_access_control_model.dart';

class KnowledgeDocAccessControlDashboardPage extends ConsumerWidget {
  const KnowledgeDocAccessControlDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(knowledgeDocAccessControlListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DocAcceControls (Knowledge)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/knowledge/doc-access-control/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<KnowledgeDocAccessControl>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: KnowledgeDocAccessControlDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'docId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('DocId'))),
              GridColumn(columnName: 'roleCode', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('RoleCode'))),
              GridColumn(columnName: 'personId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('PersonId'))),
            ],
          );
        },
      ),
    );
  }
}

class KnowledgeDocAccessControlDataSource extends DataGridSource {
  KnowledgeDocAccessControlDataSource(List<KnowledgeDocAccessControl> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<KnowledgeDocAccessControl>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'docId', value: e.docId ?? '-'),
      DataGridCell<String>(columnName: 'roleCode', value: e.roleCode ?? '-'),
      DataGridCell<String>(columnName: 'personId', value: e.personId ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as KnowledgeDocAccessControl;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/knowledge/doc-access-control/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
