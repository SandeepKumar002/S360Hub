import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/contractor_compliance_documents_repository.dart';
import '../models/contractor_compliance_document_model.dart';

class ContracforceContractorComplianceDocumentDetailPage extends ConsumerWidget {
  final String id;
  const ContracforceContractorComplianceDocumentDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(contracforceContractorComplianceDocumentDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/contracforce/contractor-compliance-documents/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<ContracforceContractorComplianceDocument>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('ContractorId'), subtitle: Text(item.contractorId.toString())),
              ListTile(title: Text('DocumentType'), subtitle: Text(item.documentType.toString())),
              ListTile(title: Text('DocumentNumber'), subtitle: Text(item.documentNumber.toString())),
              ListTile(title: Text('IssueDate'), subtitle: Text(item.issueDate.toString())),
              ListTile(title: Text('ExpiryDate'), subtitle: Text(item.expiryDate.toString())),
              ListTile(title: Text('DocumentFileId'), subtitle: Text(item.documentFileId.toString())),
              ListTile(title: Text('Verified'), subtitle: Text(item.verified.toString())),
              ListTile(title: Text('VerifiedBy'), subtitle: Text(item.verifiedBy.toString())),
              ListTile(title: Text('VerifiedDate'), subtitle: Text(item.verifiedDate.toString())),
              ListTile(title: Text('Status'), subtitle: Text(item.status.toString())),
              ListTile(title: Text('Metadata'), subtitle: Text(item.metadata.toString())),
              ListTile(title: Text('CreatedAt'), subtitle: Text(item.createdAt.toString())),
              ListTile(title: Text('CreatedBy'), subtitle: Text(item.createdBy.toString())),
              ListTile(title: Text('UpdatedAt'), subtitle: Text(item.updatedAt.toString())),
              ListTile(title: Text('UpdatedBy'), subtitle: Text(item.updatedBy.toString())),
              ListTile(title: Text('ApprovedAt'), subtitle: Text(item.approvedAt.toString())),
              ListTile(title: Text('ApprovedBy'), subtitle: Text(item.approvedBy.toString())),
              ListTile(title: Text('DeletedAt'), subtitle: Text(item.deletedAt.toString())),
              ListTile(title: Text('DeletedBy'), subtitle: Text(item.deletedBy.toString())),
              ListTile(title: Text('DeleteType'), subtitle: Text(item.deleteType.toString())),
              ListTile(title: Text('IsDeleted'), subtitle: Text(item.isDeleted.toString())),
            ],
          );
        },
      ),
    );
  }
}
