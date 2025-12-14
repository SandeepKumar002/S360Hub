import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/hot_prospects_repository.dart';
import '../models/hot_prospect_model.dart';

class LedgieHotProspectDashboardPage extends ConsumerWidget {
  const LedgieHotProspectDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(ledgieHotProspectListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('HotPropects (Ledgie)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/ledgie/hot-prospects/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<LedgieHotProspect>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: LedgieHotProspectDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'companyName', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('CompanyName'))),
              GridColumn(columnName: 'entityStatus', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('EntityStatus'))),
              GridColumn(columnName: 'leadPriority', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('LeadPriority'))),
            ],
          );
        },
      ),
    );
  }
}

class LedgieHotProspectDataSource extends DataGridSource {
  LedgieHotProspectDataSource(List<LedgieHotProspect> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<LedgieHotProspect>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'companyName', value: e.companyName ?? '-'),
      DataGridCell<String>(columnName: 'entityStatus', value: e.entityStatus ?? '-'),
      DataGridCell<String>(columnName: 'leadPriority', value: e.leadPriority ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as LedgieHotProspect;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/ledgie/hot-prospects/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
