import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/journal_entry_lines_repository.dart';
import '../models/journal_entry_line_model.dart';

class FinacJournalEntryLineDashboardPage extends ConsumerWidget {
  const FinacJournalEntryLineDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(finacJournalEntryLineListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('JournalEntryLines (Finac)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/finac/journal-entry-lines/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<FinacJournalEntryLine>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: FinacJournalEntryLineDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'journalEntryId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('JournalEntryId'))),
              GridColumn(columnName: 'lineNumber', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('LineNumber'))),
              GridColumn(columnName: 'accountCode', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('AccountCode'))),
            ],
          );
        },
      ),
    );
  }
}

class FinacJournalEntryLineDataSource extends DataGridSource {
  FinacJournalEntryLineDataSource(List<FinacJournalEntryLine> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<FinacJournalEntryLine>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'journalEntryId', value: e.journalEntryId ?? '-'),
      DataGridCell<String>(columnName: 'lineNumber', value: e.lineNumber?.toString() ?? '-'),
      DataGridCell<String>(columnName: 'accountCode', value: e.accountCode ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as FinacJournalEntryLine;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/finac/journal-entry-lines/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
