import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/agreements_repository.dart';
import '../models/agreement_model.dart';

class LedgieAgreementDashboardPage extends ConsumerWidget {
  const LedgieAgreementDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(ledgieAgreementListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agreements (Ledgie)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/ledgie/agreements/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<LedgieAgreement>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: LedgieAgreementDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'entityId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('EntityId'))),
              GridColumn(columnName: 'agreementType', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('AgreementType'))),
              GridColumn(columnName: 'agreementNumber', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('AgreementNumber'))),
            ],
          );
        },
      ),
    );
  }
}

class LedgieAgreementDataSource extends DataGridSource {
  LedgieAgreementDataSource(List<LedgieAgreement> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<LedgieAgreement>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'entityId', value: e.entityId ?? '-'),
      DataGridCell<String>(columnName: 'agreementType', value: e.agreementType ?? '-'),
      DataGridCell<String>(columnName: 'agreementNumber', value: e.agreementNumber ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as LedgieAgreement;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/ledgie/agreements/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
