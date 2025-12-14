import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/entities_repository.dart';
import '../models/entitie_model.dart';

class LedgieEntitieDashboardPage extends ConsumerWidget {
  const LedgieEntitieDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(ledgieEntitieListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Entities (Ledgie)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/ledgie/entities/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<LedgieEntitie>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: LedgieEntitieDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'entityCode', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('EntityCode'))),
              GridColumn(columnName: 'name', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Name'))),
              GridColumn(columnName: 'type', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Type'))),
            ],
          );
        },
      ),
    );
  }
}

class LedgieEntitieDataSource extends DataGridSource {
  LedgieEntitieDataSource(List<LedgieEntitie> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<LedgieEntitie>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'entityCode', value: e.entityCode ?? '-'),
      DataGridCell<String>(columnName: 'name', value: e.name ?? '-'),
      DataGridCell<String>(columnName: 'type', value: e.type ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as LedgieEntitie;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/ledgie/entities/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
