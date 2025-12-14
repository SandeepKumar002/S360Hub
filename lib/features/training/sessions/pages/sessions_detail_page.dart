import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/sessions_repository.dart';
import '../models/session_model.dart';

class TrainingSessionDetailPage extends ConsumerWidget {
  final String id;
  const TrainingSessionDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(trainingSessionDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/training/sessions/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<TrainingSession>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('CourseId'), subtitle: Text(item.courseId.toString())),
              ListTile(title: Text('SessionDateStart'), subtitle: Text(item.sessionDateStart.toString())),
              ListTile(title: Text('SessionDateEnd'), subtitle: Text(item.sessionDateEnd.toString())),
              ListTile(title: Text('InstructorId'), subtitle: Text(item.instructorId.toString())),
              ListTile(title: Text('Location'), subtitle: Text(item.location.toString())),
              ListTile(title: Text('MaxSeats'), subtitle: Text(item.maxSeats.toString())),
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
