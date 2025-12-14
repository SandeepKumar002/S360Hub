import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/doc_versions_repository.dart';
import '../models/doc_version_model.dart';

class KnowledgeDocVersionDetailPage extends ConsumerWidget {
  final String id;
  const KnowledgeDocVersionDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(knowledgeDocVersionDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/knowledge/doc-versions/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<KnowledgeDocVersion>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('DocId'), subtitle: Text(item.docId.toString())),
              ListTile(title: Text('VersionNo'), subtitle: Text(item.versionNo.toString())),
              ListTile(title: Text('Content'), subtitle: Text(item.content.toString())),
              ListTile(title: Text('ChangedBy'), subtitle: Text(item.changedBy.toString())),
              ListTile(title: Text('ChangedAt'), subtitle: Text(item.changedAt.toString())),
              ListTile(title: Text('Notes'), subtitle: Text(item.notes.toString())),
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
