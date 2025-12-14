import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/journal_entries_repository.dart';
import '../models/journal_entrie_model.dart';

class FinacJournalEntrieDashboardPage extends ConsumerWidget {
  const FinacJournalEntrieDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(finacJournalEntrieListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('JournalEntries (Finac)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/finac/journal-entries/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<FinacJournalEntrie>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: FinacJournalEntrieDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'journalNumber', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('JournalNumber'))),
              GridColumn(columnName: 'journalDate', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('JournalDate'))),
              GridColumn(columnName: 'entryType', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('EntryType'))),
            ],
          );
        },
      ),
    );
  }
}

class FinacJournalEntrieDataSource extends DataGridSource {
  FinacJournalEntrieDataSource(List<FinacJournalEntrie> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<FinacJournalEntrie>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'journalNumber', value: e.journalNumber ?? '-'),
      DataGridCell<String>(columnName: 'journalDate', value: e.journalDate?.toString().split(' ')[0] ?? '-'),
      DataGridCell<String>(columnName: 'entryType', value: e.entryType ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as FinacJournalEntrie;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/finac/journal-entries/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
