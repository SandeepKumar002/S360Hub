import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/support_repository.dart';
import '../models/support_models.dart';

class CommentsDashboardPage extends ConsumerWidget {
  const CommentsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentsAsync = ref.watch(commentsTrackerListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Global Comments Tracker')),
      body: AsyncValueWidget<List<Comment>>(
        value: commentsAsync,
        data: (comments) {
             if (comments.isEmpty) return const Center(child: Text('No comments found'));
             return ListView.separated(
                 itemCount: comments.length,
                 separatorBuilder: (context, index) => const Divider(),
                 itemBuilder: (context, index) {
                     final c = comments[index];
                     return ListTile(
                         title: Text(c.content),
                         subtitle: Text('By: ${c.userId ?? "Anonymous"} at ${c.createdAt}'),
                     );
                 },
             );
        },
      ),
    );
  }
}
