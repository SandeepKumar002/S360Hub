import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/contractor_compliance_documents_repository.dart';
import '../models/contractor_compliance_document_model.dart';

class ContracforceContractorComplianceDocumentDashboardPage extends ConsumerWidget {
  const ContracforceContractorComplianceDocumentDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(contracforceContractorComplianceDocumentListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ContractorComplianceDocuments (Contracforce)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/contracforce/contractor-compliance-documents/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<ContracforceContractorComplianceDocument>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: ContracforceContractorComplianceDocumentDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'contractorId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('ContractorId'))),
              GridColumn(columnName: 'documentType', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('DocumentType'))),
              GridColumn(columnName: 'documentNumber', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('DocumentNumber'))),
            ],
          );
        },
      ),
    );
  }
}

class ContracforceContractorComplianceDocumentDataSource extends DataGridSource {
  ContracforceContractorComplianceDocumentDataSource(List<ContracforceContractorComplianceDocument> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<ContracforceContractorComplianceDocument>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'contractorId', value: e.contractorId ?? '-'),
      DataGridCell<String>(columnName: 'documentType', value: e.documentType ?? '-'),
      DataGridCell<String>(columnName: 'documentNumber', value: e.documentNumber ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as ContracforceContractorComplianceDocument;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/contracforce/contractor-compliance-documents/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
