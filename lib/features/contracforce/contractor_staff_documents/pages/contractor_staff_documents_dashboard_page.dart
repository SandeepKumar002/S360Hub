import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/contractor_staff_documents_repository.dart';
import '../models/contractor_staff_document_model.dart';

class ContracforceContractorStaffDocumentDashboardPage extends ConsumerWidget {
  const ContracforceContractorStaffDocumentDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(contracforceContractorStaffDocumentListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ContractorStaffDocuments (Contracforce)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/contracforce/contractor-staff-documents/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<ContracforceContractorStaffDocument>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: ContracforceContractorStaffDocumentDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'contractorStaffId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ContractorStaffId'))),
              GridColumn(columnName: 'documentType', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('DocumentType'))),
              GridColumn(columnName: 'documentFileId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('DocumentFileId'))),
            ],
          );
        },
      ),
    );
  }
}

class ContracforceContractorStaffDocumentDataSource extends DataGridSource {
  ContracforceContractorStaffDocumentDataSource(List<ContracforceContractorStaffDocument> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<ContracforceContractorStaffDocument>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'contractorStaffId', value: e.contractorStaffId ?? '-'),
      DataGridCell<String>(columnName: 'documentType', value: e.documentType ?? '-'),
      DataGridCell<String>(columnName: 'documentFileId', value: e.documentFileId ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as ContracforceContractorStaffDocument;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/contracforce/contractor-staff-documents/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
