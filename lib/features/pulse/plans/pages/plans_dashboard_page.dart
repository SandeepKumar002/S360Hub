import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/plans_repository.dart';
import '../models/plan_model.dart';

class PlansDashboardPage extends ConsumerWidget {
  const PlansDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(plansListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription Plans'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/pulse/plans/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<SubscriptionPlan>>(
        value: plansAsync,
        data: (plans) {
          return SfDataGrid(
            source: PlanDataSource(plans, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'name', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Name'))),
              GridColumn(columnName: 'price', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Price'))),
              GridColumn(columnName: 'cycle', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Cycle'))),
              GridColumn(columnName: 'limits', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Limits'))),
            ],
          );
        },
      ),
    );
  }
}

class PlanDataSource extends DataGridSource {
  PlanDataSource(List<SubscriptionPlan> plans, this.context) {
    _dataGridRows = plans.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<SubscriptionPlan>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'name', value: e.displayName),
      DataGridCell<String>(columnName: 'price', value: '\$${e.price}'),
      DataGridCell<String>(columnName: 'cycle', value: e.billingCycle),
      DataGridCell<String>(columnName: 'limits', value: '${e.seatsLimit} Users / ${e.storageLimitGb} GB'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final plan = row.getCells().first.value as SubscriptionPlan;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/pulse/plans/${plan.id}/edit'), // Direct edit for plans
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
