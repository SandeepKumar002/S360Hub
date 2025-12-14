import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/safety_incidents_repository.dart';
import '../models/safety_incident_model.dart';

class ShieldSafetyIncidentDashboardPage extends ConsumerWidget {
  const ShieldSafetyIncidentDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(shieldSafetyIncidentListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SafetyIncidents (Shield)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/shield/safety-incidents/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<ShieldSafetyIncident>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: ShieldSafetyIncidentDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'incidentId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('IncidentId'))),
              GridColumn(columnName: 'incidentDate', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('IncidentDate'))),
              GridColumn(columnName: 'location', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Location'))),
            ],
          );
        },
      ),
    );
  }
}

class ShieldSafetyIncidentDataSource extends DataGridSource {
  ShieldSafetyIncidentDataSource(List<ShieldSafetyIncident> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<ShieldSafetyIncident>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'incidentId', value: e.incidentId ?? '-'),
      DataGridCell<String>(columnName: 'incidentDate', value: e.incidentDate?.toString().split(' ')[0] ?? '-'),
      DataGridCell<String>(columnName: 'location', value: e.location ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as ShieldSafetyIncident;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/shield/safety-incidents/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
