import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/module_role_assignments_repository.dart';
import '../models/module_role_assignment_model.dart';

class TrainingModuleRoleAssignmentDetailPage extends ConsumerWidget {
  final String id;
  const TrainingModuleRoleAssignmentDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(trainingModuleRoleAssignmentDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/training/module-role-assignments/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<TrainingModuleRoleAssignment>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('RoleId'), subtitle: Text(item.roleId.toString())),
              ListTile(title: Text('PersonId'), subtitle: Text(item.personId.toString())),
              ListTile(title: Text('TeamId'), subtitle: Text(item.teamId.toString())),
              ListTile(title: Text('Scope'), subtitle: Text(item.scope.toString())),
              ListTile(title: Text('Active'), subtitle: Text(item.active.toString())),
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
