import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/ppe_issued_repository.dart';
import '../models/ppe_issued_model.dart';

class ShieldPpeIssuedDetailPage extends ConsumerWidget {
  final String id;
  const ShieldPpeIssuedDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(shieldPpeIssuedDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/shield/ppe-issued/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<ShieldPpeIssued>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('EmployeeId'), subtitle: Text(item.employeeId.toString())),
              ListTile(title: Text('PpeType'), subtitle: Text(item.ppeType.toString())),
              ListTile(title: Text('PpeDescription'), subtitle: Text(item.ppeDescription.toString())),
              ListTile(title: Text('Quantity'), subtitle: Text(item.quantity.toString())),
              ListTile(title: Text('IssueDate'), subtitle: Text(item.issueDate.toString())),
              ListTile(title: Text('ExpectedReturnDate'), subtitle: Text(item.expectedReturnDate.toString())),
              ListTile(title: Text('IssuedBy'), subtitle: Text(item.issuedBy.toString())),
              ListTile(title: Text('AcknowledgementFileId'), subtitle: Text(item.acknowledgementFileId.toString())),
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
