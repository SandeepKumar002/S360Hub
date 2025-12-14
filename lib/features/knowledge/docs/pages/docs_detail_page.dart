import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/docs_repository.dart';
import '../models/doc_model.dart';

class KnowledgeDocDetailPage extends ConsumerWidget {
  final String id;
  const KnowledgeDocDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(knowledgeDocDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/knowledge/docs/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<KnowledgeDoc>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('Title'), subtitle: Text(item.title.toString())),
              ListTile(title: Text('Slug'), subtitle: Text(item.slug.toString())),
              ListTile(title: Text('Content'), subtitle: Text(item.content.toString())),
              ListTile(title: Text('DocType'), subtitle: Text(item.docType.toString())),
              ListTile(title: Text('Status'), subtitle: Text(item.status.toString())),
              ListTile(title: Text('Tags'), subtitle: Text(item.tags.toString())),
              ListTile(title: Text('Metadata'), subtitle: Text(item.metadata.toString())),
              ListTile(title: Text('CreatedAt'), subtitle: Text(item.createdAt.toString())),
              ListTile(title: Text('CreatedBy'), subtitle: Text(item.createdBy.toString())),
              ListTile(title: Text('UpdatedAt'), subtitle: Text(item.updatedAt.toString())),
              ListTile(title: Text('UpdatedBy'), subtitle: Text(item.updatedBy.toString())),
            ],
          );
        },
      ),
    );
  }
}
