import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/lms_settings_repository.dart';
import '../models/lms_setting_model.dart';

class TrainingLmsSettingDetailPage extends ConsumerWidget {
  final String id;
  const TrainingLmsSettingDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(trainingLmsSettingDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/training/lms-settings/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<TrainingLmsSetting>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('Rules'), subtitle: Text(item.rules.toString())),
              ListTile(title: Text('ReassignPolicy'), subtitle: Text(item.reassignPolicy.toString())),
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
