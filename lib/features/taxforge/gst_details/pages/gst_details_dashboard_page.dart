import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/gst_details_repository.dart';
import '../models/gst_detail_model.dart';

class TaxforgeGstDetailDashboardPage extends ConsumerWidget {
  const TaxforgeGstDetailDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(taxforgeGstDetailListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GtDetails (Taxforge)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/taxforge/gst-details/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<TaxforgeGstDetail>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: TaxforgeGstDetailDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'partyType', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('PartyType'))),
              GridColumn(columnName: 'partyId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('PartyId'))),
              GridColumn(columnName: 'gstin', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Gstin'))),
            ],
          );
        },
      ),
    );
  }
}

class TaxforgeGstDetailDataSource extends DataGridSource {
  TaxforgeGstDetailDataSource(List<TaxforgeGstDetail> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<TaxforgeGstDetail>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'partyType', value: e.partyType ?? '-'),
      DataGridCell<String>(columnName: 'partyId', value: e.partyId ?? '-'),
      DataGridCell<String>(columnName: 'gstin', value: e.gstin ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as TaxforgeGstDetail;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/taxforge/gst-details/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
