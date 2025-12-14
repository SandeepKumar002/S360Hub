import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/enrollments_repository.dart';
import '../models/enrollment_model.dart';

class TrainingEnrollmentDetailPage extends ConsumerWidget {
  final String id;
  const TrainingEnrollmentDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(trainingEnrollmentDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/training/enrollments/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<TrainingEnrollment>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('SessionId'), subtitle: Text(item.sessionId.toString())),
              ListTile(title: Text('EmployeeId'), subtitle: Text(item.employeeId.toString())),
              ListTile(title: Text('Status'), subtitle: Text(item.status.toString())),
              ListTile(title: Text('Score'), subtitle: Text(item.score.toString())),
              ListTile(title: Text('CompletedAt'), subtitle: Text(item.completedAt.toString())),
              ListTile(title: Text('Feedback'), subtitle: Text(item.feedback.toString())),
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
