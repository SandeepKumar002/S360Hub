import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/grievance_complaints_repository.dart';
import '../models/grievance_complaint_model.dart';

class ShieldGrievanceComplaintDetailPage extends ConsumerWidget {
  final String id;
  const ShieldGrievanceComplaintDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(shieldGrievanceComplaintDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/shield/grievance-complaints/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<ShieldGrievanceComplaint>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('ComplaintId'), subtitle: Text(item.complaintId.toString())),
              ListTile(title: Text('ComplaintType'), subtitle: Text(item.complaintType.toString())),
              ListTile(title: Text('Description'), subtitle: Text(item.description.toString())),
              ListTile(title: Text('ComplaintDate'), subtitle: Text(item.complaintDate.toString())),
              ListTile(title: Text('ComplainantId'), subtitle: Text(item.complainantId.toString())),
              ListTile(title: Text('RespondentId'), subtitle: Text(item.respondentId.toString())),
              ListTile(title: Text('Status'), subtitle: Text(item.status.toString())),
              ListTile(title: Text('AssignedTo'), subtitle: Text(item.assignedTo.toString())),
              ListTile(title: Text('ResolutionDescription'), subtitle: Text(item.resolutionDescription.toString())),
              ListTile(title: Text('ResolutionDate'), subtitle: Text(item.resolutionDate.toString())),
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
