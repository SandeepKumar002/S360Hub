import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/certifications_repository.dart';
import '../models/certification_model.dart';

class TrainingCertificationDetailPage extends ConsumerWidget {
  final String id;
  const TrainingCertificationDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(trainingCertificationDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/training/certifications/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<TrainingCertification>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('EmployeeId'), subtitle: Text(item.employeeId.toString())),
              ListTile(title: Text('CourseId'), subtitle: Text(item.courseId.toString())),
              ListTile(title: Text('CertificateNo'), subtitle: Text(item.certificateNo.toString())),
              ListTile(title: Text('IssueDate'), subtitle: Text(item.issueDate.toString())),
              ListTile(title: Text('ExpiryDate'), subtitle: Text(item.expiryDate.toString())),
              ListTile(title: Text('FileId'), subtitle: Text(item.fileId.toString())),
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
