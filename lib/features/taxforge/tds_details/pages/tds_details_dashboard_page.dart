import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/tds_details_repository.dart';
import '../models/tds_detail_model.dart';

class TaxforgeTdsDetailDashboardPage extends ConsumerWidget {
  const TaxforgeTdsDetailDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(taxforgeTdsDetailListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TdDetails (Taxforge)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/taxforge/tds-details/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<TaxforgeTdsDetail>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: TaxforgeTdsDetailDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'partyType', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('PartyType'))),
              GridColumn(columnName: 'partyId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('PartyId'))),
              GridColumn(columnName: 'sectionCode', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('SectionCode'))),
            ],
          );
        },
      ),
    );
  }
}

class TaxforgeTdsDetailDataSource extends DataGridSource {
  TaxforgeTdsDetailDataSource(List<TaxforgeTdsDetail> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<TaxforgeTdsDetail>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'partyType', value: e.partyType ?? '-'),
      DataGridCell<String>(columnName: 'partyId', value: e.partyId ?? '-'),
      DataGridCell<String>(columnName: 'sectionCode', value: e.sectionCode ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as TaxforgeTdsDetail;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/taxforge/tds-details/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
