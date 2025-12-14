import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/expense_categories_repository.dart';
import '../models/expense_categorie_model.dart';

class FinacExpenseCategorieDashboardPage extends ConsumerWidget {
  const FinacExpenseCategorieDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(finacExpenseCategorieListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ExpeneCategories (Finac)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/finac/expense-categories/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<FinacExpenseCategorie>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: FinacExpenseCategorieDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'code', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Code'))),
              GridColumn(columnName: 'name', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('Name'))),
              GridColumn(columnName: 'parentCategoryId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ParentCategoryId'))),
            ],
          );
        },
      ),
    );
  }
}

class FinacExpenseCategorieDataSource extends DataGridSource {
  FinacExpenseCategorieDataSource(List<FinacExpenseCategorie> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<FinacExpenseCategorie>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'code', value: e.code ?? '-'),
      DataGridCell<String>(columnName: 'name', value: e.name ?? '-'),
      DataGridCell<String>(columnName: 'parentCategoryId', value: e.parentCategoryId ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as FinacExpenseCategorie;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/finac/expense-categories/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
