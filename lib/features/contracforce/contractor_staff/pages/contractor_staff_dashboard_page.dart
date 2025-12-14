import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/contractor_staff_repository.dart';
import '../models/contractor_staff_model.dart';

class ContracforceContractorStaffDashboardPage extends ConsumerWidget {
  const ContracforceContractorStaffDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(contracforceContractorStaffListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ContractorStaffs (Contracforce)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/contracforce/contractor-staff/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<ContracforceContractorStaff>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: ContracforceContractorStaffDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'contractorId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ContractorId'))),
              GridColumn(columnName: 'staffCode', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('StaffCode'))),
              GridColumn(columnName: 'fullName', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('FullName'))),
            ],
          );
        },
      ),
    );
  }
}

class ContracforceContractorStaffDataSource extends DataGridSource {
  ContracforceContractorStaffDataSource(List<ContracforceContractorStaff> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<ContracforceContractorStaff>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'contractorId', value: e.contractorId ?? '-'),
      DataGridCell<String>(columnName: 'staffCode', value: e.staffCode ?? '-'),
      DataGridCell<String>(columnName: 'fullName', value: e.fullName ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as ContracforceContractorStaff;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/contracforce/contractor-staff/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
