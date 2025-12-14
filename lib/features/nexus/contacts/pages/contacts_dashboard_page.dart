import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/contacts_repository.dart';
import '../models/contact_models.dart';

class ContactsDashboardPage extends ConsumerWidget {
  const ContactsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsAsync = ref.watch(contactsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/nexus/contacts/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<Contact>>(
        value: contactsAsync,
        data: (contacts) {
          return SfDataGrid(
            source: ContactDataSource(contacts, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(
                  columnName: 'name',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: const Text('Name'))),
              GridColumn(
                  columnName: 'phone',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: const Text('Phone'))),
               GridColumn(
                  columnName: 'type',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: const Text('Type'))),
            ],
          );
        },
      ),
    );
  }
}

class ContactDataSource extends DataGridSource {
  ContactDataSource(List<Contact> contacts, this.context) {
    _dataGridRows = contacts
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<Contact>(columnName: 'obj', value: e),
              DataGridCell<String>(columnName: 'name', value: e.name ?? '-'),
              DataGridCell<String>(columnName: 'phone', value: e.phone ?? '-'),
              DataGridCell<String>(columnName: 'type', value: e.contactType ?? '-'),
            ]))
        .toList();
  }

  late List<DataGridRow> _dataGridRows;
  final BuildContext context;

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final contact = row.getCells().first.value as Contact;

    return DataGridRowAdapter(
      cells: row.getCells().skip(1).map<Widget>((dataGridCell) {
        return GestureDetector(
          onTap: () => context.push('/nexus/contacts/${contact.id}'),
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
