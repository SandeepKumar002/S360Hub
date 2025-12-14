import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/entity_contacts_repository.dart';
import '../models/entity_contact_model.dart';

class LedgieEntityContactDashboardPage extends ConsumerWidget {
  const LedgieEntityContactDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(ledgieEntityContactListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('EntityContacts (Ledgie)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/ledgie/entity-contacts/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<LedgieEntityContact>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: LedgieEntityContactDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'entityId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('EntityId'))),
              GridColumn(columnName: 'contactId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ContactId'))),
              GridColumn(columnName: 'role', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Role'))),
            ],
          );
        },
      ),
    );
  }
}

class LedgieEntityContactDataSource extends DataGridSource {
  LedgieEntityContactDataSource(List<LedgieEntityContact> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<LedgieEntityContact>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'entityId', value: e.entityId ?? '-'),
      DataGridCell<String>(columnName: 'contactId', value: e.contactId ?? '-'),
      DataGridCell<String>(columnName: 'role', value: e.role ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as LedgieEntityContact;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/ledgie/entity-contacts/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
