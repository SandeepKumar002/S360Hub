import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/addresses_repository.dart';
import '../models/address_models.dart';

class AddressesDashboardPage extends ConsumerWidget {
  const AddressesDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressesAsync = ref.watch(addressesListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Addresses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/nexus/addresses/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<Address>>(
        value: addressesAsync,
        data: (addresses) {
          return SfDataGrid(
            source: AddressDataSource(addresses, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(
                  columnName: 'type',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: const Text('Type'))),
              GridColumn(
                  columnName: 'address',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: const Text('Address'))),
              GridColumn(
                  columnName: 'city',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: const Text('City'))),
            ],
          );
        },
      ),
    );
  }
}

class AddressDataSource extends DataGridSource {
  AddressDataSource(List<Address> addresses, this.context) {
    _dataGridRows = addresses
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<Address>(columnName: 'obj', value: e),
              DataGridCell<String>(columnName: 'type', value: e.addressType ?? 'Unknown'),
              DataGridCell<String>(columnName: 'address', value: e.line1 ?? '-'),
              DataGridCell<String>(columnName: 'city', value: e.city ?? '-'),
            ]))
        .toList();
  }

  late List<DataGridRow> _dataGridRows;
  final BuildContext context;

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final address = row.getCells().first.value as Address;

    return DataGridRowAdapter(
      cells: row.getCells().skip(1).map<Widget>((dataGridCell) {
        return GestureDetector(
          onTap: () => context.push('/nexus/addresses/${address.id}'),
          behavior: HitTestBehavior.opaque,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              dataGridCell.value.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList(),
    );
  }
}
