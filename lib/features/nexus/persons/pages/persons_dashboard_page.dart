import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:intl/intl.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/persons_repository.dart';
import '../models/person_model.dart';

class PersonsDashboardPage extends ConsumerWidget {
  const PersonsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personsAsync = ref.watch(personsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Persons'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/nexus/persons/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<Person>>(
        value: personsAsync,
        data: (persons) {
          return SfDataGrid(
            source: PersonDataSource(persons, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60, // Comfortable row height
            columns: [
              GridColumn(
                columnName: 'name',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: const Text('Name', overflow: TextOverflow.ellipsis),
                ),
              ),
              GridColumn(
                columnName: 'email',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: const Text('Email', overflow: TextOverflow.ellipsis),
                ),
              ),
              GridColumn(
                columnName: 'phone',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: const Text('Phone', overflow: TextOverflow.ellipsis),
                ),
              ),
              GridColumn(
                columnName: 'created_at',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: const Text('Joined', overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PersonDataSource extends DataGridSource {
  PersonDataSource(List<Person> persons, this.context) {
    _dataGridRows = persons
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<Person>(columnName: 'obj', value: e), // Store object for navigation
              DataGridCell<String>(columnName: 'name', value: e.displayName),
              DataGridCell<String>(columnName: 'email', value: e.email ?? '-'),
              DataGridCell<String>(columnName: 'phone', value: e.phone ?? '-'),
              DataGridCell<DateTime>(columnName: 'created_at', value: e.createdAt),
            ]))
        .toList();
  }

  late List<DataGridRow> _dataGridRows;
  final BuildContext context;

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final person = row.getCells().first.value as Person; // Retrieved from hidden cell or mapping needed?
    // DataGridCell holds the value. Using index mapping or custom cell logic.
    // Simplifying: accessing cells by index is safer with DataGridRow.
    
    // Workaround: We can't easily perform "onRowClick" with basic SfDataGrid unless we wrap row or use controller.
    // However, SfDataGrid allows selection. 
    // Implementing GestureDetector on cell content for now, or using onCellTap callback of Grid.
    // But buildRow needs to return Widget.
    
    return DataGridRowAdapter(
      cells: row.getCells().skip(1).map<Widget>((dataGridCell) {
        return GestureDetector(
          onTap: () => context.push('/nexus/persons/${person.id}'),
          behavior: HitTestBehavior.opaque,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              dataGridCell.value is DateTime
                  ? DateFormat.yMMMd().format(dataGridCell.value)
                  : dataGridCell.value.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList(),
    );
  }
}
