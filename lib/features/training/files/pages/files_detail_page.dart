import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/files_repository.dart';
import '../models/file_model.dart';

class TrainingFileDetailPage extends ConsumerWidget {
  final String id;
  const TrainingFileDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(trainingFileDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/training/files/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<TrainingFile>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('ReferenceTable'), subtitle: Text(item.referenceTable.toString())),
              ListTile(title: Text('ReferenceId'), subtitle: Text(item.referenceId.toString())),
              ListTile(title: Text('FileType'), subtitle: Text(item.fileType.toString())),
              ListTile(title: Text('FileName'), subtitle: Text(item.fileName.toString())),
              ListTile(title: Text('StoragePath'), subtitle: Text(item.storagePath.toString())),
              ListTile(title: Text('ContentType'), subtitle: Text(item.contentType.toString())),
              ListTile(title: Text('SizeBytes'), subtitle: Text(item.sizeBytes.toString())),
              ListTile(title: Text('UploadedBy'), subtitle: Text(item.uploadedBy.toString())),
              ListTile(title: Text('UploadedAt'), subtitle: Text(item.uploadedAt.toString())),
              ListTile(title: Text('IsDeleted'), subtitle: Text(item.isDeleted.toString())),
              ListTile(title: Text('DeletedAt'), subtitle: Text(item.deletedAt.toString())),
              ListTile(title: Text('DeletedBy'), subtitle: Text(item.deletedBy.toString())),
              ListTile(title: Text('DeleteType'), subtitle: Text(item.deleteType.toString())),
              ListTile(title: Text('DeleteReason'), subtitle: Text(item.deleteReason.toString())),
              ListTile(title: Text('RestoreReason'), subtitle: Text(item.restoreReason.toString())),
              ListTile(title: Text('RestoredAt'), subtitle: Text(item.restoredAt.toString())),
              ListTile(title: Text('RestoredBy'), subtitle: Text(item.restoredBy.toString())),
              ListTile(title: Text('DeletionScheduledAt'), subtitle: Text(item.deletionScheduledAt.toString())),
              ListTile(title: Text('PermanentDeletionDate'), subtitle: Text(item.permanentDeletionDate.toString())),
              ListTile(title: Text('DeletionCount'), subtitle: Text(item.deletionCount.toString())),
              ListTile(title: Text('FileVersion'), subtitle: Text(item.fileVersion.toString())),
              ListTile(title: Text('PreviousVersionId'), subtitle: Text(item.previousVersionId.toString())),
              ListTile(title: Text('IsArchived'), subtitle: Text(item.isArchived.toString())),
              ListTile(title: Text('ArchivedAt'), subtitle: Text(item.archivedAt.toString())),
              ListTile(title: Text('ArchivedBy'), subtitle: Text(item.archivedBy.toString())),
              ListTile(title: Text('ArchiveLocation'), subtitle: Text(item.archiveLocation.toString())),
              ListTile(title: Text('Checksum'), subtitle: Text(item.checksum.toString())),
              ListTile(title: Text('Metadata'), subtitle: Text(item.metadata.toString())),
              ListTile(title: Text('CreatedAt'), subtitle: Text(item.createdAt.toString())),
              ListTile(title: Text('CreatedBy'), subtitle: Text(item.createdBy.toString())),
              ListTile(title: Text('UpdatedAt'), subtitle: Text(item.updatedAt.toString())),
              ListTile(title: Text('UpdatedBy'), subtitle: Text(item.updatedBy.toString())),
              ListTile(title: Text('ApprovedAt'), subtitle: Text(item.approvedAt.toString())),
              ListTile(title: Text('ApprovedBy'), subtitle: Text(item.approvedBy.toString())),
            ],
          );
        },
      ),
    );
  }
}
