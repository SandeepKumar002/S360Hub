import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/organizations_repository.dart';
import '../models/organization_model.dart';

class OrganizationsDashboardPage extends ConsumerWidget {
  const OrganizationsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgsAsync = ref.watch(organizationsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Organizations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/pulse/organizations/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<Organization>>(
        value: orgsAsync,
        data: (orgs) {
          return SfDataGrid(
            source: OrganizationDataSource(orgs, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'name', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Name'))),
              GridColumn(columnName: 'code', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Code'))),
              GridColumn(columnName: 'status', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Status'))),
              GridColumn(columnName: 'users', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Users'))),
            ],
          );
        },
      ),
    );
  }
}

class OrganizationDataSource extends DataGridSource {
  OrganizationDataSource(List<Organization> orgs, this.context) {
    _dataGridRows = orgs.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<Organization>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'name', value: e.name),
      DataGridCell<String>(columnName: 'code', value: e.code),
      DataGridCell<String>(columnName: 'status', value: e.status ?? '-'),
      DataGridCell<String>(columnName: 'users', value: '${e.activeUserCount}/${e.userCapacity}'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final org = row.getCells().first.value as Organization;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/pulse/organizations/${org.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
