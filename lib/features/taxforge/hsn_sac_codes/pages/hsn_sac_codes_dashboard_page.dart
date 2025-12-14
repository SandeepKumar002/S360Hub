import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/hsn_sac_codes_repository.dart';
import '../models/hsn_sac_code_model.dart';

class TaxforgeHsnSacCodeDashboardPage extends ConsumerWidget {
  const TaxforgeHsnSacCodeDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(taxforgeHsnSacCodeListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('HnSacCodes (Taxforge)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/taxforge/hsn-sac-codes/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<TaxforgeHsnSacCode>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: TaxforgeHsnSacCodeDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'code', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Code'))),
              GridColumn(columnName: 'type', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Type'))),
              GridColumn(columnName: 'description', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Description'))),
            ],
          );
        },
      ),
    );
  }
}

class TaxforgeHsnSacCodeDataSource extends DataGridSource {
  TaxforgeHsnSacCodeDataSource(List<TaxforgeHsnSacCode> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<TaxforgeHsnSacCode>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'code', value: e.code ?? '-'),
      DataGridCell<String>(columnName: 'type', value: e.type ?? '-'),
      DataGridCell<String>(columnName: 'description', value: e.description ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as TaxforgeHsnSacCode;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/taxforge/hsn-sac-codes/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
