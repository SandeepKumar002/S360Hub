import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/active_prospects_repository.dart';
import '../models/active_prospect_model.dart';

class LedgieActiveProspectDashboardPage extends ConsumerWidget {
  const LedgieActiveProspectDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(ledgieActiveProspectListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ActivePropects (Ledgie)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/ledgie/active-prospects/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<LedgieActiveProspect>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: LedgieActiveProspectDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'entityCode', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('EntityCode'))),
              GridColumn(columnName: 'companyName', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('CompanyName'))),
              GridColumn(columnName: 'entityStatus', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('EntityStatus'))),
            ],
          );
        },
      ),
    );
  }
}

class LedgieActiveProspectDataSource extends DataGridSource {
  LedgieActiveProspectDataSource(List<LedgieActiveProspect> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<LedgieActiveProspect>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'entityCode', value: e.entityCode ?? '-'),
      DataGridCell<String>(columnName: 'companyName', value: e.companyName ?? '-'),
      DataGridCell<String>(columnName: 'entityStatus', value: e.entityStatus ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as LedgieActiveProspect;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/ledgie/active-prospects/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
