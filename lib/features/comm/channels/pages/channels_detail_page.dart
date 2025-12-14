import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/channels_repository.dart';
import '../models/channel_model.dart';

class CommChannelDetailPage extends ConsumerWidget {
  final String id;
  const CommChannelDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(commChannelDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/comm/channels/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<CommChannel>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('Name'), subtitle: Text(item.name.toString())),
              ListTile(title: Text('Type'), subtitle: Text(item.type.toString())),
              ListTile(title: Text('CreatedAt'), subtitle: Text(item.createdAt.toString())),
              ListTile(title: Text('CreatedBy'), subtitle: Text(item.createdBy.toString())),
            ],
          );
        },
      ),
    );
  }
}
